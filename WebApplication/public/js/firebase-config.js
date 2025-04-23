// firebase-config.js
import { initializeApp } from "firebase/app";

// Your web app's Firebase configuration
// Replace these with your actual Firebase project configuration
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "safeserve-app.firebaseapp.com",
  projectId: "safeserve-app",
  storageBucket: "safeserve-app.appspot.com",
  messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
  appId: "YOUR_APP_ID"
};

// Initialize Firebase
export const app = initializeApp(firebaseConfig);