import { auth, db } from "./firebase-config.js";
import {
  collection,
  getDocs,
  query,
  where,
  doc,
  getDoc,
  addDoc,
  updateDoc,
  deleteDoc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

let calendar;

document.addEventListener("DOMContentLoaded", async () => {
    const calendarEl = document.getElementById("calendar");
  
    calendar = new FullCalendar.Calendar(calendarEl, {
      initialView: "dayGridMonth",
      headerToolbar: {
        left: "prev,next today",
        center: "title",
        right: ""
      },
      height: "100%",
      dayMaxEventRows: true,
      fixedWeekCount: true,
      selectable: true,
      events: [],
  
      /* --------------------- ADD TASK --------------------- */
      dateClick: async (info) => {
        const { value } = await Swal.fire({
          title: "Add New Task",
          html: `
            <div style="display:flex;flex-direction:column;gap:15px;width:100%">
              <div style="display:flex;flex-direction:column">
                <label for=\"task-title\" style=\"font-weight:bold;font-size:14px;margin-bottom:5px;margin-left:-200px;width:100%\">Task Title</label>
                <input id=\"task-title\" class=\"swal2-input\" placeholder=\"Enter task title\" style=\"margin-left:-5px;width:105%;height:35px;font-size:14px\">
              </div>
              <div style="display:flex;flex-direction:column">
                <label for=\"task-notes\" style=\"font-weight:bold;font-size:14px;margin-bottom:5px;margin-left:-175px;width:100%\">Notes (optional)</label>
                <textarea id=\"task-notes\" class=\"swal2-textarea\" placeholder=\"Enter notes\" style=\"margin-left:-5px;width:105%;height:80px;font-size:14px;resize:none\"></textarea>
              </div>
            </div>
          `,
          width: 500,
          showCancelButton: true,
          confirmButtonText: "Save",
          cancelButtonText: "Cancel",
          preConfirm: () => {
            const title = document.getElementById("task-title").value.trim();
            const notes = document.getElementById("task-notes").value.trim();
            if (!title) {
              Swal.showValidationMessage("Task title is required");
              return false;
            }
            return { title, notes };
          }
        });
  
        if (value) saveNewTask(info.dateStr, value.title, value.notes);
      },
  
      /* ------------- VIEW / EDIT / DELETE ------------- */
      eventClick: async (info) => {
        const type = info.event.extendedProps.type ?? "manual";
  
        if (type === "inspection") {
          const { title, referenceNo, gnDivision } = info.event.extendedProps;
          await Swal.fire({
            title: "Upcoming Inspection",
            html: `
              <b>${title}</b><br><br>
              <b>Date:</b> ${info.event.start.toISOString().split("T")[0]}<br>
              <b>Reference No:</b> ${referenceNo}<br>
              <b>GN Division:</b> ${gnDivision}
            `
          });
          return;
        }
  
        const origTitle = info.event.title;
        const origDate  = info.event.start.toISOString().split("T")[0];
        const origNotes = info.event.extendedProps.notes ?? "";
  
        const { isConfirmed, isDenied, value } = await Swal.fire({
          title: "Edit Task",
          html: `
            <div style="display:flex;flex-direction:column;gap:15px;width:100%">
              <div style="display:flex;flex-direction:column">
                <label for=\"edit-task-title\" style=\"font-weight:bold;font-size:14px;margin-bottom:5px;margin-left:-200px;width:100%\">Task Title</label>
                <input id=\"edit-task-title\" class=\"swal2-input\" value="${origTitle}" style=\"margin-left:-5px;width:105%;height:35px;font-size:14px\">
              </div>
              <div style="display:flex;flex-direction:column">
                <label for=\"edit-task-date\" style=\"font-weight:bold;font-size:14px;margin-bottom:5px;margin-left:-210px;width:100%\">Date</label>
                <input id=\"edit-task-date\" type=\"date\" class=\"swal2-input\" value="${origDate}" style=\"margin-left:-5px;width:105%;height:35px;font-size:14px\">
              </div>
              <div style="display:flex;flex-direction:column">
                <label for=\"edit-task-notes\" style=\"font-weight:bold;font-size:14px;margin-bottom:5px;margin-left:-175px;width:100%\">Notes (optional)</label>
                <textarea id=\"edit-task-notes\" class=\"swal2-textarea\" style=\"margin-left:-5px;width:105%;height:80px;font-size:14px;resize:none\">${origNotes}</textarea>
              </div>
            </div>
          `,
          width: 500,
          showDenyButton: true,
          showCancelButton: true,
          confirmButtonText: "Save Changes",
          denyButtonText: "Delete",
          cancelButtonText: "Cancel",
          preConfirm: () => {
            const newTitle = document.getElementById("edit-task-title").value.trim();
            const newDate  = document.getElementById("edit-task-date").value;
            const newNotes = document.getElementById("edit-task-notes").value.trim();
            if (!newTitle || !newDate) {
              Swal.showValidationMessage("Task title and date are required");
              return false;
            }
            return { newTitle, newDate, newNotes };
          }
        });
  
        if (isConfirmed && value) {
          await updateTask(info.event, value.newTitle, value.newDate, value.newNotes);
        } else if (isDenied) {
          await deleteTask(info.event);
        }
      }
    });
  

  calendar.render();

  /* initial load */
  auth.onAuthStateChanged(async (user) => {
    if (!user) return (window.location.href = "login.html");
    const manual   = await loadTasks(user.uid);
    const inspects = await loadInspections(user.uid);
    calendar.addEventSource([...manual, ...inspects]);
  });
});

/* ---------------------- LOAD TASKS --------------------- */
async function loadTasks(uid) {
  const events = [];

  try {
    const tasksRef = collection(db, "tasks");
    const uidRef   = doc(db, "users", uid);

    /* string‑based docs */
    const snap1 = await getDocs(query(tasksRef, where("phiId", "==", uid)));
    /* reference‑based legacy docs */
    const snap2 = await getDocs(query(tasksRef, where("phiId", "==", uidRef)));

    [...snap1.docs, ...snap2.docs].forEach((d) => {
      const t = d.data();
      if (t.date) {
        events.push({
          id: d.id,
          title: t.title ?? "Untitled Task",
          start: t.date.toDate().toISOString().split("T")[0],
          color: "#3788d8",
          notes: t.notes ?? "",
          type: "manual"
        });
      }
    });
  } catch (e) {
    console.error("Error loading tasks:", e);
  }
  return events;
}

/* ------------------- LOAD INSPECTIONS ------------------ */
async function loadInspections(uid) {
  const events = [];
  try {
    const userSnap = await getDoc(doc(db, "users", uid));
    if (!userSnap.exists()) return events;

    const gn = userSnap.data().gnDivisions ?? [];
    if (!gn.length) return events;

    const shopsSnap = await getDocs(collection(db, "shops"));
    shopsSnap.forEach((d) => {
      const s = d.data();
      if (s.upcomingInspection && gn.includes(s.gnDivision)) {
        events.push({
          title: `Inspection: ${s.name ?? "Unnamed Shop"}`,
          start: s.upcomingInspection.toDate().toISOString().split("T")[0],
          color: "#3DB952",
          type: "inspection",
          referenceNo: s.referenceNo ?? "N/A",
          gnDivision: s.gnDivision ?? "N/A"
        });
      }
    });
  } catch (e) {
    console.error("Error loading inspections:", e);
  }
  return events;
}

/* ---------------------- ADD TASK ----------------------- */
async function saveNewTask(dateStr, title, notes) {
  try {
    const user = auth.currentUser;
    const userRef = doc(db, "users", user.uid);
    await addDoc(collection(db, "tasks"), {
      title,
      notes,
      date: new Date(dateStr),
      phiId: userRef
    });

    calendar.addEvent({ title, start: dateStr, color: "#3788d8" });
    Swal.fire({ icon: "success", title: "Task Added!", timer: 1200, showConfirmButton: false });
  } catch (e) {
    console.error("Error adding task:", e);
    Swal.fire({ icon: "error", title: "Error!", text: "Could not save task." });
  }
}

/* --------------------- UPDATE TASK --------------------- */
async function updateTask(event, newTitle, newDate, newNotes) {
  try {
    const docId   = event.id;
    const oldDate = event.start.toISOString().split("T")[0];

    const userRef = doc(db, "users", auth.currentUser.uid);
    const data = {
    title: newTitle,
    notes: newNotes,
    phiId: userRef                  
   };
  
    if (newDate !== oldDate) data.date = new Date(`${newDate}T00:00:00`);

    await updateDoc(doc(db, "tasks", docId), data);

    event.setProp("title", newTitle);
    event.setExtendedProp("notes", newNotes);
    if (newDate !== oldDate) event.setStart(new Date(`${newDate}T00:00:00`));

    Swal.fire({ icon: "success", title: "Updated!", timer: 1200, showConfirmButton: false });
  } catch (e) {
    console.error("Error updating task:", e);
    Swal.fire({ icon: "error", title: "Error!", text: "Could not update task." });
  }
}

/* --------------------- DELETE TASK -------------------- */
async function deleteTask(event) {
  try {
    await deleteDoc(doc(db, "tasks", event.id));
    event.remove();
    Swal.fire({ icon: "success", title: "Deleted!", timer: 1200, showConfirmButton: false });
  } catch (e) {
    console.error("Error deleting task:", e);
    Swal.fire({ icon: "error", title: "Error!", text: "Could not delete task." });
  }
}
