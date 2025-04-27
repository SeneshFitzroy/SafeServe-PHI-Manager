import { auth, db } from './firebase-config.js';
import { collection, getDocs, query, where, doc, getDoc, addDoc } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

let calendar;


document.addEventListener('DOMContentLoaded', function () {
    const calendarEl = document.getElementById('calendar');

    calendar = new FullCalendar.Calendar(calendarEl, {
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
        dateClick: async function(info) {
            const { value: formValues } = await Swal.fire({
                title: 'Add New Task',
                html:
                    '<input id="task-title" class="swal2-input" placeholder="Task Title">' +
                    '<textarea id="task-notes" class="swal2-textarea" placeholder="Notes (optional)" rows="3"></textarea>',
                focusConfirm: false,
                showCancelButton: true,
                confirmButtonText: 'Save',
                cancelButtonText: 'Cancel',
                preConfirm: () => {
                    const title = document.getElementById('task-title').value.trim();
                    const notes = document.getElementById('task-notes').value.trim();
        
                    if (!title) {
                        Swal.showValidationMessage('Task title is required');
                        return false;
                    }
        
                    return { title, notes };
                }
            });
        
            if (formValues) {
                // Save the new task to Firestore
                saveNewTask(info.dateStr, formValues.title, formValues.notes);
            }
        },
        
        eventClick: function(info) {
            const title = info.event.title || "No Title";
            const date = info.event.start ? info.event.start.toISOString().split('T')[0] : "No Date";
            const notes = info.event.extendedProps && info.event.extendedProps.notes ? info.event.extendedProps.notes : "No Notes";
        
            Swal.fire({
                html: `
                    <div style="position: relative; padding: 10px;">
                        <button id="closePopup" style="
                            position: absolute;
                            top: 10px;
                            right: 10px;
                            background: none;
                            border: none;
                            font-size: 20px;
                            color: #888;
                            cursor: pointer;
                        ">&times;</button>
                        
                        <div style="
                            font-size: 18px;
                            font-weight: bold;
                            margin-bottom: 10px;
                            color: #333;
                        ">${title}</div>
        
                        <div style="
                            font-size: 14px;
                            margin-bottom: 5px;
                        "><strong>Date:</strong> ${date}</div>
        
                        <div style="
                            font-size: 14px;
                            margin-bottom: 5px;
                        "><strong>Notes:</strong> ${notes}</div>
                    </div>
                `,
                showConfirmButton: false,
                background: '#ffffff',
                width: 320,
                padding: '1.5em',
                customClass: {
                    popup: 'small-calendar-popup'
                },
                didOpen: () => {
                    const closeBtn = document.getElementById('closePopup');
                    if (closeBtn) {
                        closeBtn.addEventListener('mouseover', () => {
                            closeBtn.style.color = '#000';
                        });
                        closeBtn.addEventListener('mouseout', () => {
                            closeBtn.style.color = '#888';
                        });
                        closeBtn.addEventListener('click', () => {
                            Swal.close();
                        });
                    }
                }
            });
        
            info.jsEvent.preventDefault();
        },
        
        
        
        
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
                    color: '#3788d8', // Blue
                    notes: task.notes || ""
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



async function saveNewTask(dateStr, title, notes) {
    try {
        const user = auth.currentUser;
        if (!user) {
            console.error("User not logged in");
            return;
        }

        await addDoc(collection(db, "tasks"), {
            title: title,
            notes: notes,
            date: new Date(dateStr),
            phiId: user.uid
        });

        Swal.fire({
            icon: 'success',
            title: 'Task Added!',
            timer: 1200,
            showConfirmButton: false
        });

        // ✅ Also show the newly added task instantly on the calendar
        calendar.addEvent({
            title: title,
            start: dateStr,
            color: '#3788d8'
        });

    } catch (error) {
        console.error("Error adding task:", error);
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Could not save task. Please try again.'
        });
    }
}
