import { auth, db } from './firebase-config.js';
import {
  collection,
  getDoc,
  doc,
  query,
  where,
  getDocs
} from 'https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js';

import { fetchAndRenderPHIs } from './phi-listing.js'; 

const districtField = document.getElementById('district');
const gnDropdown = document.getElementById('add-multiSelectDropdown');
const selectedOptionsContainer = document.getElementById('add-selected-options');
const phiIdInput = document.getElementById('phi-id');
const phiIdError = document.getElementById('phiid-error');
const form = document.getElementById('phi-registration-form');
const passwordError = document.getElementById('password-match-error');

// Autofill District + Populate GN Divisions
auth.onAuthStateChanged(async (user) => {
  console.log("onAuthStateChanged -> user:", user);
  if (user) {
    try {
      const userDocSnap = await getDoc(doc(db, 'users', user.uid));
      if (userDocSnap.exists()) {
        const data = userDocSnap.data();
        console.log("Logged-in SPHI data:", data);

        // Populate District
        districtField.value = data.district ?? data.District ?? '';

        // Populate GN Divisions
        const gnList = data.gn_divisions ?? data.gnDivisions ?? [];
        gnDropdown.innerHTML = '';
        gnList.forEach((gn) => {
          const option = document.createElement('option');
          option.value = gn;
          option.textContent = gn;
          gnDropdown.appendChild(option);
        });
      } else {
        console.warn("No SPHI document found for user UID:", user.uid);
      }
    } catch (err) {
      console.error("Error getting SPHI document:", err);
    }
  } else {
    console.warn("No user is signed in.");
  }
});

// Validate PHI ID in Real-Time
phiIdInput.addEventListener('input', async () => {
  const enteredId = phiIdInput.value.trim();
  if (!enteredId) {
    phiIdError.textContent = '';
    return;
  }
  const q = query(collection(db, 'users'), where('phiId', '==', enteredId));
  const snap = await getDocs(q);
  phiIdError.textContent = snap.empty ? '' : 'PHI ID already exists.';
});

//  Handle GN multi-select
gnDropdown.addEventListener('change', () => {
  const value = gnDropdown.value;
  if (!value || document.querySelector(`[data-value="${value}"]`)) return;
  const chip = document.createElement('div');
  chip.classList.add('selected-option');
  chip.setAttribute('data-value', value);
  chip.innerHTML = `${value} <button class="remove-option">&times;</button>`;
  selectedOptionsContainer.appendChild(chip);
  chip.querySelector('.remove-option').addEventListener('click', () => {
    selectedOptionsContainer.removeChild(chip);
  });
  gnDropdown.value = '';
});

//  Form Submission -> Call Cloud Function
form.addEventListener('submit', async (e) => {
  e.preventDefault();

  const phiId = phiIdInput.value.trim();
  const fullName = document.getElementById('full-name').value.trim();
  const nic = document.getElementById('nic').value.trim();
  const phone = document.getElementById('phone').value.trim();
  const email = document.getElementById('phi-email').value.trim();
  const personalAddress = document.getElementById('personal-address').value.trim();
  const officeLocation = document.getElementById('office-location').value.trim();
  const district = districtField.value;
  const password = document.getElementById('new-password').value;
  const confirmPassword = document.getElementById('confirm-password').value;

  const selectedGNs = Array.from(document.querySelectorAll('.selected-option'))
    .map((el) => el.getAttribute('data-value'));

  if (password !== confirmPassword) {
    passwordError.textContent = 'Passwords do not match.';
    return;
  } else {
    passwordError.textContent = '';
  }

  // Final PHI ID validation
  const q = query(collection(db, 'users'), where('phiId', '==', phiId));
  const snap = await getDocs(q);
  if (!snap.empty) {
    phiIdError.textContent = 'PHI ID already exists.';
    return;
  }

  const cloudFunctionURL = 'https://createphiuser-m2olz6aiqa-uc.a.run.app';
  console.log('Submitting to Cloud Function at:', cloudFunctionURL);

  try {
    const response = await fetch(cloudFunctionURL, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        phiId,
        fullName,
        nic,
        phone,
        email,
        personalAddress,
        officeLocation,
        district,
        gnDivisions: selectedGNs,
        password
      })
    });
    console.log('Fetch response status:', response.status);
    const result = await response.json();
    console.log('Fetch response body:', result);

    if (!response.ok) {
      throw new Error(result.error || 'Failed to register PHI.');
    }
    
    
    form.reset();
    selectedOptionsContainer.innerHTML = '';
    hideSlider(); 
    await fetchAndRenderPHIs(); 
    
  } catch (err) {
    alert('Error: ' + err.message);
    console.error(err);
  }
});
