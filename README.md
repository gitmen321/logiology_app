# 🌍 Logiology App

## 📊 Overview
Logiology is a sleek and modern **Flutter-based Android application** that offers a smooth product browsing experience. Designed with a clean **dark theme**, the app connects to a remote API (dummyjson.com) to display categorized and filterable product listings. With engaging UI elements, intuitive filtering, and branded visuals, Logiology provides a seamless and stylish shopping-like interface.

---

## 🌟 Features

### 📅 Product Listing
- Paginated product list with **title**, **price**, **category**, and **tags**
- Data fetched from: [https://dummyjson.com/products](https://dummyjson.com/products)

### ⛅️ Filters
- **Category**: e.g., smartphones, laptops
- **Tags**: e.g., new, sale, popular
- **Price Range**: Adjustable slider for price-based filtering

### 🔄 Load More
- Fetch additional products via a FloatingActionButton

### 🔢 Custom Loader
- Animated `SpinKitPianoWave` with centered message: *"Explore our products"*

### 🎨 UI & Branding
- Dark theme throughout
- White-text filter dialogs
- App icon: `logiology_icon.png`
- Logo: `logiology_logo.png`
- Branded app name: **"Logiology"**

---

## 📱 APK Installation

### 🔗 [Download APK](https://drive.google.com/drive/folders/1MPbzX_ptzh-2oiYvVZ4KvPlBGpMZf5IN?usp=sharing)
- File: `app-release.apk`
- Path: `build/app/outputs/flutter-apk/app-release.apk`

### 📦 Installation Steps
1. Download the APK from the above link
2. On your Android device, enable:
   - **Settings > Apps > Special App Access > Install Unknown Apps**
   - Allow your **browser** or **file manager** to install APKs
3. Locate the APK (usually in Downloads)
4. Tap and install it
5. Open **Logiology** from your home screen

---

## 🌐 Testing Instructions

### 👁️ App Icon & Name
- Verify app displays **Logiology** icon and name

### 🔍 Product Listing
- Browse the paginated product list

### 🔧 Filters
1. Tap the **Filter** icon
2. Choose:
   - Category (e.g., smartphones)
   - Tags (e.g., sale, new)
   - Price Range (slider)
3. Apply and confirm product list updates

### ➕ Load More
- Tap the **Floating Action Button** to load more products

### ⏳ Loader
- Ensure `SpinKitPianoWave` loader appears during loads

### 🚪 Internet Required
- App requires a working connection to fetch product data

---

## 🔑 Login (If Applicable)
- **Username:** admin  
- **Password:** Pass@123 *(Changeable via profile section)*

---

## 📚 Developer Setup

### 📆 Requirements
- Flutter: >= 3.0.0
- Android SDK & Emulator
- IDE: VS Code / Android Studio
- Java JDK (for keystore)

### 🔧 Installation
```bash
git clone [repository-url]
cd logiology_app
flutter pub get
```

### 📷 Verify Assets
- assets/logo/logiology_logo.png
- assets/icons/logiology_icon.png

### 🎨 Generate App Icon (If Needed)
```bash
flutter pub run flutter_launcher_icons:main
```

### 🚀 Run the App
```bash
flutter run
```

---

## 📦 Build Release APK

### 🔒 Create Keystore (If Missing)
```bash
keytool -genkey -v -keystore android/app/logiology.jks -keyalg RSA -keysize 2048 -validity 10000 -alias logiology
```
- Password: `logiology123`

### 📂 Setup Signing
**android/key.properties**
```properties
storePassword=logiology123
keyPassword=logiology123
keyAlias=logiology
storeFile=../../android/app/logiology.jks
```

### 📊 Build APK
```bash
flutter clean
flutter build apk --release
```
- Output: `build/app/outputs/flutter-apk/app-release.apk`

---

## 🔍 Project Structure
```
logiology_app/
├── android/
├── assets/
│   ├── logo/
│   │   └── logiology_logo.png
│   ├── icons/
│   │   └── logiology_icon.png
├── lib/
│   ├── core/
│   ├── features/
│   ├── main.dart
├── pubspec.yaml
├── build/
```

---

## ℹ️ Notes
- This project is intended for **evaluation purposes only**
- Login credentials provided above if required
- For issues, contact: [Your Name/Email]

---

## 🚀 License
This project is shared solely for the **Logiology machine test** (April 2025) and is **not licensed** for public use or distribution.

