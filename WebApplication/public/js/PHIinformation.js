// File: js/profile.js
// This file handles the profile functionality including displaying user data,
// updating profile information, and changing password

import { 
    auth, 
    db, 
    signOut, 
    updatePassword, 
    reauthenticateWithCredential, 
    EmailAuthProvider, 
    doc, 
    getDoc, 
    updateDoc,
    onAuthStateChanged,
    updateEmail
} from "./firebase-config.js";

// DOM elements
const userNameElement = document.querySelector('.user-name');
const userRoleElement = document.querySelector('.user-role');
const personalInfoElements = {
    phiId: document.querySelector('.info-card:nth-child(1) p:nth-child(2) span:nth-child(2)'),
    fullName: document.querySelector('.info-card:nth-child(1) p:nth-child(3) span:nth-child(2)'),
    nic: document.querySelector('.info-card:nth-child(1) p:nth-child(4) span:nth-child(2)'),
    role: document.querySelector('.info-card:nth-child(1) p:nth-child(5) span:nth-child(2)'),
    phoneNumber: document.querySelector('.info-card:nth-child(1) p:nth-child(6) span:nth-child(2)'),
    email: document.querySelector('.info-card:nth-child(1) p:nth-child(7) span:nth-child(2)'),
    personalAddress: document.querySelector('.info-card:nth-child(1) p:nth-child(8) span:nth-child(2)')
};

const workInfoElements = {
    district: document.querySelector('.info-card:nth-child(2) p:nth-child(1) span:nth-child(2)'),
    officeLocation: document.querySelector('.info-card:nth-child(2) p:nth-child(2) span:nth-child(2)'),
    divisions: document.querySelector('.division-list')
};

// Show the edit slider
function showEditSlider() {
    console.log("Showing edit slider");
    const slider = document.getElementById('editprofileSlider');
    if (slider) {
        slider.classList.add('active');
    } else {
        console.error("Edit slider element not found");
    }
}

// Hide the edit slider
function hideEditSlider() {
    console.log("Hiding edit slider");
    const slider = document.getElementById('editprofileSlider');
    if (slider) {
        slider.classList.remove('active');
    } else {
        console.error("Edit slider element not found");
    }
}

// Open the password modal
function openModal() {
    console.log("Opening password modal");
    const modal = document.getElementById("updatePasswordModal");
    if (modal) {
        modal.style.display = "flex";
    } else {
        console.error("Password modal not found");
    }
}

// Close the password modal
function closeModal() {
    console.log("Closing password modal");
    const modal = document.getElementById("updatePasswordModal");
    if (modal) {
        modal.style.display = "none";
    } else {
        console.error("Password modal not found");
    }
}

// Make these functions globally available
window.showEditSlider = showEditSlider;
window.hideEditSlider = hideEditSlider;
window.openModal = openModal;
window.closeModal = closeModal;

// Event listeners
document.addEventListener('DOMContentLoaded', () => {
    console.log("DOM Content Loaded");
    
    // Get button elements
    const editProfileBtn = document.getElementById('editProfileBtn');
    const changePasswordBtn = document.getElementById('changePasswordBtn');
    const closeEditSliderBtn = document.getElementById('closeEditSlider');
    const closePasswordModalBtn = document.getElementById('closePasswordModal');
    
    // Initialize form elements
    const editForm = document.getElementById('profileEditForm');
    const fullNameInput = document.getElementById('fullName');
    const phoneInput = document.getElementById('phoneNumber');
    const emailInput = document.getElementById('email');
    const addressInput = document.getElementById('personalAddress');

    const passwordForm = document.getElementById('passwordChangeForm');
    const currentPasswordInput = document.getElementById('currentPassword');
    const newPasswordInput = document.getElementById('newPassword');
    const confirmPasswordInput = document.getElementById('confirmPassword');

    // Add event listeners to buttons
    if (editProfileBtn) {
        console.log("Adding event listener to edit profile button");
        editProfileBtn.addEventListener('click', showEditSlider);
    } else {
        console.error("Edit profile button not found");
    }

    if (changePasswordBtn) {
        console.log("Adding event listener to change password button");
        changePasswordBtn.addEventListener('click', openModal);
    } else {
        console.error("Change password button not found");
    }

    if (closeEditSliderBtn) {
        console.log("Adding event listener to close edit slider button");
        closeEditSliderBtn.addEventListener('click', hideEditSlider);
    } else {
        console.error("Close edit slider button not found");
    }

    if (closePasswordModalBtn) {
        console.log("Adding event listener to close password modal button");
        closePasswordModalBtn.addEventListener('click', closeModal);
    } else {
        console.error("Close password modal button not found");
    }

    // Check if user is authenticated
    onAuthStateChanged(auth, user => {
        console.log("Auth state changed:", user ? user.uid : "No user");
        if (user) {
            loadUserData(user.uid, fullNameInput, phoneInput, emailInput, addressInput);
        } else {
            // Redirect to login page if not authenticated
            window.location.href = 'login.html';
        }
    });

    // Set up logout functionality
    const logoutButton = document.querySelector('.logout');
    if (logoutButton) {
        logoutButton.addEventListener('click', (e) => {
            e.preventDefault();
            console.log("Logout button clicked");
            signOut(auth).then(() => {
                window.location.href = 'login.html';
            }).catch((error) => {
                console.error('Logout Error:', error);
                alert('Failed to logout. Please try again.');
            });
        });
    } else {
        console.error("Logout button not found");
    }

    // Set up edit form submission
    if (editForm) {
        editForm.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log("Edit form submitted");
            updateUserProfile(fullNameInput, phoneInput, emailInput, addressInput);
        });
    } else {
        console.error("Profile edit form not found");
    }

    // Set up password change form submission
    if (passwordForm) {
        passwordForm.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log("Password form submitted");
            changePassword(currentPasswordInput, newPasswordInput, confirmPasswordInput);
        });
    } else {
        console.error("Password form not found");
    }
});

// Load user data from Firestore
async function loadUserData(userId, fullNameInput, phoneInput, emailInput, addressInput) {
    try {
        console.log("Loading user data for:", userId);
        const userDocRef = doc(db, "users", userId);
        const userDoc = await getDoc(userDocRef);
        
        if (userDoc.exists()) {
            const userData = userDoc.data();
            console.log("User data loaded:", userData);
            
            // Update user info in the navigation bar
            if (userNameElement) userNameElement.textContent = userData.fullName || '';
            if (userRoleElement) userRoleElement.textContent = userData.role || '';
            
            // Update personal information
            if (personalInfoElements.phiId) personalInfoElements.phiId.textContent = userData.phiId || '';
            if (personalInfoElements.fullName) personalInfoElements.fullName.textContent = userData.fullName || '';
            if (personalInfoElements.nic) personalInfoElements.nic.textContent = userData.nic || '';
            if (personalInfoElements.role) personalInfoElements.role.textContent = userData.role || '';
            if (personalInfoElements.phoneNumber) personalInfoElements.phoneNumber.textContent = userData.phoneNumber || '';
            if (personalInfoElements.email) personalInfoElements.email.textContent = userData.email || '';
            if (personalInfoElements.personalAddress) personalInfoElements.personalAddress.textContent = userData.personalAddress || '';
            
            // Update work information
            if (workInfoElements.district) workInfoElements.district.textContent = userData.district || '';
            if (workInfoElements.officeLocation) workInfoElements.officeLocation.textContent = userData.officeLocation || '';
            
            // Update divisions
            if (workInfoElements.divisions && userData.assignedDivisions && Array.isArray(userData.assignedDivisions)) {
                workInfoElements.divisions.innerHTML = '';
                userData.assignedDivisions.forEach(division => {
                    const divElement = document.createElement('div');
                    divElement.className = 'division';
                    divElement.textContent = division;
                    workInfoElements.divisions.appendChild(divElement);
                });
            }
            
            // Pre-fill edit form fields
            if (fullNameInput) fullNameInput.value = userData.fullName || '';
            if (phoneInput) phoneInput.value = userData.phoneNumber || '';
            if (emailInput) emailInput.value = userData.email || '';
            if (addressInput) addressInput.value = userData.personalAddress || '';
        } else {
            console.error('User document not found');
            alert('User information not found. Please contact administrator.');
        }
    } catch (error) {
        console.error('Error loading user data:', error);
        alert('Failed to load user data. Please refresh the page or contact support.');
    }
}

// Update user profile in Firestore
async function updateUserProfile(fullNameInput, phoneInput, emailInput, addressInput) {
    try {
        const user = auth.currentUser;
        if (!user) {
            alert('You must be logged in to update your profile');
            return;
        }
        
        console.log("Updating user profile for:", user.uid);
        
        // Make sure we have all the form fields
        if (!fullNameInput || !phoneInput || !emailInput || !addressInput) {
            alert('Cannot access form fields. Please refresh the page and try again.');
            return;
        }
        
        const updatedData = {
            fullName: fullNameInput.value.trim(),
            phoneNumber: phoneInput.value.trim(),
            email: emailInput.value.trim(),
            personalAddress: addressInput.value.trim(),
            updatedAt: new Date()
        };
        
        console.log("Updated data:", updatedData);
        
        // Update in Firestore
        const userDocRef = doc(db, "users", user.uid);
        await updateDoc(userDocRef, updatedData);
        console.log("Firestore document updated");
        
        // Update email in Firebase Auth if it has changed
        if (user.email !== updatedData.email) {
            console.log("Updating email in Auth:", updatedData.email);
            await updateEmail(user, updatedData.email);
        }
        
        // Update UI with new data
        if (personalInfoElements.fullName) personalInfoElements.fullName.textContent = updatedData.fullName;
        if (personalInfoElements.phoneNumber) personalInfoElements.phoneNumber.textContent = updatedData.phoneNumber;
        if (personalInfoElements.email) personalInfoElements.email.textContent = updatedData.email;
        if (personalInfoElements.personalAddress) personalInfoElements.personalAddress.textContent = updatedData.personalAddress;
        if (userNameElement) userNameElement.textContent = updatedData.fullName;
        
        // Hide the edit slider
        hideEditSlider();
        
        alert('Profile updated successfully!');
    } catch (error) {
        console.error('Error updating profile:', error);
        if (error.code === 'auth/requires-recent-login') {
            alert('For security reasons, please log out and log back in before changing your email.');
        } else {
            alert('Failed to update profile: ' + error.message);
        }
    }
}

// Change user password
async function changePassword(currentPasswordInput, newPasswordInput, confirmPasswordInput) {
    try {
        const user = auth.currentUser;
        if (!user) {
            alert('You must be logged in to change your password');
            return;
        }
        
        console.log("Changing password for:", user.email);
        
        // Make sure we have all the form fields
        if (!currentPasswordInput || !newPasswordInput || !confirmPasswordInput) {
            alert('Cannot access password form fields. Please refresh the page and try again.');
            return;
        }
        
        const currentPassword = currentPasswordInput.value;
        const newPassword = newPasswordInput.value;
        const confirmPassword = confirmPasswordInput.value;
        
        // Validate passwords
        if (newPassword !== confirmPassword) {
            alert('New passwords do not match');
            return;
        }
        
        if (newPassword.length < 6) {
            alert('New password must be at least 6 characters long');
            return;
        }
        
        // Re-authenticate user before changing password
        const credential = EmailAuthProvider.credential(user.email, currentPassword);
        console.log("Re-authenticating user");
        
        await reauthenticateWithCredential(user, credential);
        console.log("User re-authenticated");
        
        await updatePassword(user, newPassword);
        console.log("Password updated");
        
        // Clear form and close modal
        document.getElementById('passwordChangeForm').reset();
        closeModal();
        
        alert('Password changed successfully!');
    } catch (error) {
        console.error('Error changing password:', error);
        if (error.code === 'auth/wrong-password') {
            alert('The current password you entered is incorrect.');
        } else {
            alert('Failed to change password: ' + error.message);
        }
    }
}