document.addEventListener("DOMContentLoaded", () => {
    //
    // === Multi-Select Dropdown Functionality ===
    //
    const select = document.getElementById("multiSelectDropdown");
    const selectedOptionsContainer = document.getElementById("selected-options");
  
    // When an option is selected, add it to the container.
    select.addEventListener("change", function () {
      const selectedValue = select.value;
      if (selectedValue) {
        addSelectedOption(selectedValue);
        select.value = ""; // Reset dropdown
      }
    });
  
    // Function to add a selected option element (preserving your CSS classes)
    function addSelectedOption(value) {
      // Prevent duplicate selections
      if (document.querySelector(`[data-value="${value}"]`)) return;
  
      // Create the element with the same class as before for styling
      const optionElement = document.createElement("div");
      optionElement.classList.add("selected-option");
      optionElement.setAttribute("data-value", value);
      optionElement.innerHTML = `${value} <button class="remove-option">&times;</button>`;
  
      // Append the element to the container
      selectedOptionsContainer.appendChild(optionElement);
  
      // Remove the option when the remove button is clicked
      optionElement.querySelector(".remove-option").addEventListener("click", function () {
        selectedOptionsContainer.removeChild(optionElement);
      });
    }
  
    //
    // === PHI Registration Form Submission ===
    //
    const phiForm = document.getElementById("phi-registration-form");
    const phiIdError = document.getElementById("phiid-error");
    const passwordMatchError = document.getElementById("password-match-error");
  
    // Listen for form submission
    phiForm.addEventListener("submit", async (e) => {
      e.preventDefault();
  
      // Clear previous error messages
      phiIdError.innerText = "";
      passwordMatchError.innerText = "";
  
      // Gather form field values
      const phiId = document.getElementById("phi-id").value.trim();
      const fullName = document.getElementById("full-name").value.trim();
      const nic = document.getElementById("nic").value.trim();
      const phone = document.getElementById("phone").value.trim();
      const email = document.getElementById("email").value.trim();
      const personalAddress = document.getElementById("address").value.trim();
      const officeLocation = document.getElementById("office-location").value.trim();
      const district = document.getElementById("district").value.trim();
  
      // Collect all selected multi-select options for GN Divisions
      const selectedDivisionsElements = document.querySelectorAll("#selected-options .selected-option");
      let gnDivisions = [];
      selectedDivisionsElements.forEach(el => {
        const value = el.getAttribute("data-value");
        if (value) {
          gnDivisions.push(value);
        }
      });
  
      // Get passwords
      const password = document.getElementById("password").value;
      const confirmPassword = document.getElementById("confirm-password").value;
  
      // Validate PHI ID: Must be exactly 6 digits.
      if (!/^\d{6}$/.test(phiId)) {
        phiIdError.innerText = "PHI ID must be exactly 6 digits.";
        return;
      }
  
      // Validate that the password and confirm password match.
      if (password !== confirmPassword) {
        passwordMatchError.innerText = "Passwords do not match.";
        return;
      }
  
      // Prepare the payload to send to the Cloud Function
      const payload = {
        phiId: phiId,
        fullName: fullName,
        nic: nic,
        phone: phone,
        email: email,
        personalAddress: personalAddress,
        officeLocation: officeLocation,
        district: district,
        gnDivisions: gnDivisions,
        password: password
      };
  
      try {
        // Replace the URL below with your deployed Cloud Function's endpoint URL.
        const functionUrl = "https://us-central1-safe-serve-8de99.cloudfunctions.net/createPHIUser";
        const response = await fetch(functionUrl, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify(payload)
        });
        const data = await response.json();
        if (response.ok) {
          alert("PHI registered successfully!");document.addEventListener("DOMContentLoaded", () => {
  //
  // === Multi-Select Dropdown Functionality ===
  //
  const select = document.getElementById("multiSelectDropdown");
  const selectedOptionsContainer = document.getElementById("selected-options");

  // When an option is selected, add it to the container.
  select.addEventListener("change", function () {
    const selectedValue = select.value;
    if (selectedValue) {
      addSelectedOption(selectedValue);
      select.value = ""; // Reset dropdown
    }
  });

  // Function to add a selected option element (preserving your CSS classes)
  function addSelectedOption(value) {
    // Prevent duplicate selections
    if (document.querySelector(`[data-value="${value}"]`)) return;

    // Create the element with the same class as before for styling
    const optionElement = document.createElement("div");
    optionElement.classList.add("selected-option");
    optionElement.setAttribute("data-value", value);
    optionElement.innerHTML = `${value} <button class="remove-option">&times;</button>`;

    // Append the element to the container
    selectedOptionsContainer.appendChild(optionElement);

    // Remove the option when the remove button is clicked
    optionElement.querySelector(".remove-option").addEventListener("click", function () {
      selectedOptionsContainer.removeChild(optionElement);
    });
  }

  //
  // === PHI Registration Form Submission ===
  //
  const phiForm = document.getElementById("phi-registration-form");
  const phiIdError = document.getElementById("phiid-error");
  const passwordMatchError = document.getElementById("password-match-error");

  // Listen for form submission
  phiForm.addEventListener("submit", async (e) => {
    e.preventDefault();

    // Clear previous error messages
    phiIdError.innerText = "";
    passwordMatchError.innerText = "";

    // Gather form field values
    const phiId = document.getElementById("phi-id").value.trim();
    const fullName = document.getElementById("full-name").value.trim();
    const nic = document.getElementById("nic").value.trim();
    const phone = document.getElementById("phone").value.trim();
    const email = document.getElementById("email").value.trim();
    const personalAddress = document.getElementById("address").value.trim();
    const officeLocation = document.getElementById("office-location").value.trim();
    const district = document.getElementById("district").value.trim();

    // Collect all selected multi-select options for GN Divisions
    const selectedDivisionsElements = document.querySelectorAll("#selected-options .selected-option");
    let gnDivisions = [];
    selectedDivisionsElements.forEach(el => {
      const value = el.getAttribute("data-value");
      if (value) {
        gnDivisions.push(value);
      }
    });

    // Get passwords
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirm-password").value;

    // Validate PHI ID: Must be exactly 6 digits.
    if (!/^\d{6}$/.test(phiId)) {
      phiIdError.innerText = "PHI ID must be exactly 6 digits.";
      return;
    }

    // Validate that the password and confirm password match.
    if (password !== confirmPassword) {
      passwordMatchError.innerText = "Passwords do not match.";
      return;
    }

    // Prepare the payload to send to the Cloud Function
    const payload = {
      phiId: phiId,
      fullName: fullName,
      nic: nic,
      phone: phone,
      email: email,
      personalAddress: personalAddress,
      officeLocation: officeLocation,
      district: district,
      gnDivisions: gnDivisions,
      password: password
    };

    try {
      // Replace the URL below with your deployed Cloud Function's endpoint URL.
      const functionUrl = "https://us-central1-safe-serve-8de99.cloudfunctions.net/createPHIUser";
      const response = await fetch(functionUrl, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });
      const data = await response.json();
      if (response.ok) {
        alert("PHI registered successfully!");
        phiForm.reset();
        // Clear the multi-select container
        selectedOptionsContainer.innerHTML = "";
      } else {
        // Show an error message under PHI ID (or elsewhere as needed)
        if (data.error) {
          phiIdError.innerText = data.error;
        } else {
          phiIdError.innerText = "Registration failed. Please try again.";
        }
      }
    } catch (error) {
      console.error("Error during registration:", error);
      phiIdError.innerText = "Registration error: " + error.message;
    }
  });
});
          phiForm.reset();
          // Clear the multi-select container
          selectedOptionsContainer.innerHTML = "";
        } else {
          // Show an error message under PHI ID (or elsewhere as needed)
          if (data.error) {
            phiIdError.innerText = data.error;
          } else {
            phiIdError.innerText = "Registration failed. Please try again.";
          }
        }
      } catch (error) {
        console.error("Error during registration:", error);
        phiIdError.innerText = "Registration error: " + error.message;
      }
    });
  });
  