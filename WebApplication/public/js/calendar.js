import { auth, db } from './firebase-config.js';
import { collection, getDocs, query, where, doc, getDoc, addDoc, updateDoc, deleteDoc } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

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
        dateClick: async function (info) {
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
                saveNewTask(info.dateStr, formValues.title, formValues.notes);
            }
        },
        eventClick: async function (info) {
            const eventType = info.event.extendedProps.type || "manual"; // Default to manual if not set

            const title = info.event.title || "No Title";
            const date = info.event.start ? info.event.start.toISOString().split('T')[0] : "No Date";
            const notes = info.event.extendedProps && info.event.extendedProps.notes ? info.event.extendedProps.notes : "No Notes";

            if (eventType === 'inspection') {
                // 🛡 Only simple popup for inspections
                await Swal.fire({
                    title: 'Upcoming Inspection',
                    html: `
                        <div style="font-weight:bold; font-size:18px;">${title}</div>
                        <div style="margin-top:10px;">Date: ${date}</div>
                    `,
                    confirmButtonText: 'Close'
                });
            } else {
                // 🛠 Editable popup for manual tasks
                const result = await Swal.fire({
                    title: 'Edit Task',
                    html: `
                        <input id="edit-task-title" class="swal2-input" placeholder="Task Title" value="${title}">
                        <input id="edit-task-date" type="date" class="swal2-input" value="${date}">
                        <textarea id="edit-task-notes" class="swal2-textarea" placeholder="Notes (optional)">${notes}</textarea>
                    `,
                    showCancelButton: true,
                    showDenyButton: true,
                    confirmButtonText: 'Save Changes',
                    denyButtonText: 'Delete Task',
                    cancelButtonText: 'Cancel',
                    focusConfirm: false,
                    preConfirm: () => {
                        const newTitle = document.getElementById('edit-task-title').value.trim();
                        const newDate = document.getElementById('edit-task-date').value;
                        const newNotes = document.getElementById('edit-task-notes').value.trim();

                        if (!newTitle || !newDate) {
                            Swal.showValidationMessage('Task title and date are required');
                            return false;
                        }
                        return { newTitle, newDate, newNotes };
                    }
                });

                if (result.isConfirmed && result.value) {
                    updateTask(info.event, result.value.newTitle, result.value.newDate, result.value.newNotes);
                } else if (result.isDenied) {
                    deleteTask(info.event);
                }
            }
        }
    });

    calendar.render();

    auth.onAuthStateChanged(async (user) => {
        if (user) {
            try {
                const manualTasks = await loadTasks(user.uid);
                const inspections = await loadInspections(user.uid);
                const allEvents = [...manualTasks, ...inspections];
                calendar.addEventSource(allEvents);
            } catch (error) {
                console.error("Error loading events:", error);
            }
        } else {
            window.location.href = "login.html";
        }
    });
});

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
                    id: docSnap.id,
                    title: task.title || "Untitled Task",
                    start: task.date.toDate().toISOString().split('T')[0],
                    color: '#3788d8',
                    notes: task.notes || "",
                    type: 'manual' // 👈 Tag manual task
                });
            }
        });
    } catch (error) {
        console.error("Error loading tasks:", error);
    }
    return events;
}

async function loadInspections(userId) {
    const events = [];
    try {
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

        const shopsRef = collection(db, "shops");
        const shopsSnapshot = await getDocs(shopsRef);

        shopsSnapshot.forEach((docSnap) => {
            const shop = docSnap.data();
            if (shop.upcomingInspection && gnDivisions.includes(shop.gnDivision)) {
                events.push({
                    title: `Inspection: ${shop.name || "Unnamed Shop"}`,
                    start: shop.upcomingInspection.toDate().toISOString().split('T')[0],
                    color: '#3DB952',
                    type: 'inspection' // 👈 Tag inspection task
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

async function updateTask(event, newTitle, newDate, newNotes) {
    try {
        const docId = event.id;
        if (!docId) {
            console.error("No document ID found for this event.");
            return;
        }

        const oldDate = event.start ? event.start.toISOString().split('T')[0] : "";

        const updateData = {
            title: newTitle,
            notes: newNotes
        };

        if (newDate !== oldDate) {
            updateData.date = new Date(newDate + "T00:00:00");
        }

        await updateDoc(doc(db, "tasks", docId), updateData);

        event.setProp('title', newTitle);
        event.setExtendedProp('notes', newNotes);

        if (newDate !== oldDate) {
            event.setStart(new Date(newDate + "T00:00:00"));
        }

        Swal.fire({
            icon: 'success',
            title: 'Updated!',
            timer: 1200,
            showConfirmButton: false
        });

    } catch (error) {
        console.error("Error updating task:", error);
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Could not update task. Please try again.'
        });
    }
}

async function deleteTask(event) {
    try {
        const docId = event.id;
        if (!docId) {
            console.error("No document ID found for this event.");
            return;
        }

        await deleteDoc(doc(db, "tasks", docId));
        event.remove();

        Swal.fire({
            icon: 'success',
            title: 'Deleted!',
            timer: 1200,
            showConfirmButton: false
        });

    } catch (error) {
        console.error("Error deleting task:", error);
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Could not delete task. Please try again.'
        });
    }
}
