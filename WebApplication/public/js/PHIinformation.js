// PHIinformation.js
import { 
    getFirestore, 
    doc, 
    getDoc, 
    updateDoc, 
    collection, 
    query, 
    where, 
    getDocs 
  } from "firebase/firestore";
  import { getAuth, updatePassword, reauthenticateWithCredential, EmailAuthProvider } from "firebase/auth";
  import { app } from "./firebase-config.js";
  
  // Initialize Firebase services
  const db = getFirestore(app);
  const auth = getAuth(app);
  
  // DOM elements
  const fullNameElement = document.querySelector('.info-card:nth-child(1) p:nth-child(2) span:last-child');
  const phiIdElement = document.querySelector('.info-card:nth-child(1) p:nth-child(1) span:last-child');
  const nicElement = document.querySelector('.info-card:nth-child(1) p:nth-child(3) span:last-child');
  const roleElement = document.querySelector('.info-card:nth-child(1) p:nth-child(4) span:last-child');
  const phoneElement = document.querySelector('.info-card:nth-child(1) p:nth-child(5) span:last-child');
  const emailElement = document.querySelector('.info-card:nth-child(1) p:nth-child(6) span:last-child');
  const addressElement = document.querySelector('.info-card:nth-child(1) p:nth-child(7) span:last-child');
  
  const districtElement = document.querySelector('.info-card:nth-child(2) p:nth-child(1) span:last-child');
  const officeLocationElement = document.querySelector('.info-card:nth-child(2) p:nth-child(2) span:last-child');
  const divisionsContainer = document.querySelector('.division-list');
  
  const userNameElement = document.querySelector('.user-name');
  const userRoleElement = document.querySelector('.user-role');
  
  // Form elements
  const editForm = document.querySelector('.edit-form');
  const fullNameInput = editForm.querySelector('input:nth-child(1)');
  const phoneInput = editForm.querySelector('input:nth-child(2)');
  const emailInput = editForm.querySelector('input:nth-child(3)');
  const addressInput = editForm.querySelector('input:nth-child(4)');
  
  const passwordForm = document.querySelector('.modal-body form');
  const oldPasswordInput = passwordForm.querySelector('input:nth-child(1)');
  const newPasswordInput = passwordForm.querySelector('input:nth-child(2)');
  const confirmPasswordInput = passwordForm.querySelector('input:nth-child(3)');
  
  // Current user data
  let currentUserData = {};
  
  // Load user data when page loads
  document.addEventListener('DOMContentLoaded', async () => {
      await loadUserData();
      populateEditForm();
  });
  
  // Function to load user data from Firestore
  async function loadUserData() {
      try {
          // Get current user
          const user = auth.currentUser;
          
          if (!user) {
              console.error('No user logged in');
              window.location.href = 'login.html';
              return;
          }
  
          // Get user document from Firestore
          const userDocRef = doc(db, "users", user.uid);
          const userDoc = await getDoc(userDocRef);
  
          if (userDoc.exists()) {
              // Store user data
              currentUserData = userDoc.data();
              
              // Populate personal information section
              fullNameElement.textContent = currentUserData.fullName || '';
              phiIdElement.textContent = currentUserData.phiId || '';
              nicElement.textContent = currentUserData.nic || '';
              roleElement.textContent = currentUserData.role || '';
              phoneElement.textContent = currentUserData.phoneNumber || '';
              emailElement.textContent = currentUserData.email || '';
              addressElement.textContent = currentUserData.personalAddress || '';
  
              // Populate work information section
              districtElement.textContent = currentUserData.district || '';
              officeLocationElement.textContent = currentUserData.officeLocation || '';
              
              // Update user info in header
              userNameElement.textContent = currentUserData.fullName || '';
              userRoleElement.textContent = currentUserData.role || '';
  
              // Populate divisions
              if (currentUserData.assignedDivisions && Array.isArray(currentUserData.assignedDivisions)) {
                  divisionsContainer.innerHTML = '';
                  currentUserData.assignedDivisions.forEach(division => {
                      const divElement = document.createElement('div');
                      divElement.classList.add('division');
                      divElement.textContent = division;
                      divisionsContainer.appendChild(divElement);
                  });
              }
          } else {
              console.error('User document not found');
          }
      } catch (error) {
          console.error('Error loading user data:', error);
      }
  }
  
  // Function to populate edit form with current data
  function populateEditForm() {
      fullNameInput.value = currentUserData.fullName || '';
      phoneInput.value = currentUserData.phoneNumber || '';
      emailInput.value = currentUserData.email || '';
      addressInput.value = currentUserData.personalAddress || '';
  }
  
  // Handle edit form submission
  editForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      
      try {
          const user = auth.currentUser;
          
          if (!user) {
              alert('You must be logged in to update your profile');
              return;
          }
          
          const userDocRef = doc(db, "users", user.uid);
          
          // Create updated data object
          const updatedData = {
              fullName: fullNameInput.value.trim(),
              phoneNumber: phoneInput.value.trim(),
              email: emailInput.value.trim(),
              personalAddress: addressInput.value.trim(),
              lastUpdated: new Date()
          };
          
          // Check if email is changing
          if (updatedData.email !== user.email) {
              // Email change requires re-authentication
              // This example doesn't handle email changes in Firebase Auth
              // You would need to implement this separately with updateEmail()
              alert('Email changes require re-authentication');
          }
          
          // Update Firestore document
          await updateDoc(userDocRef, updatedData);
          
          // Reload user data to reflect changes
          await loadUserData();
          
          // Hide the slider
          hideEditSlider();
          
          alert('Profile updated successfully');
      } catch (error) {
          console.error('Error updating profile:', error);
          alert('Failed to update profile: ' + error.message);
      }
  });
  
  // Handle password change form submission
  passwordForm.addEventListener('submit', async (e) => {
      e.preventDefault();
      
      try {
          const user = auth.currentUser;
          
          if (!user) {
              alert('You must be logged in to change your password');
              return;
          }
          
          const oldPassword = oldPasswordInput.value;
          const newPassword = newPasswordInput.value;
          const confirmPassword = confirmPasswordInput.value;
          
          // Validate inputs
          if (!oldPassword || !newPassword || !confirmPassword) {
              alert('All fields are required');
              return;
          }
          
          if (newPassword !== confirmPassword) {
              alert('New passwords do not match');
              return;
          }
          
          if (newPassword.length < 6) {
              alert('Password must be at least 6 characters');
              return;
          }
          
          // Re-authenticate user
          const credential = EmailAuthProvider.credential(user.email, oldPassword);
          await reauthenticateWithCredential(user, credential);
          
          // Update password
          await updatePassword(user, newPassword);
          
          // Reset form
          passwordForm.reset();
          
          // Close modal
          closeModal();
          
          alert('Password changed successfully');
      } catch (error) {
          console.error('Error changing password:', error);
          
          if (error.code === 'auth/wrong-password') {
              alert('The current password you entered is incorrect');
          } else {
              alert('Failed to change password: ' + error.message);
          }
      }
  });