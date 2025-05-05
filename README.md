# 🍽️ SafeServe: PHI Manager 🚀

**SafeServe: PHI Manager** is a **game-changing** mobile and web platform revolutionizing **food safety inspections** for **Public Health Inspectors (PHIs)** in Sri Lanka. Say goodbye to cumbersome **paper-based processes** and hello to a sleek, **digital solution** that ensures **accuracy**, boosts **productivity**, and streamlines **inspections**, **follow-ups**, and **compliance tracking**. With SafeServe, we're building a safer, healthier future—one inspection at a time. 🌐📱

---

## 📑 **Table of Contents**
- [🌟 Project Overview](#project-overview)
- [🔥 Key Features](#key-features)
- [🛠️ Technologies Used](#technologies-used)
- [🎯 Benefits](#benefits)
- [📚 Resources](#resources)
- [🚀 Getting Started](#getting-started)
- [🌍 Future Enhancements](#future-enhancements)
- [🤝 Contributing](#contributing)
- [📬 Contact Us](#contact-us)
- [📜 License](#license)

---

## 🌟 **Project Overview**

SafeServe is a **next-generation platform** designed to transform the food inspection process by **automating workflows**, enabling **real-time data capture**, and fostering **seamless coordination** through a centralized cloud system. Whether online or offline, SafeServe empowers PHIs to work efficiently, even in remote areas with limited connectivity. 🍴🌍

### 🎯 **Mission**
- Replace outdated manual processes with a **fully digital ecosystem**.
- Deliver **geo-tagged**, **timestamped** records for unparalleled accuracy.
- Enable **real-time cloud synchronization** for secure, accessible data.
- Enhance **transparency**, **accountability**, and **public trust** in food safety.

---

## 🔥 **Key Features**

| Feature | Description |
|---------|-------------|
| **Geo-tagging 📍** | Automatically capture location and timestamp for verifiable inspection records. |
| **Offline-First Design 📶** | Conduct inspections without internet; sync data seamlessly when connected. |
| **Advanced Search 🔍** | Retrieve historical records instantly with powerful database filters. |
| **Scheduling & Notifications 📅** | Manage tasks, reschedule visits, and receive automated reminders. |
| **Centralized Cloud Storage ☁️** | Securely store data on AWS for real-time access and scalability. |
| **Intuitive UI 🎨** | User-friendly interfaces for mobile (Flutter) and web (React) platforms. |

---

## 🛠️ **Technologies Used**

SafeServe is built with **cutting-edge technologies** to ensure performance, scalability, and reliability:

### **Mobile App**
- **Frontend**: Flutter (Dart) for cross-platform Android & iOS support.
- **Backend**: Node.js with Express.js for robust API services.
- **Offline Storage**: SQLite for local data caching.
- **Geo-Location**: Google Maps API for precise geo-tagging.
- **Notifications**: Firebase Cloud Messaging (FCM) for timely alerts.

### **Web App**
- **Frontend**: React.js with Tailwind CSS for responsive, modern UI.
- **Backend**: PHP with Laravel for secure server-side logic.
- **Database**: MySQL for cloud-based data storage and synchronization.
- **Hosting**: AWS (EC2, S3, RDS) for reliable infrastructure.

### **Shared Infrastructure**
- **Cloud**: AWS for hosting, storage, and scalability.
- **Authentication**: Firebase Authentication for secure user management.
- **API**: RESTful APIs for seamless mobile-web communication.

---

## 🎯 **Benefits**

### **For Public Health Inspectors (PHIs)**
- **Streamlined Workflows**: Focus on inspections, not paperwork.
- **Offline Capabilities**: Work anywhere, anytime.
- **Boosted Productivity**: Save time with automation.

### **For Ministry of Health (MOH)**
- **Centralized Insights**: Monitor trends and compliance in real-time.
- **Optimized Resources**: Allocate PHIs based on data-driven decisions.
- **Scalable Reporting**: Generate actionable reports effortlessly.

### **For Government**
- **Cost Efficiency**: Reduce expenses through digitization.
- **Accountability**: Ensure transparent, traceable processes.
- **Public Health**: Elevate food safety standards nationwide.

### **For Public & Food Establishments**
- **Rapid Responses**: Address issues quickly.
- **Transparency**: Build trust with verifiable records.
- **Compliance Ease**: Simplify adherence to regulations.

---

## 📚 **Resources**

Explore the core assets driving SafeServe's development:

- **UI Design**  
  📐 [Figma Prototype](https://www.figma.com/design/rNu3OoRDd0bSIG9Thur55I/Safe-Serve?node-id=0-1&t=Eospvkfa4JttxDQT-1)  
  A visually stunning, user-centric design for mobile and web interfaces.

- **Project Proposal**  
  📝 [View Proposal](https://nsbm365-my.sharepoint.com/:f:/g/personal/dsfmendis_students_nsbm_ac_lk/Ej0bXRVol3RFpMIiYKFXUUoBBAIslw50sxnC0NOUQxpNtQ?e=Asa3zH)  
  Detailed project vision and objectives.

- **Project Report**  
  📊 *Link to be added*  
  Comprehensive documentation of SafeServe's development and impact.

---

## 🚀 **Getting Started**

Set up SafeServe locally in just a few steps!

### **Prerequisites**
- **Node.js** (v16+)
- **Flutter** (v3+)
- **PHP** (v8+)
- **MySQL** (v8+)
- **AWS CLI** (optional for cloud setup)
- **Git**

### 1. **Clone the Repository**
```bash
git clone https://github.com/SeneshFitzroy/SafeServe-PHI-Manager.git
cd SafeServe-PHI-Manager
```

### 2. **Install Dependencies**

#### **Mobile App (Flutter)**
```bash
cd MobileApplication/safeServe
flutter pub get
```

#### **Web App (React)**
```bash
cd WebApplication/frontend
npm install
```

#### **Backend (Node.js & PHP)**
```bash
cd WebApplication/backend
npm install
composer install
```

### 3. **Set Up Environment Variables**
Create `.env` files in `MobileApplication` and `WebApplication` roots:

```bash
# Firebase Configuration
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_AUTH_DOMAIN=your_firebase_auth_domain
FIREBASE_PROJECT_ID=your_firebase_project_id

# Backend URLs
REACT_APP_BACKEND_URL=http://localhost:5000
REACT_APP_FRONTEND_URL=http://localhost:3000

# Database Configuration
MYSQL_HOST=localhost
MYSQL_USER=your_mysql_user
MYSQL_PASSWORD=your_mysql_password
MYSQL_DATABASE=safeserve_db

# AWS Configuration (Optional)
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
AWS_REGION=your_aws_region
```

### 4. **Run the Application**

#### **Backend (Node.js)**
```bash
cd WebApplication/backend
node server.js
```

#### **Backend (PHP/Laravel)**
```bash
cd WebApplication/backend
php artisan serve
```

#### **Frontend (React)**
```bash
cd WebApplication/frontend
npm start
```

#### **Mobile App (Flutter)**
```bash
cd MobileApplication/safeServe
flutter run
```

### 5. **Database Setup**
- Import `safeserve_db.sql` into MySQL.
- Configure Firebase for authentication and notifications.

---

## 🌍 **Future Enhancements**

SafeServe is just getting started! Upcoming features include:

- **AI-Powered Insights 🤖**  
  Use machine learning to predict compliance risks and trends.

- **Admin Dashboard 📊**  
  A robust panel for MOH to oversee PHI activities and generate reports.

- **iOS Support 📱**  
  Expand Flutter app to iOS for wider accessibility.

- **Multi-Language Support 🌐**  
  Add Sinhala, Tamil, and more for inclusive usability.

- **IoT Integration 🛠️**  
  Connect with IoT devices for real-time environmental monitoring.

---

## 🤝 **Contributing**

We love community contributions! To get involved:

1. Fork the repository.
2. Create a branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m 'Add your feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a Pull Request.

See our [Contributing Guidelines](CONTRIBUTING.md) for details.

---

## 📬 **Contact Us**

Got questions or ideas? Reach out:
- **GitHub Issues**: [SafeServe Issues](https://github.com/SeneshFitzroy/SafeServe-PHI-Manager/issues)
- **Email**: [safeserve.support@example.com](mailto:safeserve.support@example.com)

---

## 📜 **License**

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT). See [LICENSE](LICENSE) for details.

---

## 🌟 **Join the Food Safety Revolution!**

SafeServe isn’t just an app—it’s a **movement** to modernize food safety inspections and create healthier communities in Sri Lanka. Let’s build a **safer**, **smarter**, and **more transparent** future together! 🚀🍽️
