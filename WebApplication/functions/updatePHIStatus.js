const { onRequest } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

// Use existing initialized app from index.js
if (!admin.apps.length) {
  admin.initializeApp();
}
const db = admin.firestore();

exports.updatePHIStatus = onRequest(async (req, res) => {
  if (req.method === 'OPTIONS') {
    res.set('Access-Control-Allow-Origin', '*');
    res.set('Access-Control-Allow-Methods', 'POST');
    res.set('Access-Control-Allow-Headers', 'Content-Type');
    res.status(204).send('');
    return;
  }

  res.set('Access-Control-Allow-Origin', '*');

  if (req.method !== 'POST') {
    return res.status(405).send({ error: "Method Not Allowed" });
  }

  const { uid, status } = req.body;

  if (!uid || !status || !['Active', 'Inactive'].includes(status)) {
    return res.status(400).send({ error: "Invalid payload" });
  }

  try {
    await db.collection('users').doc(uid).update({ status });
    await admin.auth().updateUser(uid, {
      disabled: status === 'Inactive'
    });

    return res.status(200).send({ success: true });
  } catch (err) {
    console.error("Error updating PHI status:", err);
    return res.status(500).send({ error: err.message });
  }
});
