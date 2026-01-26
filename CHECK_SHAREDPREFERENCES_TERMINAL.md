# How to Check SharedPreferences Data via Terminal

## Package Name
Your app's package name is: **`com.example.file_sender`**

## Method 1: Using ADB (Android Debug Bridge)

### Prerequisites
1. Make sure your Android device/emulator is connected
2. Enable USB Debugging on your device
3. Have ADB installed (comes with Android SDK)

### Step 1: Check if device is connected
```bash
adb devices
```
You should see your device listed.

### Step 2: Access the device shell
```bash
adb shell
```

### Step 3: Navigate to SharedPreferences directory
```bash
cd /data/data/com.example.file_sender/shared_prefs/
```

### Step 4: List all SharedPreferences files
```bash
ls -la
```

You should see files like:
- `FlutterSharedPreferences.xml` (main file)
- Other XML files if any

### Step 5: View the contents
```bash
cat FlutterSharedPreferences.xml
```

Or to see it formatted:
```bash
cat FlutterSharedPreferences.xml | grep -v "^$"
```

### Step 6: Exit the shell
```bash
exit
```

---

## Method 2: Pull Files to Your Computer

### Pull the SharedPreferences file to your computer
```bash
adb pull /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml .
```

This will copy the file to your current directory. Then you can open it with any text editor.

### Pull all SharedPreferences files
```bash
adb pull /data/data/com.example.file_sender/shared_prefs/ .
```

---

## Method 3: One-Line Commands (No Shell)

### View SharedPreferences directly
```bash
adb shell cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml
```

### List all keys in SharedPreferences
```bash
adb shell cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml | grep -oP '(?<=name=")[^"]*'
```

### Search for specific key (e.g., "userRegNo")
```bash
adb shell cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml | grep "userRegNo"
```

---

## Method 4: Using ADB Shell with run-as (For Non-Rooted Devices)

If you get "Permission denied", use `run-as`:

```bash
adb shell run-as com.example.file_sender cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml
```

Or to list files:
```bash
adb shell run-as com.example.file_sender ls -la /data/data/com.example.file_sender/shared_prefs/
```

---

## Understanding the XML Format

SharedPreferences are stored as XML. Example structure:

```xml
<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
<map>
    <string name="userRegNo">12345</string>
    <string name="userName">John Doe</string>
    <string name="deviceId">abc123</string>
    <string name="faceEmbedding">0.123,0.456,0.789,...</string>
    <string name="performance_metrics">{"auth_times":[...],"success_count":5}</string>
</map>
```

---

## Quick Diagnostic Commands

### Check if SharedPreferences directory exists
```bash
adb shell run-as com.example.file_sender ls /data/data/com.example.file_sender/shared_prefs/
```

### Check file size (to see if it's empty)
```bash
adb shell run-as com.example.file_sender stat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml
```

### Count number of keys
```bash
adb shell run-as com.example.file_sender cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml | grep -c "name="
```

---

## Troubleshooting

### Issue: "Permission denied"
**Solution**: Use `run-as` command:
```bash
adb shell run-as com.example.file_sender cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml
```

### Issue: "No such file or directory"
**Possible reasons**:
1. App hasn't been installed/run yet
2. No data has been saved to SharedPreferences yet
3. App was uninstalled and reinstalled (data is cleared)

**Solution**: 
- Make sure the app is installed and has been run at least once
- Try registering a user first, then check again

### Issue: "device not found"
**Solution**:
1. Check USB connection
2. Enable USB Debugging in Developer Options
3. Run `adb devices` to verify connection

---

## Example: Complete Check Workflow

```bash
# 1. Check device connection
adb devices

# 2. Check if SharedPreferences file exists
adb shell run-as com.example.file_sender ls /data/data/com.example.file_sender/shared_prefs/

# 3. View the contents
adb shell run-as com.example.file_sender cat /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml

# 4. Pull to computer for easier viewing
adb pull /data/data/com.example.file_sender/shared_prefs/FlutterSharedPreferences.xml shared_prefs_backup.xml

# 5. Open the file on your computer
# (Windows) notepad shared_prefs_backup.xml
# (Mac/Linux) open shared_prefs_backup.xml
```

---

## Alternative: Use the In-App Viewer

You can also use the SharedPreferences Viewer we created in the app:
1. Go to Admin Dashboard
2. Click the Storage icon (or Debug Metrics Viewer)
3. Navigate to "SharedPreferences Inspector"

This shows all data in a user-friendly format without needing terminal access.
