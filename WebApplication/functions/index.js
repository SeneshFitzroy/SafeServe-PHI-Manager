/**
 * Cloud Function: createPHIUser
 * This function validates input, ensures that the PHI ID is unique,
 * creates a new Auth user (without affecting the currently logged-in SPHI session),
 * and writes the new PHI's data to the "users" collection in Firestore.
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");
const admin = require("firebase-admin");

admin.initializeApp();
const db = admin.firestore();

exports.createPHIUser = onRequest(async (req, res) => {
  // Allow only POST requests.
  if (req.method !== "POST") {
    res.status(405).send({error: "Method Not Allowed"});
    return;
  }

  try {
    // Extract fields from the request body.
    const {phiId, fullName, nic, phone, email, personalAddress, officeLocation, district, gnDivisions, password} = req.body;

    // Validate PHI ID: must be exactly 6 digits.
    if (!/^\d{6}$/.test(phiId)) {
      res.status(400).send({error: "PHI ID must be exactly 6 digits."});
      return;
    }

    // Check uniqueness: Query the "users" collection for the given PHI ID.
    const querySnapshot = await db.collection("users")
      .where("phiId", "==", phiId)
      .get();

    if (!querySnapshot.empty) {
      res.status(400).send({error: "PHI ID already exists."});
      return;
    }

    // Create a new Firebase Auth user. This does not affect the SPHI's session.
    const newUser = await admin.auth().createUser({
      email: email,
      password: password,
      displayName: fullName
    });

    // Prepare the new PHI's data.
    const userData = {
      phiId: phiId,
      full_name: fullName,
      nic: nic,
      phone: phone,
      email: email,
      personalAddress: personalAddress,
      officeLocation: officeLocation,
      district: district,
      gnDivisions: gnDivisions,
      role: "PHI",
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    // Write the new user's data to the "users" collection.
    await db.collection("users").doc(newUser.uid).set(userData);

    res.status(200).send({success: true, uid: newUser.uid});
  } catch (error) {
    logger.error("Error creating PHI user:", error);
    res.status(500).send({error: error.message});
  }
});
