// Firebase Core + Auth + Firestore + Analytics
import { initializeApp } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-analytics.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";
import { getFirestore } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";

// Your Firebase Config
const firebaseConfig = {
  apiKey: "AIzaSyDkToPSenEOqJndHZWpeZFmjFoMq3ilaxU",
  authDomain: "safe-serve-8de99.firebaseapp.com",
  projectId: "safe-serve-8de99",
  storageBucket: "safe-serve-8de99.appspot.com",
  messagingSenderId: "727349367277",
  appId: "1:727349367277:web:289abe7520c7eb9cd257e4",
  measurementId: "G-B2RB0KLNXL"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

// Export auth and db to use elsewhere
export const auth = getAuth(app);
export const db = getFirestore(app);
