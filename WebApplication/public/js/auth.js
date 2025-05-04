import { auth, db } from './firebase-config.js';
import {
  signInWithEmailAndPassword
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

import {
  doc,
  getDoc
} from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

document.addEventListener("DOMContentLoaded", () => {
  const loginForm = document.querySelector("#login-form form");
  const messageDiv = document.getElementById("message");
  const emailError = document.getElementById("email-error");
  const passwordError = document.getElementById("password-error");

  loginForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.getElementById("username").value.trim();
    const password = document.getElementById("password").value;

  // Reset error styles
  emailError.innerText = "";
  passwordError.innerText = "";
  messageDiv.innerText = "";
  document.getElementById("username").classList.remove("invalid");
  document.getElementById("password").classList.remove("invalid");
  emailError.style.display = "none";
  passwordError.style.display = "none";

  let hasError = false;

  // Email Validation
  if (!email.includes("@") || !email.includes(".")) {
    emailError.innerText = "Please enter a valid email address.";
    emailError.style.display = "block";
    document.getElementById("username").classList.add("invalid");
    hasError = true;
  }

  // Password Validation
  if (password.length < 6) {
    passwordError.innerText = "Password must be at least 6 characters.";
    passwordError.style.display = "block";
    document.getElementById("password").classList.add("invalid");
    hasError = true;
  }

  if (hasError) return;


    try {
      // Firebase login
      const userCredential = await signInWithEmailAndPassword(auth, email, password);
      const user = userCredential.user;

      // Get user role from Firestore
      const userDoc = await getDoc(doc(db, "users", user.uid));
      if (!userDoc.exists()) {
        messageDiv.innerText = "No role assigned. Contact admin.";
        return;
      }

      const userData = userDoc.data();
      const role = userData.role;
      const fullName = userData.full_name || "Unknown User"; 

      // Save session info
      sessionStorage.setItem("userRole", role);
      sessionStorage.setItem("userUID", user.uid);
      sessionStorage.setItem("userFullName", fullName); 


      // Redirect based on role
      if (role === "SPHI") {
        window.location.href = "Dashboard.html";
      } else if (role === "PHI") {
        window.location.href = "Dashboard.html";
      } else {
        messageDiv.innerText = "Unknown role.";
      }

    } catch (error) {
      console.error("Login Error:", error);
    
      const errorCode = error.code;
    
      // Reset styles
      messageDiv.innerText = "";
      emailError.innerText = "";
      passwordError.innerText = "";
      document.getElementById("username").classList.remove("invalid");
      document.getElementById("password").classList.remove("invalid");
    
      if (errorCode === "auth/user-not-found") {
        emailError.innerText = "No user found with this email.";
        emailError.style.display = "block";
        document.getElementById("username").classList.add("invalid");
      } else if (errorCode === "auth/wrong-password") {
        passwordError.innerText = "Incorrect password.";
        passwordError.style.display = "block";
        document.getElementById("password").classList.add("invalid");
      } else {
        messageDiv.innerText = "Login failed: " + error.message;
        messageDiv.style.display = "block";
      }
    }
    
  });
});
