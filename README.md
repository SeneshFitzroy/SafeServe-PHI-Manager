# SafeServe: PHI Manager 🚀

**SafeServe: PHI Manager** is a **mobile** and **web-based** application designed to streamline the **food inspection** and **monitoring process** for **Public Health Inspectors (PHIs)** in Sri Lanka. This digital solution aims to replace inefficient **manual**, **paper-based** methods with a modern platform that ensures **data accuracy**, enhances **productivity**, and simplifies the management of inspections, follow-ups, and compliance tracking. 🍽️📱

## 📝 Project Overview
The SafeServe platform is built to:
- Automate food safety inspections,
- Provide real-time, geo-tagged records,
- Improve coordination with a centralized cloud system,
- Ensure seamless operations even without internet connectivity. 🌐

### 🌟 **Key Features:**
- **Geo-tagging 📍**: Capture location data and timestamps automatically during inspections to maintain reliable records.
- **Offline-first Design 📶**: Continue inspections without internet access; auto-sync once connected to the network.
- **Advanced Search 🔍**: Quickly retrieve historical inspection records from a centralized database.
- **Scheduling & Notifications 📅**: Manage daily tasks, reschedule visits, and get automated reminders for follow-ups and compliance checks.
- **Centralized Data ☁️**: Inspection records stored securely on the cloud (AWS) for easy access and real-time updates.

### 💻 **Technologies Used:**
- **Mobile App**: 
  - **Flutter** for frontend development,
  - **Node.js** for backend services.
- **Web App**:
  - **HTML**, **CSS** for frontend,
  - **PHP** for backend.
- **Database**:
  - **SQLite** for offline data storage,
  - **MySQL/Firebase** for cloud synchronization.
- **Cloud**:
  - **AWS** for hosting, storage, and scalability.
- **Geo-Location**:
  - **Google Maps API** for geo-tagging.
- **Notifications**:
  - Libraries for alerts and reminders.

### 🚀 **Benefits:**
- **For PHIs**: Streamlined workflows, reduced administrative tasks, and enhanced productivity.
- **For Ministry of Health (MOH)**: Centralized access to data, real-time trend analysis, and optimized resource allocation.
- **For Government**: Increased accountability, better public health outcomes, and cost-effective operations through digitization.
- **For Public & Establishments**: Faster response times to complaints, improved transparency, and higher trust in the inspection process.

---

## 🛠️ **Getting Started**

### 1. **Clone the Repository**:
```bash
git clone https://github.com/SeneshFitzroy/SafeServe-PHI-Manager.git
cd SafeServe-PHI-Manager
```

### 2. **Install Dependencies**:
For both **Mobile App** and **Web App**, make sure to install all the required dependencies.

#### **Mobile App (Flutter)**:
```bash
cd MobileApplication/safeServe
flutter pub get
```

#### **Web App**:
```bash
cd WebApplication
npm install
```

### 3. **Set Up Environment Variables**:
Create a `.env` file in the root directory and add the following keys:

```bash
MONGODB_URI=your_mongodb_connection_url
FIREBASE_API_KEY=your_firebase_api_key
REACT_APP_BACKEND_URL=http://localhost:5000
REACT_APP_FRONTEND_URL=http://localhost:3000
```

### 4. **Run the Application**:

#### **Backend (Node.js)**:
```bash
cd backend
node server.js
```

#### **Frontend (React)**:
```bash
cd frontend
npm start
```

---

## 🌍 **Future Enhancements**:
- **AI-based Data Insights 🤖**: Using machine learning to provide real-time data insights and trends from inspection records.
- **Admin Dashboard 📊**: Implementing an advanced admin panel for easier management and oversight.
- **Mobile App for iOS 📱**: Expanding the app for iOS to cater to a broader audience.

---

## 📢 **Contact Us**:
For any collaboration, inquiries, or more information, feel free to contact us via **GitHub Issues** or email. 💬

---

## 📄 **License**
This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). 📝

---

### 🚀 Let's transform food safety inspections together! 🌟
