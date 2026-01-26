<div align="center">

# 📊 NetMark - Automated Instant Network Attendance

**A modern, cross-platform attendance management system with offline support and cloud synchronization**

[![Python](https://img.shields.io/badge/Python-3.11.9-blue.svg)](https://www.python.org/)
[![Flutter](https://img.shields.io/badge/Flutter-3.24+-02569B.svg?logo=flutter)](https://flutter.dev/)
[![Flask](https://img.shields.io/badge/Flask-2.3.0-black.svg?logo=flask)](https://flask.palletsprojects.com/)
[![License](https://img.shields.io/badge/License-Educational-green.svg)](LICENSE)

</div>

---

## 📑 Table of Contents

- [Overview](#-overview)
- [🚀 Quick Links](#-quick-links)
- [✨ Features](#-features)
- [📁 Repository Layout](#-repository-layout)
- [📚 Project Files Documentation](#-project-files-documentation)
- [🔢 Algorithms Used](#-algorithms-used)
- [🚀 Quick Start](#-quick-start)
- [⚙️ Setup & Installation](#️-setup--installation)
- [📖 API Documentation](#-api-documentation)
- [📊 Statistical Analysis Demo](#-statistical-analysis-demo)
- [🧪 Testing & Stress Testing](#-testing--stress-testing)
- [🔄 Reproducibility Guide](#-reproducibility-guide)
- [🔒 Security & Privacy](#-security--privacy)
- [🐛 Troubleshooting](#-troubleshooting)
- [📄 License](#-license)

---

## 🎯 Overview

NetMark is a comprehensive attendance management system designed for educational institutions, featuring:

- 📱 **Cross-platform Flutter client** for students, faculty, and administrators
- 🐍 **Python Flask backend** with RESTful API
- ☁️ **Cloud synchronization** with offline support
- 🔐 **Duplicate prevention** mechanisms
- 🔍 **Advanced search** and filtering capabilities

### 💡 Key Highlights

- ✅ **Offline-first design**: CSV files serve as local backup for offline operation
- ✅ **Automatic cloud sync**: Data syncs automatically when network connectivity is restored
- ✅ **Zero data loss**: Ensures no attendance records are lost during network interruptions
- ✅ **Multi-platform support**: Android, iOS, Web, Windows, Linux, macOS

> **⚠️ Important Note**: This repository **does not include any ML dataset** and **does not perform training**. The only data used is the class list CSV uploaded at runtime. Flutter dependen[...] 

---

## 🚀 Quick Links

### 📚 Documentation
- [📖 API Documentation](#-api-documentation) - Complete API reference
- [📊 Statistical Analysis Demo](#-statistical-analysis-demo) - Performance metrics and statistical validation
- [🧪 Testing & Stress Testing](#-testing--stress-testing) - Load testing and scalability analysis
- [🔄 Reproducibility Guide](#-reproducibility-guide) - Step-by-step setup instructions
- [⚙️ Setup & Installation](#️-setup--installation) - Quick setup guide

### 🎯 Key Features
- [✨ Features Overview](#-features) - All system capabilities
- [📊 Statistics Dashboard](#-statistical-analysis-demo) - View performance metrics
- [🔍 Search & Filter](#-api-documentation) - Student search functionality
- [📝 Face Verification Logging](#-face-verification-logging) - Performance tracking

### 🛠️ Development
- [📁 Repository Layout](#-repository-layout) - Project structure
- [📚 Project Files Documentation](#-project-files-documentation) - File descriptions
- [🔢 Algorithms Used](#-algorithms-used) - Core algorithms and pseudocode
- [🧪 Testing & Stress Testing](#-testing--stress-testing) - Load testing and scalability analysis
- [🐛 Troubleshooting](#-troubleshooting) - Common issues and solutions

### 📊 Data Files
- [📄 Runtime Data Files](#-runtime-data-files) - CSV file formats and usage
- [📝 logs.csv](#-logscsv) - Face verification performance logs
- [✅ verified_ids.csv](#-verified_idscsv) - Attendance records
- [📁 stress_test_logs/](#-stress-test-logs-directory) - Stress testing execution logs

### 🧪 Testing & Code
- [🧪 Testing & Stress Testing](#-testing--stress-testing) - Complete testing documentation
- [📁 stress_test_logs/](#-stress-test-logs-directory) - Test execution logs directory
- [🔧 Testing Scripts](#-testing-scripts) - load_test.py, find_breaking_point.py
- [🚨 Breaking Point Analysis](#-breaking-point-analysis) - System limits and failure points

---

## ✨ Features

### Core Functionality

| Feature | Description |
|---------|-------------|
| 📤 **CSV Upload** | Admin/faculty can upload official class lists |
| 🔍 **Student Lookup** | Fetch student details by Registration Number |
| ✅ **Attendance Marking** | Record attendance with timestamp and IP tracking |
| 📊 **Statistics Dashboard** | View totals, present/absent counts, and student lists |
| 🔎 **Advanced Search** | Case-insensitive search by name or registration number |

### Advanced Features

- 🔄 **Offline Support with Cloud Sync**
  - CSV files serve as local backup for offline operation
  - Automatic synchronization when network connectivity is restored
  - Zero data loss guarantee during network interruptions

- 🛡️ **Duplicate Prevention**
  - Blocks duplicate Registration Number submissions
  - Prevents repeated submissions from the same IP address
  - Multi-layer validation system

- 📱 **Cross-Platform Support**
  - Native mobile apps (Android/iOS)
  - Web application
  - Desktop applications (Windows/Linux/macOS)

- 📊 **Statistical Analysis & Performance Metrics**
  - Face verification timing tracking (logs.csv)
  - Statistical validation with confidence intervals (95% CI)
  - Baseline comparisons (industry-standard 90% accuracy baseline)
  - Statistical significance testing (z-tests with p-values)
  - Performance metrics dashboard with comprehensive analytics
  - False Acceptance Rate (FAR) and False Rejection Rate (FRR) tracking

---

## 📁 Repository Layout

```
FAST_Attendance/
├── 📂 file_sender/              # Flutter application
│   ├── 📂 lib/                  # Dart source code
│   │   ├── 📂 services/         # Service layer (Firebase, Face Auth, etc.)
│   │   └── *.dart               # UI screens and components
│   ├── 📂 assets/               # Images, models, icons
│   └── 📂 android/ios/web/      # Platform-specific code
│
├── 🐍 [Server_regNoSend.py](https://github.com/Sujith8257/NetMark/blob/main/Server_regNoSend.py)       # Main Flask server
├── 🐍 [server.py](https://github.com/Sujith8257/NetMark/blob/main/server.py)                 # Minimal Flask example (not used)
│
├── 🧪 Testing Scripts
│   ├── [load_test.py](https://github.com/Sujith8257/NetMark/blob/main/load_test.py)             # Load testing script
│   ├── [find_breaking_point.py](https://github.com/Sujith8257/NetMark/blob/main/find_breaking_point.py)   # Breaking point analysis script
│   ├── [run_stress_tests.ps1](https://github.com/Sujith8257/NetMark/blob/main/run_stress_tests.ps1)     # Automated test suite (Windows)
│   └── [run_stress_tests.sh](https://github.com/Sujith8257/NetMark/blob/main/run_stress_tests.sh)      # Automated test suite (Linux/macOS)
│
└── 📄 Runtime-generated files (local backup/offline storage)
    ├── user_data.csv            # Uploaded class list
    ├── verified_ids.csv         # Attendance records
    ├── ip_tracking.csv          # IP tracking for duplicate prevention
    ├── logs.csv                 # Face verification performance logs
    ├── scalability_metrics.csv # Server-side scalability metrics
    ├── breaking_point_results.json # Breaking point test results
    └── 📁 stress_test_logs/     # Stress testing execution logs
        └── load_test_*users_*.log # Timestamped test logs
```

### 📋 Runtime-Generated Files

These CSV files are created at runtime as **local backups** for offline operation:

| File | Purpose | Format |
|------|---------|--------|
| `user_data.csv` | Latest uploaded class list (backed up locally) | `Registration Number`, `Name`, `Slot 4`, `Section`, `FA` |
| `verified_ids.csv` | Attendance records (present students + timestamps) | `Registration Number`, `Timestamp`, `IP` |
| `ip_tracking.csv` | IP tracking for duplicate prevention | `IP`, `Timestamp` |
| `logs.csv` | Face verification performance logs | `Registration Number`, `Timestamp`, `Face Verification Time (Seconds)` |
| `scalability_metrics.csv` | Server-side scalability metrics (accumulated) | `Timestamp`, `Endpoint`, `Concurrent Users`, `Response Times`, `Throughput`, etc. |
| `breaking_point_results.json` | Breaking point test results | JSON with test configuration and results for each load level |
| `stress_test_logs/` | Directory containing all test execution logs | `load_test_{users}users_{timestamp}.log` files |

> 💡 **Note**: When network connectivity is available, data automatically syncs to the cloud server.

---

## 📚 Project Files Documentation

This section provides a comprehensive explanation of all files in the project structure, their purposes, and how they interact with each other.

### 🔧 Backend Files

#### [`Server_regNoSend.py`](https://github.com/Sujith8257/NetMark/blob/main/Server_regNoSend.py) (Main Flask Server)

**📍 Location**: Root directory  
**🎯 Purpose**: Main Flask backend server that handles all attendance-related operations.

**🔑 Key Features**:
- **📤 CSV Upload Handler** (`/upload_csv`): Accepts class list CSV files from admins/faculty
- **🔍 Student Lookup** (`/get_user/<unique_id>`): Verifies student registration numbers
- **✅ Attendance Marking** (`/upload_unique_id/<unique_id>` and `/mark_attendance`): Records attendance with duplicate prevention
- **📊 Statistics Endpoint** (`/attendance_stats`): Provides class totals and present/absent counts
- **📋 Student List** (`/students`): Returns complete student list with attendance status
- **🔎 Search Functionality** (`/search_students/<query>`): Case-insensitive search
- **📝 Face Verification Logging** (`/log_face_verification`): Records face verification cycle times for performance analysis

**📂 Data Files Used**:
- Reads from: `user_data.csv` (class list)
- Writes to: `verified_ids.csv` (attendance records), `ip_tracking.csv` (IP tracking), `logs.csv` (face verification logs)

**🔗 Related Sections**: [API endpoints](#-api-documentation), [Backend setup](#-backend-flask-setup)

#### [`server.py`](https://github.com/Sujith8257/NetMark/blob/main/server.py) (Minimal Flask Example)

**📍 Location**: Root directory  
**🎯 Purpose**: Minimal Flask upload example server (not used by the main Flutter application flow).

> ⚠️ **Note**: This file is a simple example and is not integrated into the main NetMark workflow.

---

### 📱 Flutter Application Files (`file_sender/`)

#### 🎯 Core Application Files

##### [`file_sender/lib/main.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/main.dart)

**🎯 Purpose**: Application entry point and main configuration.

**🔑 Key Responsibilities**:
- Initializes Firebase (with error handling for offline functionality)
- Sets up MaterialApp with routing configuration
- Defines theme and UI styling
- Configures navigation routes for all screens

**🛣️ Routes Defined**:
- `/` → Login page
- `/role-selection` → Role selection screen
- `/student-login`, `/faculty-login` → Authentication screens
- `/faculty-dashboard` → Faculty dashboard
- `/attendance` → Attendance marking screen
- `/upload` → CSV upload screen
- And more...

**🔗 Related Sections**: [Flutter app setup](#-flutter-app-setup), [Typical workflow](#-typical-workflow)

##### [`file_sender/lib/config.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/config.dart)

**🎯 Purpose**: Centralized server configuration.

**🔑 Key Features**:
- Defines default server URL (`http://10.2.8.97:5000`)
- Provides method to update server URL dynamically
- Ensures proper URL formatting (adds `http://` if missing)

> 💡 **Usage**: Update `serverUrl` to point to your Flask backend server.

---

#### 🔐 Authentication & User Management Screens

| File | Purpose |
|------|---------|
| [`login_page.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/login_page.dart) | Main login entry point |
| [`role_selection_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/role_selection_screen.dart) | Role selection (Student/Faculty) |
| [`student_login.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/student_login.dart) & [`faculty_login.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/faculty_login.dart) | Role-specific authentication |
| [`student_signup.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/student_signup.dart) & [`faculty_signup.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/faculty_signup.dart) | User registration |
| [`signup_role_selection_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/signup_role_selection_screen.dart) | Role selection for registration |

---

#### 📊 Dashboard & Attendance Screens

| File | Purpose | Key Features |
|------|---------|--------------|
| [`faculty_dashboard.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/faculty_dashboard.dart) | Faculty dashboard | Statistics, navigation, quick access |
| [`attendance_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/attendance_screen.dart) | Attendance marking | Registration input, face verification |
| [`class_attendance_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/class_attendance_screen.dart) | Class overview | Present/absent status for all students |
| [`student_list_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/student_list_screen.dart) | Student list | Filtering, search integration |
| [`upload_csv_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/upload_csv_screen.dart) | CSV upload | File picker, validation, progress |
| [`statistics_dashboard.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/statistics_dashboard.dart) | Statistical analysis | Performance metrics, baseline comparisons, significance testing |
| [`metrics_debug_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/metrics_debug_screen.dart) | Metrics viewer | Raw metrics data, export capabilities |

---

#### 👤 Face Recognition & Biometric Features

| File | Purpose |
|------|---------|
| [`face_login_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/face_login_screen.dart) | Face-based authentication |
| [`face_scan_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/face_scan_screen.dart) | Face image capture and processing |
| [`face_verification_modal.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/face_verification_modal.dart) | Face verification during attendance |

---

#### 🔧 Service Layer Files (`file_sender/lib/services/`)

| Service | Purpose |
|---------|---------|
| [`firebase_auth_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/firebase_auth_service.dart) | Firebase Authentication wrapper |
| [`firestore_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/firestore_service.dart) | Cloud data storage and synchronization |
| [`face_auth_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/face_auth_service.dart) | Biometric face verification |
| [`face_registration_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/face_registration_service.dart) | Face biometric registration |
| [`face_database_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/face_database_service.dart) | Local face embeddings storage |
| [`tflite_interpreter.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/tflite_interpreter.dart) | TensorFlow Lite model interface |
| [`yolo_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/yolo_service.dart) | Real-time face detection |
| [`performance_metrics_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/performance_metrics_service.dart) | Performance metrics collection, statistical analysis, baseline comparisons |
| [`real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart) | Face recognition with embedding extraction and verification |

---

#### ⚙️ Configuration & Assets

| File/Directory | Purpose |
|----------------|---------|
| [`pubspec.yaml`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/pubspec.yaml) | Flutter project configuration and dependencies |
| [`firebase_options.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/firebase_options.dart) | Auto-generated Firebase configuration |
| `assets/models/output_model.tflite` | Pre-trained face recognition model |
| `assets/icons/checkin.svg` | UI icon assets |

---

### 📄 Runtime Data Files

#### `user_data.csv`

**📍 Location**: Root directory  
**🎯 Purpose**: Stores the uploaded class list CSV file.

**📋 Format**: Must contain `Registration Number` and `Name` columns

**🔗 Generated By**: `/upload_csv` API endpoint  
**🔗 Used By**: All student lookup and attendance verification operations

---

#### `verified_ids.csv`

**📍 Location**: Root directory  
**🎯 Purpose**: Stores attendance records with timestamps and IP addresses.

**📋 Format**: `Registration Number`, `Timestamp`, `IP`

**Example**:
```csv
Registration Number,Timestamp,IP
99220041389,2025-10-23 12:41:19.187760,10.10.31.222
```

**🔗 Generated By**: `/upload_unique_id/<unique_id>` and `/mark_attendance` endpoints  
**☁️ Cloud Sync**: Automatically syncs when network is available

---

#### `ip_tracking.csv`

**📍 Location**: Root directory  
**🎯 Purpose**: Tracks IP addresses to prevent duplicate submissions.

**📋 Format**: `IP`, `Timestamp`

**🔗 Generated By**: `/upload_unique_id/<unique_id>` endpoint  
**🔗 Used By**: Duplicate prevention mechanism

---

#### `logs.csv`

**📍 Location**: Root directory  
**🎯 Purpose**: Stores face verification performance metrics for statistical analysis.

**📋 Format**: `Registration Number`, `Timestamp`, `Face Verification Time (Seconds)`

**Example**:
```csv
Registration Number,Timestamp,Face Verification Time (Seconds)
99220041389,2026-01-26T15:22:54.920423,0.747
99220041253,2026-01-26T15:23:52.555702,0.712
```

**🔗 Generated By**: `/log_face_verification` endpoint (called automatically during face verification)  
**🔗 Used By**: Statistical analysis dashboard, performance metrics service

**📊 Purpose**: 
- Tracks face verification cycle times (from button click to verification result)
- Enables statistical validation of performance claims
- Supports baseline comparisons and significance testing

---

## 🔢 Algorithms Used

This section documents the core algorithms implemented in NetMark, including subnet validation, face authentication sign-up, and face authentication login/attendance marking processes.

### Algorithm 1: Subnet Validation

**Purpose**: Validates that client requests originate from an authorized network subnet.

**Input**: `clientIP`, `serverIP`, `allowedSubnetRange`  
**Output**: `isAuthorized` (boolean)

**Pseudocode**:
```
Algorithm 1: Pseudo code of Subnet Validation
Input: clientIP, serverIP, allowedSubnetRange
Output: isAuthorized
1  if clientIP is not in allowedSubnetRange then
2      return false
3  return true
```

**Implementation Details**:
- Validates client IP address against configured subnet ranges
- Prevents unauthorized access from external networks
- Used for network-based access control

**Code Location**: 
- Backend validation in [`Server_regNoSend.py`](https://github.com/Sujith8257/NetMark/blob/main/Server_regNoSend.py)
- IP tracking in `ip_tracking.csv` for duplicate prevention

---

### Algorithm 2: Face Authentication - Sign-Up Process

**Purpose**: Registers a new user by capturing their face, generating embeddings, and securely storing them.

**Input**: `UserImage`, `User Unique ID`, `DeviceMAC`  
**Output**: `StoredEmbedding` (success) or `Failure`

**Pseudocode**:
```
Algorithm 2: Pseudo code for Face Authentication: Sign-Up Process
Input: UserImage, User Unique ID, DeviceMAC
Output: StoredEmbedding
1  Step 1: Face Capture
2      Capture facial image from device camera.
3  Step 2: Face Detection
4      DetectedFace ← MediaPipeFaceDetection(UserImage)
5      if DetectedFace is None then
6          Display "No face detected, retry"
7          return Failure
8  Step 3: Embedding Generation
9      Embedding ← MobileFaceNet(DetectedFace)
10 Step 4: Secure Local Storage
11     Encrypt(Embedding)
12     Store Embedding, UserID, DeviceMAC in EncryptedSharedPreferences
13     return Success
```

**Implementation Details**:
- **Face Capture**: Uses device camera to capture user's facial image
- **Face Detection**: MediaPipe or similar face detection to locate face in image
- **Embedding Generation**: MobileFaceNet model generates 128-dimensional face embedding
- **Secure Storage**: Embeddings encrypted and stored locally with user ID and device MAC address
- **Offline Support**: Data stored in SharedPreferences for offline access

**Code Location**: 
- [`file_sender/lib/services/real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart) - Face recognition service
- [`file_sender/lib/services/firestore_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/firestore_service.dart) - Cloud storage (optional)
- [`file_sender/lib/screens/signup_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/screens/signup_screen.dart) - Sign-up UI flow

**Key Features**:
- ✅ Encrypted local storage
- ✅ Device binding (MAC address)
- ✅ Offline-first design
- ✅ Error handling for face detection failures

---

### Algorithm 3: Face Authentication - Login / Attendance Marking

**Purpose**: Verifies user identity by comparing live camera feed with stored face embeddings.

**Input**: `LiveCameraFrame`, `StoredEmbedding`  
**Output**: `isVerified` (boolean)

**Pseudocode**:
```
Algorithm 3: Pseudo code for Face Authentication: Login / Attendance Marking
Input: LiveCameraFrame, StoredEmbedding
Output: isVerified
1  Face ← DetectFace(LiveCameraFrame);
2  if Face is None then
3      return false;
4  LiveEmbedding ← GenerateEmbedding(Face);
5  Score ← CosineSimilarity(LiveEmbedding, StoredEmbedding);
6  if Score is less than Threshold then
7      return false;
8  return true
```

**Implementation Details**:
- **Face Detection**: Detects face in live camera frame
- **Embedding Generation**: Generates embedding from detected face using MobileFaceNet
- **Similarity Calculation**: Computes cosine similarity between live and stored embeddings
- **Threshold Comparison**: Verifies if similarity score exceeds threshold (typically 0.70)
- **Verification Result**: Returns true if face matches, false otherwise

**Code Location**: 
- [`file_sender/lib/services/real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart) - Face verification logic
- [`file_sender/lib/widgets/face_verification_camera.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/widgets/face_verification_camera.dart) - Camera interface
- [`file_sender/lib/face_verification_modal.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/face_verification_modal.dart) - Verification modal UI
- [`file_sender/lib/services/performance_metrics_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/performance_metrics_service.dart) - Performance tracking

**Key Features**:
- ✅ Real-time face detection from camera
- ✅ Cosine similarity for matching
- ✅ Configurable threshold (default: 0.70)
- ✅ Performance metrics tracking
- ✅ Automatic logging to `logs.csv`

**Performance Metrics**:
- Verification time tracked for each cycle
- Logged to `logs.csv` for statistical analysis
- Average verification time: < 1 second (validated)

---

### Algorithm Implementation Summary

| Algorithm | Purpose | Key Components | Code Files |
|-----------|---------|----------------|------------|
| **Algorithm 1** | Subnet Validation | IP validation, network access control | [`Server_regNoSend.py`](https://github.com/Sujith8257/NetMark/blob/main/Server_regNoSend.py) |
| **Algorithm 2** | Face Sign-Up | Face detection, embedding generation, secure storage | [`file_sender/lib/services/real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart), [`signup_screen.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/screens/signup_screen.dart) |
| **Algorithm 3** | Face Login/Attendance | Live detection, similarity matching, verification | [`file_sender/lib/services/real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart), [`file_sender/lib/face_verification_modal.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/face_verification_modal.dart) |

### 📊 Code Availability

All algorithms are fully implemented and available in the codebase:

- **Face Recognition**: [`file_sender/lib/services/real_face_recognition_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/real_face_recognition_service.dart)
- **Offline-First Storage**: [`file_sender/lib/services/firestore_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/firestore_service.dart)
- **Statistical Analysis**: [`file_sender/lib/services/performance_metrics_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/performance_metrics_service.dart)
- **Face Detection**: [`file_sender/lib/services/yolo_service.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/services/yolo_service.dart) or MediaPipe integration
- **Embedding Generation**: `assets/models/output_model.tflite`

### 📊 Algorithm Performance

**Face Authentication Performance** (from `logs.csv`):
- **Average Verification Time**: ~0.75 seconds
- **Range**: 0.69s - 0.99s
- **Success Rate**: > 94% (with 95% CI)
- **Threshold**: 0.70 (cosine similarity)

**Statistical Validation**:
- All performance metrics include 95% confidence intervals
- Compared to industry baselines (90% typical accuracy)
- Statistically validated with z-tests (p < 0.05)

---

## 🚀 Quick Start

### Prerequisites

- **Python**: 3.11.9
- **Flutter**: 3.24+ (Dart SDK 3.6+)
- **Git**: For cloning the repository

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd FAST_Attendance
   ```

2. **Set up backend** (see [Backend Setup](#-backend-flask-setup))

3. **Set up Flutter app** (see [Flutter Setup](#-flutter-app-setup))

4. **Run the system** (see [Typical Workflow](#-typical-workflow))

---

## ⚙️ Setup & Installation

### 🔧 Backend (Flask) Setup

#### Step 1: Create Virtual Environment

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

#### Step 2: Install Dependencies

```bash
pip install flask pandas
```

#### Step 3: Run the Server

```bash
python Server_regNoSend.py
```

> ✅ Server runs on `http://0.0.0.0:5000` by default

---

### 📱 Flutter App Setup

#### Step 1: Verify Flutter Installation

```bash
flutter doctor
```

Ensure all required components are installed.

#### Step 2: Install Dependencies

```bash
cd file_sender
flutter pub get
```

#### Step 3: Configure Server URL

Edit [`file_sender/lib/config.dart`](https://github.com/Sujith8257/NetMark/blob/main/file_sender/lib/config.dart):

```dart
static String serverUrl = 'http://YOUR_SERVER_IP:5000';
```

#### Step 4: Run the App

```bash
# Android
flutter run -d android

# iOS (macOS only)
flutter run -d ios

# Web
flutter run -d chrome

# Desktop
flutter run -d windows  # or linux, macos
```

---

### 📋 CSV Format (Class List)

The uploaded CSV must include these headers (spelling must match exactly):

- `Registration Number` (required)
- `Name` (required)

Additional columns like `Slot 4`, `Section`, and `FA` are optional and will be preserved but not used for attendance operations.

**Example**:
```csv
Registration Number,Name
99220041246,MAKIREDDYGARI HARITHA
99220041253,MARELLA MARUTHI NAVADEEP
99220041389,TANGUTURI VENKATA SUJITH GOPI
```

---

## 📖 API Documentation

### Base URL
```
http://localhost:5000
```

### Endpoints

#### 📤 `POST /upload_csv`

Upload the class list CSV.

**Request**: `multipart/form-data`
- Field name: `file` (CSV file)

**Response**:
```json
{
  "message": "CSV uploaded successfully"
}
```

**Example**:
```bash
curl -X POST -F "file=@user_data.csv" http://127.0.0.1:5000/upload_csv
```

---

#### 🔍 `GET /get_user/<unique_id>`

Lookup a student by Registration Number.

**Response** (Success):
```json
{
  "Registration Number": "99220041389",
  "Name": "TANGUTURI VENKATA SUJITH GOPI"
}
```

**Response** (Already marked):
```json
{
  "Registration Number": "99220041389",
  "Name": "TANGUTURI VENKATA SUJITH GOPI",
  "warning": "Attendance already marked"
}
```

**Example**:
```bash
curl http://127.0.0.1:5000/get_user/99220041389
```

---

#### ✅ `POST /upload_unique_id/<unique_id>`

Mark attendance for the given Registration Number.

**Response**:
```json
{
  "message": "Attendance marked successfully",
  "status": "success"
}
```

**Example**:
```bash
curl -X POST http://127.0.0.1:5000/upload_unique_id/99220041389
```

---

#### ✅ `POST /mark_attendance`

Mark attendance using JSON body.

**Request**:
```json
{
  "registrationNumber": "99220041389"
}
```

**Response**:
```json
{
  "message": "Attendance marked successfully for 99220041389",
  "status": "success"
}
```

**Example**:
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"registrationNumber":"99220041389"}' \
  http://127.0.0.1:5000/mark_attendance
```

---

#### 📊 `GET /attendance_stats`

Get class attendance statistics.

**Response**:
```json
{
  "total": 74,
  "present": 1,
  "absent": 73,
  "PresentStudents": ["99220041389"]
}
```

**Example**:
```bash
curl http://127.0.0.1:5000/attendance_stats
```

---

#### 📋 `GET /students`

Get the full student list with attendance status.

**Response**:
```json
{
  "students": [
    {
      "name": "TANGUTURI VENKATA SUJITH GOPI",
      "registrationNumber": "99220041389",
      "isPresent": true,
      "initial": "T"
    },
    {
      "name": "MARELLA MARUTHI NAVADEEP",
      "registrationNumber": "99220041253",
      "isPresent": false,
      "initial": "M"
    },
    ...
  ],
  "present_students": ["99220041389"]
}
```

**Example**:
```bash
curl http://127.0.0.1:5000/students
```

---

#### 🔎 `GET /search_students/<query>`

Search students by name or registration number (case-insensitive).

**Response**:
```json
{
  "students": [
    {
      "name": "TANGUTURI VENKATA SUJITH GOPI",
      "registrationNumber": "99220041389",
      "isPresent": true,
      "initial": "T"
    },
    ...
  ]
}
```

**Example**:
```bash
curl http://127.0.0.1:5000/search_students/TANGUTURI
```

---

#### 📝 `POST /log_face_verification`

Log face verification cycle timing for performance analysis.

**Request**:
```json
{
  "registrationNumber": "99220041389",
  "timestamp": "2026-01-26T15:22:54.920423",
  "timeSeconds": 0.747
}
```

**Response**:
```json
{
  "message": "logged",
  "status": "success"
}
```

**Example**:
```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"registrationNumber":"99220041389","timestamp":"2026-01-26T15:22:54.920423","timeSeconds":0.747}' \
  http://127.0.0.1:5000/log_face_verification
```

**Note**: This endpoint is called automatically by the Flutter app during face verification. The timing represents the full cycle from "Verify Face" button click to verification result (match/no [...]