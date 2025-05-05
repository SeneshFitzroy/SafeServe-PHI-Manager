// inspection-log.js
import { auth, db } from './firebase-config.js';
import { doc, getDoc, collection, getDocs, query, where } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-firestore.js";
import { signOut } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-auth.js";

// Make functions visible to HTML
window.logoutUser = function (e) {
    e.preventDefault(); // prevent form reload
    sessionStorage.clear();
    window.location.href = "login.html"; // redirect to login
}

window.showViewSlider = function () {
    document.getElementById('viewSlider').classList.add('active');
}

window.hideViewSlider = function () {
    document.getElementById('viewSlider').classList.remove('active');
}

// Color the ranking grades
export function colorGrades() {
    const rankings = document.querySelectorAll('.element-4');
  
    rankings.forEach(function (rankElement) {
        const grade = rankElement.textContent.trim();
  
        rankElement.style.width = '30px';
        rankElement.style.height = '30px';
        rankElement.style.borderRadius = '50%';
        rankElement.style.display = 'flex';
        rankElement.style.alignItems = 'center';
        rankElement.style.justifyContent = 'center';
        rankElement.style.fontWeight = 'bold';
        rankElement.style.fontFamily = 'Arial, sans-serif';
  
        switch (grade) {
            case 'A':
                rankElement.style.backgroundColor = '#3DB952';
                rankElement.style.color = 'black';
                break;
            case 'B':
                rankElement.style.backgroundColor = '#F1D730';
                rankElement.style.color = 'black';
                break;
            case 'C':
                rankElement.style.backgroundColor = '#FF8514';
                rankElement.style.color = 'black';
                break;
            case 'D':
                rankElement.style.backgroundColor = '#BB1F22';
                rankElement.style.color = 'black';
                break;
            default:
                rankElement.style.backgroundColor = '#ccc';
                rankElement.style.color = 'black';
        }
    });
}


// Step 2: Fetch GN Divisions and then fetch shops
window.addEventListener("DOMContentLoaded", async () => {
    try {
        const user = auth.currentUser;

        // Wait for auth state
        const unsubscribe = auth.onAuthStateChanged(async (user) => {
            unsubscribe(); // stop listener after we get user
            if (!user) {
                window.location.href = "login.html";
                return;
            }

            const userDocRef = doc(db, "users", user.uid);
            const userSnap = await getDoc(userDocRef);

            if (!userSnap.exists()) {
                console.error("User data not found.");
                return;
            }

            const userData = userSnap.data();
            const gnDivisions = userData.gnDivisions;

            if (!gnDivisions || gnDivisions.length === 0) {
                console.log("No GN divisions assigned to this PHI.");
                return;
            }

            // Fetch all shops in any of the GN divisions
            const shopsRef = collection(db, "shops");
            const querySnapshot = await getDocs(shopsRef);
            const container = document.querySelector(".content-container");
            container.innerHTML = ""; // Clear existing static rows

            querySnapshot.forEach((docSnap) => {
                const shop = docSnap.data();
                if (gnDivisions.includes(shop.gnDivision)) {
                    const row = document.createElement("div");
                    row.classList.add("container-row");

                    row.innerHTML = `
                        <p class="element-1">${shop.referenceNo || ""}</p>
                        <p class="element-2">${shop.name || ""}</p>
                        <p class="element-3">${shop.gnDivision || ""}</p>
                        <p class="element-4">${shop.grade || "N/A"}</p>
                        <div class="actions">
                            <div class="view" data-id="${docSnap.id}">
                                <img src="images/view-icon.png">
                            </div>
                            <a href="HC800.html?shopId=${docSnap.id}">
                                <div class="edit">
                                    <img src="images/log-icon.png" alt="Edit">
                                </div>
                            </a>
                        </div>
                    `;


                    container.appendChild(row);
                }
            });

            colorGrades();

            // Add event listeners to view buttons
            document.querySelectorAll('.view').forEach((btn) => {
                btn.addEventListener('click', () => {
                    showViewSlider(); 
                    const shopId = btn.getAttribute('data-id');
                    loadShopDetails(shopId); 
                });
            });
        });
    } catch (error) {
        console.error("Error fetching shop data:", error);
    }
});


// Load and display shop details inside the View Slider
async function loadShopDetails(shopId) {
    try {
        const shopRef = doc(db, "shops", shopId);
        const shopSnap = await getDoc(shopRef);

        if (!shopSnap.exists()) {
            console.error("Shop not found!");
            return;
        }

        const shop = shopSnap.data();

        // Fill the form fields
        const formFields = document.querySelectorAll(".form-text");
        if (formFields.length >= 15) {
            formFields[0].value = shop.referenceNo || '';
            formFields[1].value = shop.gnDivision || '';
            formFields[2].value = shop.typeOfTrade || '';
            formFields[3].value = shop.ownerName || '';
            formFields[4].value = shop.privateAddress || '';
            formFields[5].value = shop.nicNumber || '';
            formFields[6].value = shop.privateAddress || ''; 
            formFields[7].value = shop.telephone || '';
            formFields[8].value = shop.name || '';
            formFields[9].value = shop.district || '';
            formFields[10].value = shop.gnDivision || '';
            formFields[11].value = shop.establishmentAddress || '';
            formFields[12].value = shop.licenseNumber || '';
            formFields[13].value = shop.licensedDate ? shop.licensedDate.toDate().getFullYear() : '';
            formFields[14].value = shop.businessRegNumber || '';
            formFields[15].value = shop.numberOfEmployees || '';
        }

    } catch (error) {
        console.error("Error loading shop details:", error);
    }
}
