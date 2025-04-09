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

  loginForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    const email = document.getElementById("username").value;
    const password = document.getElementById("password").value;

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
