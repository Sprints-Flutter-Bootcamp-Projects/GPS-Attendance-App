# GPS Attendance System

### This project was developed as part of the Flutter Bootcamp by Sprints.
<img src="/readme_data/pics/sprints.png" alt="sprints" height="100">

## 📌 Project Overview
The **GPS Attendance System** is designed to automate employee attendance tracking using geolocation technology. By verifying employee presence within designated work zones, this system minimizes errors and administrative overhead, ensuring a seamless and efficient attendance management process.


## 🎯 Objectives
### **Main Objective:**
To develop a **reliable, accurate, and user-friendly GPS-based attendance system** that enhances efficiency in recording employee attendance.

### **Specific Objectives:**
✔️ **Automated Attendance Tracking:** Record attendance based on GPS location. <br>
✔️ **Real-time Synchronization:** Ensure instant data updates across all devices.<br>
✔️ **User-Friendly Interface:** Provide an intuitive experience for employees and administrators. <br>


## 🛠️ Technology Stack
| Component  | Technology Used  |
|------------|-----------------|
| **Mobile Platform** | Android (6.0+) / iOS (11+) |
| **Backend Services** | Google Firebase Firestore (Real-time cloud database) |
| **Development Tools** | Android Studio, VS Code |
| **Version Control** | GitHub |


## 📚 Dependencies & Libraries
- **State Management:** `flutter_bloc`
- **Networking:** `dio`
- **Database & Authentication:** `firebase_auth`, `firebase_core`, `cloud_firestore`, `firebase_database`
- **Geolocation & Maps:** `geolocator`, `google_maps_flutter`
- **Localization:** `easy_localization`, `intl`
- **UI Components:** `font_awesome_flutter`, `syncfusion_flutter_calendar`
- **Storage & Preferences:** `shared_preferences`
- **Testing & Linting:** `flutter_test`, `flutter_lints`
- **Utilities:** `equatable`, `image_picker`, `get_it`

---

## 🎨 Fonts Used
The project uses the **Inter** font family with various weights:
- **Inter Variable Font**
- **Static Fonts:**
  - `Inter_18pt-Black.ttf` (900)
  - `Inter_18pt-ExtraBold.ttf` (800)
  - `Inter_18pt-Bold.ttf` (700)
  - `Inter_18pt-SemiBold.ttf` (600)
  - `Inter_18pt-Medium.ttf` (500)
  - `Inter_24pt-Black.ttf` (900)
  - `Inter_24pt-ExtraBold.ttf` (800)
  - `Inter_24pt-Bold.ttf` (700)
  - `Inter_24pt-SemiBold.ttf` (600)
  - `Inter_24pt-Medium.ttf` (500)
  - `Inter_28pt-Black.ttf` (900)
  - `Inter_28pt-ExtraBold.ttf` (800)
  - `Inter_28pt-Bold.ttf` (700)
  - `Inter_28pt-SemiBold.ttf` (600)
  - `Inter_28pt-Medium.ttf` (500)

---

## 🌍 Localization
The application supports **multi-language localization**, with translations available in:
- **English:** `assets/translations/en.json`
- **Arabic:** `assets/translations/ar.json`

---

## 🎨 UI/UX Design
The application design is based on a **Figma prototype**, ensuring a modern and user-friendly interface. <br>
📌 **Figma Design File:** [[Figma Link](https://www.figma.com/design/7LhsecbOMxe8J1yfy0jOQ7/GPS-Attendance?node-id=4-17868)]

<!-- ### 📸 Screenshots of Key Screens
Here are some snapshots of the application interface:
1. **Login Screen**
2. **Dashboard**
3. **Attendance Tracking Page**
4. **Profile & Settings**
5. **Admin Panel** -->


## 📽️ GIFs and Video Demo
Here are some previews of the functionalities

<table border="1">
  <tr>
    <th>Login</th>
    <th>Navbar</th>

  </tr>
  <tr>
    <td><img src="/readme_data/gifs/1-login.gif" alt="login" height="600"></td>
    <td><img src="/readme_data/gifs/2-navbar.gif" alt="navbar" height="600"></td>
  </tr>

  <tr>
    <th>Check-in Fail</th>
    <th>Admin Update and Check-in</th>
  </tr>
  <tr>
    <td><img src="/readme_data/gifs/3-check in fail.gif" alt="checkin-fail" height="600"></td>
    <td><img src="/readme_data/gifs/4-admin update and check in.gif" alt="admin-checkin-success" height="600"></td>
  </tr>

  <tr>
    <th>Check-out</th>
    <th>Attendance</th>
    
  </tr>
  <tr>
    <td><img src="/readme_data/gifs/5-check out.gif" alt="check-out" height="600"></td>
    <td><img src="/readme_data/gifs/6-attendance.gif" alt="attendance" height="600"></td>
  </tr>
</table>

A full video walkthrough of the app’s core functionalities is available here: 
📌 **Demo Video:** [[Link to Video](https://drive.google.com/file/d/13rrHQZPvTE4dlmxH8SgnBbfOK1TDERrQ/view?usp=sharing)]


## 🚀 Features & Functionalities
✔️ **GPS Attendance Recording:** Employees check in/out based on predefined geofences.  
✔️ **Time Stamping & Real-Time Updates:** Attendance logs are timestamped and synced instantly.  
✔️ **Employee Profile Access:** View attendance history, leave balance, and recent check-ins.  
✔️ **Admin Dashboard:** Manage employees, review attendance logs, and generate reports.  



## 🔧 System Requirements
- **Hardware:** GPS-enabled smartphone (Android 6.0+ / iOS 11+)
- **Software:** Requires location permissions & internet access for cloud sync


## 🛠 Environment Setup
### **Development Environment**
1. Clone the repository:
   ```sh
   git clone https://github.com/Sprints-Flutter-Bootcamp-Projects/GPS-Attendance-App.git
   ```
2. Open the project in **Android Studio**, **VS Code**, or **Xcode**.
3. Install dependencies:
   ```sh
   flutter pub get
   ```
4. Configure Firebase Firestore with project credentials.

### **Testing Environment**
- Firebase Test Lab for simulated environments
- Physical device testing to ensure cross-platform compatibility



## 👥 THE TEAM
### 👨‍💻 We are 6 Flutter Developers & Engineers collaborating together on the project
1. Mohamed Magdy
2. Mohamed Matar
3. Khaled Mohamed
4. Loay Sherif
5. Hana Essam
6. Gina Ezzat



## 📅 Project Timeline
⏳ Estimated Duration: **10-14 Days**


## 📦 Deliverables
📄 **Documentation:** System design, code documentation, and user manuals.  
📂 **Application Files:** Final app files, source code, and repository access. <br>
📽️ **Demo Video & Screenshots:** Walkthrough of app functionalities.


## 📌 Conclusion
Implementing this **GPS Attendance System** will significantly enhance operational efficiency for the companies by automating attendance tracking, reducing manual errors, and providing accurate, real-time attendance data.

## 📞 Contact
For any inquiries or contributions, feel free to reach out to us or check out our repository on **[GitHub](https://github.com/Sprints-Flutter-Bootcamp-Projects/GPS-Attendance-App.git)**.
