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

    // Reset error messages
    emailError.innerText = "";
    passwordError.innerText = "";
    messageDiv.innerText = "";

    // Simple Validation
    let hasError = false;

    if (!email.includes("@") || !email.includes(".")) {
      emailError.innerText = "Please enter a valid email address.";
      hasError = true;
    }

    if (password.length < 6) {
      passwordError.innerText = "Password must be at least 6 characters.";
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

      // ✅ Save session info
      sessionStorage.setItem("userRole", role);
      sessionStorage.setItem("userUID", user.uid);

      // Redirect based on role
      if (role === "SPHI") {
        window.location.href = "Registration.html";
      } else if (role === "PHI") {
        window.location.href = "Dashboard.html";
      } else {
        messageDiv.innerText = "Unknown role.";
      }

    } catch (error) {
      console.error("Login Error:", error);
      messageDiv.innerText = "Login failed: " + error.message;
    }
  });
});
