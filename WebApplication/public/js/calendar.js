import { auth, db } from './firebase-config.js';
import { collection, getDocs, query, where, doc, getDoc } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');

    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: ''
        },
        height: '100%',
        dayMaxEventRows: true,
        fixedWeekCount: true,
        selectable: true,
        events: [],
        dateClick: function(info) {
            alert('Clicked on: ' + info.dateStr);
        },
        eventClick: function(info) {   // 🛠️ new code here
            const eventTitle = info.event.title;
            const eventDate = info.event.start.toISOString().split('T')[0];
            alert(`Task: ${eventTitle}\nDate: ${eventDate}`);
        }
    });
    

    calendar.render();

    // Load events after rendering
    auth.onAuthStateChanged(async (user) => {
        if (user) {
            try {
                const manualTasks = await loadTasks(user.uid);
                const inspections = await loadInspections(user.uid);

                const allEvents = [...manualTasks, ...inspections]; // merge
                calendar.addEventSource(allEvents); // add all to calendar
            } catch (error) {
                console.error("Error loading events:", error);
            }
        } else {
            window.location.href = "login.html";
        }
    });
});

// 🛠️ Load manual tasks
async function loadTasks(userId) {
    const events = [];
    try {
        const tasksRef = collection(db, "tasks");
        const q = query(tasksRef, where("phiId", "==", userId));
        const querySnapshot = await getDocs(q);

        querySnapshot.forEach((docSnap) => {
            const task = docSnap.data();
            if (task.date) {
                events.push({
                    title: task.title || "Untitled Task",
                    start: task.date.toDate().toISOString().split('T')[0],
                    color: '#3788d8' // Blue
                });
            }
        });
    } catch (error) {
        console.error("Error loading tasks:", error);
    }
    return events;
}

// 🛠️ Load upcoming inspections
async function loadInspections(userId) {
    const events = [];
    try {
        // First get the PHI user's GN Divisions
        const userDocRef = doc(db, "users", userId);
        const userDocSnap = await getDoc(userDocRef);

        if (!userDocSnap.exists()) {
            console.error("User not found!");
            return [];
        }

        const userData = userDocSnap.data();
        const gnDivisions = userData.gnDivisions || [];

        if (gnDivisions.length === 0) {
            console.log("No GN divisions assigned to this PHI.");
            return [];
        }

        // Now fetch all shops
        const shopsRef = collection(db, "shops");
        const shopsSnapshot = await getDocs(shopsRef);

        shopsSnapshot.forEach((docSnap) => {
            const shop = docSnap.data();

            if (shop.upcomingInspection && gnDivisions.includes(shop.gnDivision)) {
                events.push({
                    title: `Inspection: ${shop.name || "Unnamed Shop"}`,
                    start: shop.upcomingInspection.toDate().toISOString().split('T')[0],
                    color: '#3DB952' // Green
                });
            }
        });

    } catch (error) {
        console.error("Error loading inspections:", error);
    }
    return events;
}
