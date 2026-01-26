## NetMark - Automated Instant Network Attendance 

NetMark is a simple attendance system:

- A **Flutter client** (mobile) used by admins/faculty and students.
- A **Python Flask backend** that:
  - accepts a **class list CSV upload**
  - verifies students by **Registration Number**
  - stores attendance with **timestamp** and **duplicate-prevention**
  - provides **student list**, **present/absent stats**, and **search**

This project uses CSV files for **local backup and offline storage**. When network connectivity is restored, data automatically syncs to the cloud server, ensuring no attendance records are lost during network interruptions.

---

### Important note: no model training

This repository **does not include any ML dataset**, and it **does not perform training**

- The **only “data”** used by the backend is the **class list CSV** that an admin uploads at runtime.
- Attendance is recorded as CSV rows (registration number + timestamp + IP).
- You may see Flutter dependencies like `tflite_flutter` / `tflite_flutter_helper` in `file_sender/pubspec.yaml`—these are **not used for any dataset training/testing in this project** (they are scaffolding for future/optional features).

---

## Repository layout

- `file_sender/`: Flutter app (Android/iOS/Web/Windows/macOS/Linux depending on your toolchain)
- `Server_regNoSend.py`: Main Flask server (CSV upload, lookup, mark attendance, stats, search)
- `server.py`: Minimal Flask upload example (not used by the main Flutter flow)

### Runtime-generated files (local backup/offline storage)

These CSV files are created at runtime as **local backups** for offline operation. When network connectivity is available, data automatically syncs to the cloud server:

- `user_data.csv`: latest uploaded class list (backed up locally)
- `verified_ids.csv`: attendance records (present students + timestamps) - synced to cloud when online
- `ip_tracking.csv`: IP tracking used for duplicate prevention

---

## Project Files Documentation

This section provides a comprehensive explanation of all files in the project structure, their purposes, and how they interact with each other.

### Backend Files

#### `Server_regNoSend.py` (Main Flask Server)

**Location**: Root directory  
**Purpose**: Main Flask backend server that handles all attendance-related operations.

**Key Features**:
- **CSV Upload Handler** (`/upload_csv`): Accepts class list CSV files from admins/faculty. See [CSV format section](#csv-format-class-list) for required format.
- **Student Lookup** (`/get_user/<unique_id>`): Verifies student registration numbers against the uploaded class list. Returns student details and warns if attendance is already marked.
- **Attendance Marking** (`/upload_unique_id/<unique_id>` and `/mark_attendance`): Records attendance with timestamp and IP address. Implements duplicate prevention by checking both registration numbers and IP addresses.
- **Statistics Endpoint** (`/attendance_stats`): Provides class totals, present/absent counts, and list of present students.
- **Student List** (`/students`): Returns complete student list with attendance status (present/absent) and student initials.
- **Search Functionality** (`/search_students/<query>`): Case-insensitive search by name or registration number.

**Data Files Used**:
- Reads from: `user_data.csv` (class list)
- Writes to: `verified_ids.csv` (attendance records), `ip_tracking.csv` (IP tracking)

**Related Sections**: [API endpoints](#api-endpoints-server_regnosendpy), [Backend setup](#backend-flask-setup)

#### `server.py` (Minimal Flask Example)

**Location**: Root directory  
**Purpose**: Minimal Flask upload example server (not used by the main Flutter application flow).

**Note**: This file is a simple example and is not integrated into the main NetMark workflow. The main application uses `Server_regNoSend.py` instead.

**Related Sections**: [Backend setup](#backend-flask-setup)

### Flutter Application Files (`file_sender/`)

#### Core Application Files

##### `file_sender/lib/main.dart`

**Purpose**: Application entry point and main configuration.

**Key Responsibilities**:
- Initializes Firebase (with error handling for offline functionality)
- Sets up MaterialApp with routing configuration
- Defines theme and UI styling
- Configures navigation routes for all screens

**Routes Defined**:
- `/`: Login page
- `/role-selection`: Role selection screen
- `/signup-role-selection`: Signup role selection
- `/student-login`, `/faculty-login`: Authentication screens
- `/student-signup`, `/faculty-signup`: Registration screens
- `/faculty-dashboard`: Faculty dashboard
- `/attendance`: Attendance marking screen
- `/user`: User profile screen
- `/admin`: Student list screen
- `/upload`: CSV upload screen

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender), [Typical workflow](#typical-workflow)

##### `file_sender/lib/config.dart`

**Purpose**: Centralized server configuration.

**Key Features**:
- Defines default server URL (`http://10.2.8.97:5000`)
- Provides method to update server URL dynamically
- Ensures proper URL formatting (adds `http://` if missing)

**Usage**: Update `serverUrl` to point to your Flask backend server. This is referenced by all API calls throughout the Flutter app.

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender), [Backend setup](#backend-flask-setup)

#### Authentication & User Management Screens

##### `file_sender/lib/login_page.dart`

**Purpose**: Main login entry point for the application.

**Related Files**: `role_selection_screen.dart`, `student_login.dart`, `faculty_login.dart`

##### `file_sender/lib/role_selection_screen.dart`

**Purpose**: Allows users to select their role (Student or Faculty) before login.

**Related Files**: `student_login.dart`, `faculty_login.dart`

##### `file_sender/lib/student_login.dart` & `file_sender/lib/faculty_login.dart`

**Purpose**: Role-specific login screens that authenticate users via Firebase Authentication.

**Related Files**: `firebase_auth_service.dart`, `student_signup.dart`, `faculty_signup.dart`

##### `file_sender/lib/student_signup.dart` & `file_sender/lib/faculty_signup.dart`

**Purpose**: Registration screens for new student and faculty accounts.

**Related Files**: `signup_role_selection_screen.dart`, `firebase_auth_service.dart`

##### `file_sender/lib/signup_role_selection_screen.dart`

**Purpose**: Role selection screen for new user registration.

**Related Files**: `student_signup.dart`, `faculty_signup.dart`

#### Dashboard & Attendance Screens

##### `file_sender/lib/faculty_dashboard.dart`

**Purpose**: Main dashboard for faculty members showing attendance statistics and navigation options.

**Features**:
- Displays attendance statistics
- Provides access to student lists, CSV upload, and search functionality
- Links to class attendance overview

**Related Files**: `attendance_stats` API endpoint, `student_list_screen.dart`, `upload_csv_screen.dart`

##### `file_sender/lib/attendance_screen.dart`

**Purpose**: Screen for students to mark their attendance by entering registration number.

**Features**:
- Registration number input
- Face verification integration (optional)
- Attendance submission to backend

**Related Files**: `/mark_attendance` API endpoint, `face_verification_modal.dart`

##### `file_sender/lib/class_attendance_screen.dart`

**Purpose**: Displays class-wide attendance overview with present/absent status for all students.

**Related Files**: `/students` API endpoint, `student_list_screen.dart`

##### `file_sender/lib/student_list_screen.dart`

**Purpose**: Comprehensive student list view with filtering options (show present/absent students).

**Features**:
- Displays all students with attendance status
- Filter by present/absent
- Search functionality integration

**Related Files**: `/students` API endpoint, `/search_students/<query>` API endpoint

##### `file_sender/lib/upload_csv_screen.dart`

**Purpose**: Allows faculty/admins to upload class list CSV files to the backend.

**Features**:
- File picker integration
- CSV validation
- Upload progress indication

**Related Files**: `/upload_csv` API endpoint, [CSV format section](#csv-format-class-list)

##### `file_sender/lib/user_screen.dart`

**Purpose**: User profile and settings screen.

**Related Files**: Firebase Authentication services

#### Face Recognition & Biometric Features

##### `file_sender/lib/face_login_screen.dart`

**Purpose**: Face-based authentication screen for login.

**Related Files**: `face_auth_service.dart`, `tflite_interpreter.dart`

##### `file_sender/lib/face_scan_screen.dart`

**Purpose**: Screen for capturing and processing face images for registration or verification.

**Related Files**: `face_registration_service.dart`, `face_verification_modal.dart`, `camera` package

##### `file_sender/lib/face_verification_modal.dart`

**Purpose**: Modal dialog for face verification during attendance marking.

**Related Files**: `face_auth_service.dart`, `attendance_screen.dart`

#### Service Layer Files (`file_sender/lib/services/`)

##### `file_sender/lib/services/firebase_auth_service.dart`

**Purpose**: Firebase Authentication service wrapper for user authentication operations.

**Features**:
- User login/logout
- User registration
- Session management

**Related Files**: `firebase_options.dart`, Firebase Authentication package

##### `file_sender/lib/services/firestore_service.dart`

**Purpose**: Firestore database service for cloud data storage and synchronization.

**Features**:
- Attendance data sync to cloud
- Student data management
- Offline data persistence

**Related Files**: `firestore.rules`, `firestore_setup.js`, Cloud Firestore package

##### `file_sender/lib/services/face_auth_service.dart`

**Purpose**: Face authentication service for biometric verification.

**Features**:
- Face recognition for login
- Face matching and verification
- Integration with TensorFlow Lite models

**Related Files**: `tflite_interpreter.dart`, `face_database_service.dart`, `assets/models/output_model.tflite`

##### `file_sender/lib/services/face_registration_service.dart`

**Purpose**: Service for registering new face biometrics for users.

**Related Files**: `face_database_service.dart`, `face_scan_screen.dart`

##### `file_sender/lib/services/face_database_service.dart`

**Purpose**: Local database service for storing and retrieving face embeddings.

**Related Files**: `face_auth_service.dart`, `face_registration_service.dart`

##### `file_sender/lib/services/tflite_interpreter.dart`

**Purpose**: Main TensorFlow Lite interpreter interface for running ML models.

**Related Files**: `tflite_interpreter_base.dart`, `tflite_interpreter_io.dart`, `tflite_interpreter_web.dart`

##### `file_sender/lib/services/tflite_interpreter_base.dart`

**Purpose**: Base class for TensorFlow Lite interpreter implementations.

**Related Files**: `tflite_interpreter_io.dart`, `tflite_interpreter_web.dart`

##### `file_sender/lib/services/tflite_interpreter_io.dart`

**Purpose**: Platform-specific TensorFlow Lite interpreter for mobile platforms (iOS/Android).

**Related Files**: `tflite_interpreter_base.dart`, `tflite_flutter` package

##### `file_sender/lib/services/tflite_interpreter_web.dart`

**Purpose**: Web-specific TensorFlow Lite interpreter implementation.

**Related Files**: `tflite_interpreter_base.dart`, TensorFlow.js integration

##### `file_sender/lib/services/yolo_service.dart`

**Purpose**: YOLO (You Only Look Once) object detection service for face detection.

**Features**:
- Real-time face detection
- Bounding box generation
- Integration with camera feed

**Related Files**: Camera package, image processing libraries

#### Configuration & Assets

##### `file_sender/pubspec.yaml`

**Purpose**: Flutter project configuration and dependency management.

**Key Dependencies**:
- `flutter`: SDK 3.6+
- `http`: API communication
- `file_picker`: CSV file selection
- `image_picker`: Image capture
- `tflite_flutter`: TensorFlow Lite integration
- `firebase_core`, `firebase_auth`, `cloud_firestore`: Firebase services
- `camera`: Camera access for face scanning
- `permission_handler`: Device permissions

**Related Sections**: [Prerequisites](#prerequisites), [Flutter app setup](#flutter-app-setup-file_sender)

##### `file_sender/lib/firebase_options.dart`

**Purpose**: Auto-generated Firebase configuration for all platforms.

**Note**: This file is generated by FlutterFire CLI. Do not edit manually.

**Related Files**: `firebase.json`, Firebase project configuration

##### `file_sender/assets/models/output_model.tflite`

**Purpose**: Pre-trained TensorFlow Lite model for face recognition.

**Note**: This is the optimized MobileFaceNet model used for face verification. See `assets/models/MobileFaceNet_Optimized.py` for model architecture reference.

**Related Files**: `tflite_interpreter.dart`, `face_auth_service.dart`

##### `file_sender/assets/models/MobileFaceNet_Optimized.py`

**Purpose**: Python reference implementation of the MobileFaceNet model architecture.

**Note**: This file is for reference only and is not executed in the Flutter app.

##### `file_sender/assets/icons/checkin.svg`

**Purpose**: SVG icon asset for check-in/attendance marking UI elements.

#### Firebase Configuration Files

##### `file_sender/firebase.json`

**Purpose**: Firebase project configuration for hosting and deployment.

**Related Files**: `firestore.rules`, `firestore_setup.js`

##### `file_sender/firestore.rules`

**Purpose**: Firestore security rules for database access control.

**Related Files**: `firestore_service.dart`, Firebase Console

##### `file_sender/firestore_setup.js`

**Purpose**: JavaScript script for initializing Firestore database structure.

**Related Files**: `FIRESTORE_SETUP.md`

##### `file_sender/FIRESTORE_SETUP.md`

**Purpose**: Documentation for setting up Firestore database.

**Related Files**: `firestore_setup.js`, [Data, persistence, and cloud sync](#data-persistence-and-cloud-sync)

#### Platform-Specific Files

##### `file_sender/android/`

**Purpose**: Android platform-specific configuration and native code.

**Key Files**:
- `android/app/build.gradle`: Android build configuration
- `android/app/src/main/AndroidManifest.xml`: Android app manifest
- Native code for TensorFlow Lite and camera integration

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender)

##### `file_sender/ios/`

**Purpose**: iOS platform-specific configuration and native code.

**Key Files**:
- `ios/Runner.xcodeproj`: Xcode project configuration
- `ios/Runner/Info.plist`: iOS app configuration
- Native code for TensorFlow Lite and camera integration

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender)

##### `file_sender/web/`

**Purpose**: Web platform-specific files for Flutter web deployment.

**Key Files**:
- `web/index.html`: Web app entry point
- `web/manifest.json`: Web app manifest
- `web/icons/`: Web app icons

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender)

##### `file_sender/windows/`, `file_sender/linux/`, `file_sender/macos/`

**Purpose**: Desktop platform-specific configurations for Windows, Linux, and macOS.

**Related Sections**: [Flutter app setup](#flutter-app-setup-file_sender)

### Runtime Data Files

#### `user_data.csv`

**Location**: Root directory  
**Purpose**: Stores the uploaded class list CSV file.

**Format**: Must contain `Registration Number` and `Name` columns (see [CSV format section](#csv-format-class-list))

**Generated By**: `/upload_csv` API endpoint in `Server_regNoSend.py`

**Used By**: All student lookup and attendance verification operations

**Related Sections**: [CSV format](#csv-format-class-list), [Data, persistence, and cloud sync](#data-persistence-and-cloud-sync)

#### `verified_ids.csv`

**Location**: Root directory  
**Purpose**: Stores attendance records with timestamps and IP addresses.

**Format**: Columns: `Registration Number`, `Timestamp`, `IP`

**Generated By**: `/upload_unique_id/<unique_id>` and `/mark_attendance` API endpoints

**Used By**: Attendance statistics, student list with attendance status, duplicate prevention

**Cloud Sync**: Automatically syncs to cloud server when network connectivity is available

**Related Sections**: [Data, persistence, and cloud sync](#data-persistence-and-cloud-sync), [API endpoints](#api-endpoints-server_regnosendpy)

#### `ip_tracking.csv`

**Location**: Root directory  
**Purpose**: Tracks IP addresses to prevent duplicate attendance submissions from the same device.

**Format**: Columns: `IP`, `Timestamp`

**Generated By**: `/upload_unique_id/<unique_id>` API endpoint

**Used By**: Duplicate prevention mechanism in attendance marking

**Related Sections**: [Duplicate prevention](#features), [Security notes](#security-notes-important)

### Configuration Files

#### `.vscode/settings.json`

**Location**: `.vscode/` directory  
**Purpose**: VS Code workspace settings for the project.

**Configuration**:
- CMake source directory for Linux builds
- Java build configuration updates

**Note**: This file is optional and only affects VS Code editor behavior.

---

## Reproducibility Guide

This section provides step-by-step instructions to reproduce the entire NetMark attendance system from scratch, ensuring consistent results across different environments.

### System Requirements

- **Operating System**: Windows 10/11, macOS, or Linux
- **Python**: 3.11.9 (exact version recommended for consistency)
- **Flutter**: 3.24+ with Dart SDK 3.6+
- **Node.js**: 18+ (for Firebase CLI tools, optional)
- **Git**: For cloning the repository

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd FAST_Attendance
```

### Step 2: Backend Setup (Flask Server)

#### 2.1 Create Python Virtual Environment

**Windows (PowerShell)**:
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

**macOS/Linux**:
```bash
python3 -m venv .venv
source .venv/bin/activate
```

#### 2.2 Install Python Dependencies

```bash
pip install flask==2.3.0 pandas==2.0.3
```

**Note**: Pin versions for reproducibility:
- `flask==2.3.0`
- `pandas==2.0.3`

#### 2.3 Verify Backend Setup

```bash
python Server_regNoSend.py
```

The server should start on `http://0.0.0.0:5000`. You should see Flask debug output.

**Test the server**:
```bash
curl http://127.0.0.1:5000/attendance_stats
```

Expected response: `{"error": "Required files not found"}` (normal if no CSV uploaded yet)

### Step 3: Flutter Application Setup

#### 3.1 Verify Flutter Installation

```bash
flutter doctor
```

Ensure all required components are installed (Android SDK, Xcode for iOS, etc.)

#### 3.2 Navigate to Flutter Project

```bash
cd file_sender
```

#### 3.3 Install Flutter Dependencies

```bash
flutter pub get
```

This installs all dependencies specified in `pubspec.yaml`:
- `http: ^1.1.0`
- `file_picker: ^10.2.1`
- `image_picker: ^1.0.7`
- `tflite_flutter: ^0.11.0`
- `firebase_core: ^3.12.0`
- `cloud_firestore: ^5.4.0`
- `firebase_auth: ^5.5.0`
- `camera: ^0.10.5+5`
- And other dependencies

#### 3.4 Configure Server URL

Edit `file_sender/lib/config.dart`:

```dart
static String serverUrl = 'http://YOUR_SERVER_IP:5000';
```

Replace `YOUR_SERVER_IP` with:
- `127.0.0.1` for local testing
- Your local network IP (e.g., `192.168.1.100`) for device testing
- Your public IP or domain for production

#### 3.5 Firebase Setup (Optional but Recommended)

**3.5.1 Install Firebase CLI**:
```bash
npm install -g firebase-tools
```

**3.5.2 Initialize Firebase**:
```bash
cd file_sender
firebase login
firebase init
```

**3.5.3 Configure Firebase in Flutter**:
```bash
flutter pub add firebase_core
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates `lib/firebase_options.dart` automatically.

**3.5.4 Set up Firestore**:
- Follow instructions in `file_sender/FIRESTORE_SETUP.md`
- Run `firestore_setup.js` if provided
- Configure `firestore.rules` for security

### Step 4: Prepare Test Data

#### 4.1 Create Sample Class List CSV

Create `test_class_list.csv` in the root directory:

```csv
Registration Number,Name
20K-0001,Ayesha Khan
20K-0002,Ali Raza
20K-0003,Sara Ahmed
20K-0004,Muhammad Hassan
20K-0005,Fatima Ali
```

**Note**: Ensure headers match exactly: `Registration Number` and `Name` (case-sensitive)

### Step 5: Run the Complete System

#### 5.1 Start Backend Server

In the root directory:
```bash
python Server_regNoSend.py
```

Server should be running on `http://0.0.0.0:5000`

#### 5.2 Upload Class List

**Option A: Using curl**:
```bash
curl -X POST -F "file=@test_class_list.csv" http://127.0.0.1:5000/upload_csv
```

**Option B: Using Flutter app**:
- Run the Flutter app
- Navigate to Upload CSV screen (faculty login required)
- Select and upload `test_class_list.csv`

#### 5.3 Run Flutter Application

**Android**:
```bash
cd file_sender
flutter run -d android
```

**iOS** (macOS only):
```bash
flutter run -d ios
```

**Web**:
```bash
flutter run -d chrome
```

**Windows**:
```bash
flutter run -d windows
```

### Step 6: Verify System Functionality

#### 6.1 Test Backend APIs

**Test student lookup**:
```bash
curl http://127.0.0.1:5000/get_user/20K-0001
```

Expected: `{"Registration Number": "20K-0001", "Name": "Ayesha Khan"}`

**Test attendance marking**:
```bash
curl -X POST http://127.0.0.1:5000/upload_unique_id/20K-0001
```

Expected: `{"message": "Attendance marked successfully", "status": "success"}`

**Test attendance stats**:
```bash
curl http://127.0.0.1:5000/attendance_stats
```

Expected: Statistics with total, present, absent counts

**Test student list**:
```bash
curl http://127.0.0.1:5000/students
```

Expected: Complete student list with attendance status

**Test search**:
```bash
curl http://127.0.0.1:5000/search_students/Ayesha
```

Expected: Filtered student list matching the query

#### 6.2 Test Flutter App

1. **Login/Registration**: Test student and faculty authentication
2. **CSV Upload**: Upload class list via faculty dashboard
3. **Attendance Marking**: Mark attendance as a student
4. **View Statistics**: Check attendance stats in faculty dashboard
5. **Search**: Test student search functionality

### Step 7: Verify Data Persistence

#### 7.1 Check Generated CSV Files

After running the system, verify these files exist in the root directory:

- `user_data.csv`: Should contain uploaded class list
- `verified_ids.csv`: Should contain attendance records (after marking attendance)
- `ip_tracking.csv`: Should contain IP tracking data

#### 7.2 Test Offline Functionality

1. Stop the Flask server
2. Try marking attendance in Flutter app (should handle gracefully)
3. Restart Flask server
4. Verify data syncs correctly

### Step 8: Environment-Specific Configuration

#### 8.1 Network Configuration

**For Local Testing**:
- Backend URL: `http://127.0.0.1:5000`
- Ensure Flutter app and server are on the same machine

**For Device Testing**:
- Find your computer's local IP: `ipconfig` (Windows) or `ifconfig` (macOS/Linux)
- Update `file_sender/lib/config.dart` with your local IP
- Ensure device and computer are on the same network
- Update Flask server to allow connections from your network

**For Production**:
- Use HTTPS with TLS certificates
- Configure reverse proxy (nginx/Apache)
- Set up proper firewall rules
- Use environment variables for sensitive configuration

#### 8.2 Port Configuration

If port 5000 is busy, modify `Server_regNoSend.py`:

```python
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=YOUR_PORT, debug=True)
```

Update `file_sender/lib/config.dart` accordingly.

### Step 9: Troubleshooting Common Issues

#### 9.1 Python/Flask Issues

**Issue**: `ModuleNotFoundError: No module named 'flask'`  
**Solution**: Ensure virtual environment is activated and dependencies are installed

**Issue**: `Address already in use`  
**Solution**: Change port in `Server_regNoSend.py` or kill process using port 5000

**Issue**: `CSV not uploaded yet`  
**Solution**: Upload CSV file first using `/upload_csv` endpoint

#### 9.2 Flutter Issues

**Issue**: `flutter: command not found`  
**Solution**: Add Flutter to PATH or use full path to Flutter binary

**Issue**: `Failed to get dependencies`  
**Solution**: Run `flutter pub get` in `file_sender/` directory

**Issue**: `Unable to connect to server`  
**Solution**: 
- Verify server is running
- Check server URL in `config.dart`
- Ensure firewall allows connections
- For Android emulator, use `10.0.2.2` instead of `127.0.0.1`

#### 9.3 Firebase Issues

**Issue**: `Firebase not initialized`  
**Solution**: 
- Run `flutterfire configure`
- Ensure `firebase_options.dart` exists
- Check Firebase project configuration

**Issue**: `Permission denied` (Firestore)  
**Solution**: Configure `firestore.rules` properly in Firebase Console

### Step 10: Reset and Clean State

To reset the system to a clean state:

```bash
# Stop the Flask server (Ctrl+C)

# Delete runtime-generated files
rm user_data.csv verified_ids.csv ip_tracking.csv

# Restart server
python Server_regNoSend.py

# Re-upload class list
curl -X POST -F "file=@test_class_list.csv" http://127.0.0.1:5000/upload_csv
```

**Note**: If using cloud sync, also reset Firestore data in Firebase Console.

### Reproducibility Checklist

- [ ] Python 3.11.9 installed and verified
- [ ] Virtual environment created and activated
- [ ] Flask and pandas installed with pinned versions
- [ ] Flask server starts successfully on port 5000
- [ ] Flutter 3.24+ installed and `flutter doctor` passes
- [ ] Flutter dependencies installed (`flutter pub get`)
- [ ] Server URL configured in `config.dart`
- [ ] Firebase configured (if using cloud features)
- [ ] Sample CSV file created with correct format
- [ ] Class list uploaded successfully
- [ ] Backend APIs respond correctly
- [ ] Flutter app runs on target platform
- [ ] Attendance marking works end-to-end
- [ ] Data persistence verified (CSV files generated)
- [ ] Search and statistics features functional

### Version Information for Reproducibility

**Backend**:
- Python: 3.11.9
- Flask: 2.3.0
- pandas: 2.0.3

**Frontend**:
- Flutter: 3.24+
- Dart SDK: 3.6+
- See `file_sender/pubspec.yaml` for complete dependency list

**Platform Support**:
- Android: API level 21+
- iOS: 12.0+
- Web: Modern browsers (Chrome, Firefox, Safari, Edge)
- Windows: Windows 10+
- Linux: Ubuntu 18.04+
- macOS: 10.14+

---

## Features

- **CSV upload (admin or faculty)**: upload the official class list.
- **Student lookup**: fetch student details by Registration Number.
- **Attendance marking**: write an attendance entry with timestamp and IP.
- **Offline support with cloud sync**: 
  - CSV files serve as local backup for offline operation
  - When network connectivity is restored, data automatically syncs to the cloud server
  - Ensures no attendance records are lost during network interruptions
- **Duplicate prevention**:
  - blocks duplicate Registration Number
  - blocks repeated submissions from the same IP
- **Class overview**: totals, present/absent counts, present student list.
- **Search**: case-insensitive search by name or registration number.

---

## Prerequisites

- **Python**: 3.11.9
- **Flutter**: 3.24+ (Dart SDK 3.6+) — see `file_sender/pubspec.yaml`

---

## Backend (Flask) setup

### 1) Create and activate a virtual environment

Windows (PowerShell):

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### 2) Install dependencies

```bash
pip install flask pandas
```

### 3) Run the server

```bash
python Server_regNoSend.py
```

By default it runs on `0.0.0.0:5000`.

---

## CSV format (class list)

The uploaded CSV must include at least these headers (spelling must match exactly):

- `Registration Number`
- `Name`

Example:

```csv
Registration Number,Name
20K-0001,Ayesha Khan
20K-0002,Ali Raza
```

---

## API endpoints (`Server_regNoSend.py`)

### `POST /upload_csv`

Upload the class list CSV.

- **Request**: `multipart/form-data`
  - field name: `file` (CSV)
- **Response**: `{ "message": "CSV uploaded successfully" }`

Example:

```bash
curl -X POST -F "file=@user_data.csv" http://127.0.0.1:5000/upload_csv
```

### `GET /get_user/<unique_id>`

Lookup a student by Registration Number.

- **Success**: `{ "Registration Number": "...", "Name": "..." }`
- **If already marked** (implementation-dependent): `{ "warning": "Attendance already marked" }`

Example:

```bash
curl http://127.0.0.1:5000/get_user/20K-0001
```

### `POST /upload_unique_id/<unique_id>`

Mark attendance for the given Registration Number (server also records timestamp + IP).

Example:

```bash
curl -X POST http://127.0.0.1:5000/upload_unique_id/20K-0001
```

### `POST /mark_attendance`

Mark attendance using JSON body.

- **Request JSON**: `{ "registrationNumber": "20K-0001" }`
- The backend validates that the registration number exists in the uploaded class CSV.

Example:

```bash
curl -X POST ^
  -H "Content-Type: application/json" ^
  -d "{\"registrationNumber\":\"20K-0001\"}" ^
  http://127.0.0.1:5000/mark_attendance
```

### `GET /attendance_stats`

Get class totals.

- **Response**: `{ total, present, absent, PresentStudents: [...] }`

Example:

```bash
curl http://127.0.0.1:5000/attendance_stats
```

### `GET /students`

Get the full student list with present/absent info.

- **Response**:
  - `students`: `[ { name, registrationNumber, isPresent, initial } ]`
  - `present_students`: `[...]`

Example:

```bash
curl http://127.0.0.1:5000/students
```

### `GET /search_students/<query>`

Search students by `Name` or `Registration Number` (case-insensitive).

Example:

```bash
curl http://127.0.0.1:5000/search_students/20K
```

---

## Flutter app setup (`file_sender/`)

### 1) Install Flutter and verify toolchain

Make sure `flutter doctor` is green.

### 2) Fetch dependencies

```bash
cd file_sender
flutter pub get
```

### 3) Configure backend base URL

Update the server base URL inside the app as needed (check files under `file_sender/lib/`).

### 4) Run the app

- Android: `flutter run -d android`
- iOS (macOS only): `flutter run -d ios`
- Web: `flutter run -d chrome`
- Desktop (if enabled): `flutter run -d windows` / `linux` / `macos`

---

## Typical workflow

1. Start the Flask server: `python Server_regNoSend.py`
2. Admin uploads the class CSV to `POST /upload_csv`
3. Students enter their Registration Number in the Flutter app
4. Backend verifies the ID and records attendance (timestamp + IP; duplicates blocked)
5. Faculty/admin views stats and student lists (present/absent + search)

---

## Data, persistence, and cloud sync

- **Primary storage**: Cloud server (data syncs automatically when network is available).
- **Local backup**: CSV files on the server machine serve as offline backup. When network connectivity is restored, all locally stored attendance records automatically sync to the cloud server.
- **To "reset" attendance**:
  - stop the server
  - delete `verified_ids.csv` and `ip_tracking.csv` (local backup files)
  - restart and upload the class list again if needed
  - Note: If cloud sync is enabled, ensure cloud data is also reset as needed

---

## Security notes (important)

- **IP-based duplicate prevention is basic** and can fail on shared networks (labs, hostels, campuses). For real deployments, consider authentication (accounts, device binding, or QR-based session tokens).
- Do not expose this server publicly without **TLS** and an **auth layer** (reverse proxy with access control).
- Uploaded class lists may contain personal data; handle backups and access accordingly.

---

## Privacy and GDPR Compliance

This system collects **biometric data** for attendance verification purposes. As such, it is designed to comply with **GDPR (General Data Protection Regulation)** requirements:

- **Biometric data collection**: The system captures biometric information (e.g., facial recognition) for student identification and attendance marking.
- **GDPR compliance**: 
  - Users must provide **explicit consent** before biometric data is collected
  - Biometric data is processed securely and stored with appropriate encryption
  - Users have the right to **access, rectify, or delete** their biometric data
  - Data retention policies must be clearly defined and communicated
  - Biometric data is only used for the stated purpose (attendance verification) and not shared with third parties without consent
- **Data protection**: All biometric data is encrypted both in transit (via TLS) and at rest (encrypted storage)
- **Right to erasure**: Users can request deletion of their biometric data, which will be processed in accordance with GDPR Article 17
- **Data minimization**: Only necessary biometric data required for attendance verification is collected and stored

**Important**: Before deploying this system, ensure you have:
- Obtained proper consent from all users
- Implemented a privacy policy that clearly explains biometric data collection and usage
- Established data retention and deletion procedures
- Configured appropriate security measures for biometric data storage and transmission

---

## Troubleshooting

- **"Invalid CSV format"**: Ensure headers are exactly `Registration Number` and `Name`.
- **"CSV not uploaded yet" / empty student lookup**: Upload a CSV before calling lookup/mark endpoints.
- **CORS issues (Flutter Web)**: Serve the web app from the same origin or add CORS handling in Flask.
- **Port conflicts**: Change the port in `Server_regNoSend.py` if `5000` is busy.

---

## License

This project is for educational use. Add a license file if you plan to distribute it.
