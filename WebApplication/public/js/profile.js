import { auth, db } from "./firebase-config.js";
import {
  onAuthStateChanged,
  EmailAuthProvider,
  reauthenticateWithCredential,
  updatePassword
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";
import {
  doc,
  getDoc,
  updateDoc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

let currentUserId = null;

document.addEventListener("DOMContentLoaded", () => {
  onAuthStateChanged(auth, async (user) => {
    if (user) {
      currentUserId = user.uid;
      const userRef = doc(db, "users", currentUserId);
      const docSnap = await getDoc(userRef);

      if (docSnap.exists()) {
        const userData = docSnap.data();
        populateProfile(userData);
        populateEditForm(userData);
      } else {
        alert("User profile not found!");
      }
    } else {
      window.location.href = "login.html";
    }
  });

  // Event listener for "Update" button
  document.getElementById("save-profile-btn").addEventListener("click", async () => {
    if (!currentUserId) return;

    const name = document.getElementById("edit-name").value.trim();
    const phone = document.getElementById("edit-phone").value.trim();
    const email = document.getElementById("edit-email").value.trim();
    const address = document.getElementById("edit-address").value.trim();

    const userRef = doc(db, "users", currentUserId);

    try {
      await updateDoc(userRef, {
        full_name: name,
        phone: phone,
        email: email,
        personalAddress: address
      });

      hideEditSlider();
      location.reload(); 
    } catch (error) {
      console.error("Error updating profile:", error);
      alert("Failed to update profile. Please try again.");
    }
  });
});

function populateProfile(user) {
  const infoCard1 = document.querySelectorAll(".info-card")[0];
  infoCard1.innerHTML = `
    <h3>Personal Information</h3>
    <p><span>PHI ID</span> <span>${user.phiId || user.sphi_id || "—"}</span></p>
    <p><span>Full Name</span> <span>${user.full_name}</span></p>
    <p><span>NIC</span> <span>${user.nic}</span></p>
    <p><span>Role</span> <span>${user.role}</span></p>
    <p><span>Phone Number</span> <span>${user.phone || user.phone_number}</span></p>
    <p><span>Email</span> <span>${user.email}</span></p>
    <p><span>Personal Address</span> <span>${user.personalAddress || user.personal_address}</span></p>
    <button class="edit-button" onclick="showEditSlider()">
      <img src="images/edit-icon.png">
    </button>
  `;

  const infoCard2 = document.querySelectorAll(".info-card")[1];
  infoCard2.innerHTML = `
    <h3>Work Information</h3>
    <p><span>District</span> <span>${user.district instanceof Array ? user.district.join(", ") : user.district}</span></p>
    <p><span>Office Location</span> <span>${user.officeLocation || user.office_location}</span></p>
    <p>Assigned Grama Niladhari Divisions</p>
    <div class="division-list">
      ${(user.gnDivisions || user.gn_divisions || []).map(gn => `<div class="division">${gn}</div>`).join("")}
    </div>
  `;

  document.querySelector(".user-name").innerText = user.full_name;
  document.querySelector(".user-role").innerText = user.role;
}

function populateEditForm(user) {
  document.getElementById("edit-name").value = user.full_name;
  document.getElementById("edit-phone").value = user.phone || user.phone_number;
  document.getElementById("edit-email").value = user.email;
  document.getElementById("edit-address").value = user.personalAddress || user.personal_address;
}

document.getElementById("change-password-btn").addEventListener("click", async () => {
    const oldPassword = document.getElementById("old-password").value.trim();
    const newPassword = document.getElementById("new-password").value.trim();
    const confirmPassword = document.getElementById("confirm-password").value.trim();
  
    // Clear previous errors
    document.getElementById("old-password-error").innerText = "";
    document.getElementById("new-password-error").innerText = "";
    document.getElementById("confirm-password-error").innerText = "";
  
    let hasError = false;
  
    if (!oldPassword) {
      document.getElementById("old-password-error").innerText = "Please enter your current password.";
      hasError = true;
    }
  
    if (!newPassword) {
      document.getElementById("new-password-error").innerText = "Please enter a new password.";
      hasError = true;
    }
  
    if (!confirmPassword) {
      document.getElementById("confirm-password-error").innerText = "Please re-enter the new password.";
      hasError = true;
    } else if (newPassword !== confirmPassword) {
      document.getElementById("confirm-password-error").innerText = "Passwords do not match.";
      hasError = true;
    }
  
    if (hasError) return;
  
    const user = auth.currentUser;
  
    if (!user || !user.email) {
      alert("User not authenticated.");
      return;
    }
  
    const credential = EmailAuthProvider.credential(user.email, oldPassword);
  
    try {
      await reauthenticateWithCredential(user, credential);
      await updatePassword(user, newPassword);
      closeModal();
    } catch (error) {
        console.error("Password change error:", error);
        const oldError = document.getElementById("old-password-error");
      
        if (error.code === "auth/wrong-password") {
          oldError.innerText = "Incorrect current password.";
        } else if (error.code === "auth/weak-password") {
          document.getElementById("new-password-error").innerText = "Password should be at least 6 characters.";
        } else {
          oldError.innerText = "Error: " + error.message;
        }
      }
  });
  