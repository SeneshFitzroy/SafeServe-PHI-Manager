import { auth, db } from './firebase-config.js';
import {
  collection,
  getDoc,
  doc,
  getDocs,
  query,
  where,
  setDoc,
  deleteDoc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

const container = document.querySelector('.content-container');
const statusFunctionURL = "https://us-central1-safe-serve-8de99.cloudfunctions.net/updatePHIStatus";
let currentToggleButton = null;
let newToggleStatus = null;

export async function fetchAndRenderPHIs() {
  container.innerHTML = '';

  const user = auth.currentUser;
  if (!user) {
    console.warn("No logged-in user found.");
    return;
  }

  try {
    const spDoc = await getDoc(doc(db, 'users', user.uid));
    if (!spDoc.exists()) {
      console.warn("SPHI document not found.");
      return;
    }

    const spData = spDoc.data();
    const spGNDivisions = spData.gn_divisions || [];

    const q = query(collection(db, 'users'), where('role', '==', 'PHI'));
    const querySnapshot = await getDocs(q);

    querySnapshot.forEach((docSnap) => {
      const data = docSnap.data();
      data.uid = docSnap.id;
      const phiGN = data.gnDivisions || [];

      const hasMatch = phiGN.some(gn => spGNDivisions.includes(gn));
      if (hasMatch) {
        const phiHTML = generatePHICardHTML(data);
        container.insertAdjacentHTML('beforeend', phiHTML);
      }
    });

    setupToggleButtons();
    setupViewButtons();
    setupEditButtons();
    setupDeleteButtons();

  } catch (err) {
    console.error("Error fetching PHIs:", err);
  }
}

function generatePHICardHTML(data) {
  const statusClass = data.status === "Active" ? "Active" : "Inactive";
  const statusText = data.status || "Inactive";

  return `
    <div class="user">
      <p class="user-id">${data.phiId}</p>
      <p class="user-s-name">${data.full_name}</p>
      <p class="user-phone">${data.phone}</p>
      <div class="status">
        <button 
          class="toggle-btn ${statusClass}" 
          data-uid="${data.uid}" 
          data-status="${statusText}"
        >${statusText}</button>
      </div>
      <div class="user-actions">
        <div class="view" data-uid="${data.uid}">
          <i class="bi bi-eye-fill"></i>
        </div>
        <div class="edit" data-uid="${data.uid}">
          <i class="bi bi-pencil-fill"></i>
        </div>
        <div class="delete" onclick="confirmDelete('${data.uid}')">
          <i class="bi bi-trash3-fill"></i>
        </div>
      </div>
    </div>
  `;
}

function setupToggleButtons() {
  const buttons = document.querySelectorAll('.toggle-btn');

  buttons.forEach(btn => {
    btn.addEventListener('click', () => {
      const uid = btn.getAttribute('data-uid');
      const currentStatus = btn.getAttribute('data-status');
      newToggleStatus = currentStatus === "Active" ? "Inactive" : "Active";
      currentToggleButton = btn;

      const modalText = `Are you sure you want to ${newToggleStatus === "Active" ? 'activate' : 'deactivate'} this PHI account?`;
      document.getElementById('modalText').textContent = modalText;

      document.getElementById('confirmBtn').setAttribute('data-uid', uid);
      document.getElementById('confirmModal').style.display = 'flex';
    });
  });
}

function setupViewButtons() {
  const viewButtons = document.querySelectorAll('.view');

  viewButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const uid = btn.getAttribute('data-uid');
      if (uid) {
        showViewSlider(uid);
      }
    });
  });
}

function setupEditButtons() {
  const editButtons = document.querySelectorAll('.edit');

  editButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const uid = btn.getAttribute('data-uid');
      if (uid) {
        showEditSlider(uid);
      }
    });
  });
}

function setupDeleteButtons() {
  const deleteButtons = document.querySelectorAll('.delete');

  deleteButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const uid = btn.getAttribute('data-uid');
      if (uid) {
        confirmDelete(uid);
      }
    });
  });
}


document.getElementById('confirmBtn').addEventListener('click', async () => {
  const uid = document.getElementById('confirmBtn').getAttribute('data-uid');

  try {
    const res = await fetch(statusFunctionURL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ uid, status: newToggleStatus })
    });

    const result = await res.json();

    if (res.ok) {
      currentToggleButton.classList.remove("Active", "Inactive");
      currentToggleButton.classList.add(newToggleStatus);
      currentToggleButton.textContent = newToggleStatus;
      currentToggleButton.setAttribute('data-status', newToggleStatus);
    } else {
      alert("Failed to update status: " + result.error);
    }

  } catch (err) {
    console.error("Error updating status:", err);
    alert("Something went wrong while updating status.");
  }

  document.getElementById('confirmModal').style.display = 'none';
  currentToggleButton = null;
});

document.getElementById('cancelBtn').addEventListener('click', () => {
  document.getElementById('confirmModal').style.display = 'none';
  currentToggleButton = null;
});

window.addEventListener('click', (event) => {
  const modal = document.getElementById('confirmModal');
  if (event.target === modal) {
    modal.style.display = 'none';
    currentToggleButton = null;
  }
});

auth.onAuthStateChanged((user) => {
  if (user) {
    fetchAndRenderPHIs();
  } else {
    console.warn("No user signed in yet.");
  }
});

export async function showViewSlider(uid) {
  const viewSlider = document.getElementById('viewPHISlider');
  const selectedOptionsContainer = document.getElementById('selected-options');

  try {
    const docSnap = await getDoc(doc(db, 'users', uid));
    if (!docSnap.exists()) {
      alert('PHI record not found!');
      return;
    }

    const data = docSnap.data();

    document.getElementById('view-phi-id').value = data.phiId || '';
    document.getElementById('view-full-name').value = data.full_name || '';
    document.getElementById('view-nic').value = data.nic || '';
    document.getElementById('view-phone').value = data.phone || '';
    document.getElementById('view-phi-email').value = data.email || '';
    document.getElementById('view-personal-address').value = data.personalAddress || '';
    document.getElementById('view-office-location').value = data.officeLocation || '';
    document.getElementById('view-district').value = data.district || '';

    selectedOptionsContainer.innerHTML = '';
    (data.gnDivisions || []).forEach(gn => {
      const div = document.createElement('div');
      div.classList.add('selected-option');
      div.textContent = gn;
      selectedOptionsContainer.appendChild(div);
    });

    viewSlider.classList.add('active');

  } catch (err) {
    console.error('Error loading PHI data for view:', err);
    alert('Failed to load PHI data.');
  }
}

export async function showEditSlider(uid) {
  const editSlider = document.getElementById('editPHISlider');
  const gnDropdown = document.getElementById('edit-multiSelectDropdown');
  const selectedContainer = document.getElementById('edit-selected-options');
  const districtSelect = document.getElementById('edit-district');

  try {
    const currentUser = auth.currentUser;
    if (!currentUser) {
      console.warn("No authenticated user.");
      return;
    }

    const spDoc = await getDoc(doc(db, 'users', currentUser.uid));
    if (!spDoc.exists()) {
      console.warn("SPHI document not found.");
      return;
    }

    const spData = spDoc.data();
    const spGNDivisions = spData.gn_divisions || [];

    gnDropdown.innerHTML = '';
    spGNDivisions.forEach(gn => {
      const option = document.createElement('option');
      option.value = gn;
      option.textContent = gn;
      gnDropdown.appendChild(option);
    });

    const phiDoc = await getDoc(doc(db, 'users', uid));
    if (!phiDoc.exists()) {
      alert("PHI record not found.");
      return;
    }

    const phiData = phiDoc.data();

    districtSelect.innerHTML = '<option value="Colombo" selected>Colombo</option>';

    selectedContainer.innerHTML = '';
    (phiData.gnDivisions || []).forEach(gn => {
      const chip = document.createElement('div');
      chip.classList.add('selected-option');
      chip.setAttribute('data-value', gn);
      chip.innerHTML = `${gn} <button class="remove-option">&times;</button>`;
      selectedContainer.appendChild(chip);

      chip.querySelector('.remove-option').addEventListener('click', () => {
        selectedContainer.removeChild(chip);
      });
    });

    editSlider.setAttribute('data-edit-uid', uid);
    editSlider.classList.add('active');

  } catch (err) {
    console.error("Error loading Edit PHI data:", err);
    alert("Something went wrong while loading PHI data.");
  }
}

export async function updatePHI() {
  const uid = document.getElementById('editPHISlider').getAttribute('data-edit-uid');
  const district = document.getElementById('edit-district').value;
  const gnDivisions = Array.from(document.querySelectorAll('#edit-selected-options .selected-option'))
    .map(el => el.getAttribute('data-value'));

  if (!uid) {
    alert("No PHI selected for update.");
    return;
  }

  try {
    await setDoc(doc(db, 'users', uid), {
      district,
      gnDivisions
    }, { merge: true });

    document.getElementById('editPHISlider').classList.remove('active');
    fetchAndRenderPHIs();

  } catch (err) {
    console.error("Error updating PHI:", err);
    alert("Failed to update PHI.");
  }
}

window.updatePHI = updatePHI;

import { deleteUser } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

export async function confirmDelete(uid) {
  const confirmed = confirm("Are you sure you want to delete this PHI?");
  if (!confirmed) return;

  try {
    //  Delete from Firestore
    await deleteDoc(doc(db, "users", uid));

    fetchAndRenderPHIs(); 

  } catch (err) {
    console.error("Error deleting PHI:", err);
    alert("Failed to delete PHI. Please try again.");
  }
}

window.confirmDelete = confirmDelete;
