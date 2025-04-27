import { auth, db } from './firebase-config.js';
import { collection, getDocs, query, where } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

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
        events: [], // empty initially, will load manually
        dateClick: function(info) {
            alert('Clicked on: ' + info.dateStr);
        }
    });

    calendar.render();

    // 🛠️ After rendering, load tasks
    auth.onAuthStateChanged(async (user) => {
        if (user) {
            const eventsArray = await loadTasks(user.uid);
            calendar.addEventSource(eventsArray); // add events
        } else {
            window.location.href = "login.html"; // if not logged in
        }
    });
});

// 🛠️ Function to fetch manual tasks
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
                    color: '#3788d8' // Blue color for manual tasks
                });
            }
        });
    } catch (error) {
        console.error("Error loading tasks:", error);
    }

    return events;
}
