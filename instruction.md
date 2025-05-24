
# 📱 iOS App Development Guide

## 🔍 Project Overview
This iOS app helps users **analyze food items through image capture** and receive **detailed nutritional insights** using AI-based image recognition. The goal is to promote healthy dietary choices with a delightful user experience.

## 🗂 Project Structure
```
iOSApp-VibeCodingTest/
├── App/                 # App configuration and entry point
├── Features/            # Main app features
│   ├── Home/            # Dashboard and daily summary
│   ├── Camera/          # Camera integration and image analysis
│   ├── Analysis/        # Trends, charts, and history
│   ├── MainTab/         # Tab bar controller
│   ├── Settings/        # Goal management and app preferences
│   └── Login/           # User onboarding and authentication
├── Models/              # SwiftData and response models
├── Shared/              # Reusable views, styles, and utilities
└── Resources/           # Assets and localized strings
```

## 🧱 Development Guidelines

### 🧩 Architecture
- ✅ Follow **MVVM** pattern (`@Observable` for state)
- ✅ Use **SwiftUI** and **SwiftData** (iOS 18.4+)
- ✅ Apply **clean architecture**: views, view models, models, services

### 🎨 Code Style
- Follow Apple's **Swift API Design Guidelines**
- Use **descriptive names** for clarity
- Add comments for non-obvious logic
- Prefer **smaller, reusable views and functions**
- Use **`enum Constants`** for static strings and values
- Emphasize **compile-time safety** with strong typing

### 📷 Camera Module
- Request **NSCameraUsageDescription** in `Info.plist`
- Use **AVFoundation** to capture images
- Handle permissions and errors gracefully
- Compress images before sending to API
- Support real-device only (not supported on Simulator)

### 📊 Analysis Module
- Send images to **OpenAI Vision API** (`gpt-4-vision-preview`)
- Parse JSON response into `VisionAPIResponse`
- Provide editable fields (calories, macros)
- Allow saving analyzed data to SwiftData

### 👤 Authentication Module
- Basic login support
- Save user preferences locally using `SwiftData`
- Future-ready for iCloud sync or backend integration

## 🚀 Performance Best Practices
- Use `@MainActor` and `Task.detached` appropriately
- Compress and debounce image uploads
- Avoid blocking UI with long operations
- Optimize SwiftUI rendering (e.g., LazyVStack)

## 🔐 Security
- Use `HTTPS` for all external requests

## 🛠 Required Dependencies
- `SwiftUI` (UI layer)
- `AVFoundation` (camera)
- `SwiftData` (local persistence)
- `Charts` (visual analytics)
- `OpenAI` GPT-4 Vision API
- `Cursor.dev` (AI-based development environment)
- `SweetPad` (for running app on iOS device from Cursor)

## 🧪 Build & Run Instructions
```bash
git clone https://github.com/pratyushpratiksinha/iOSApp-VibeCodingTest.git
cd iOSApp-VibeCodingTest
open iOSApp-VibeCodingTest.xcodeproj
```

> Build and run the project.

> ⚠️ **Note:**  
> This is a **camera-based application** and requires a **real iOS device** to run.  
> The **iOS Simulator does not support camera input**.  
> Ensure your device is connected and selected in Xcode before building.


## 🤝 Contributing
1. Fork this repo  
2. Create a branch (`git checkout -b feature/FixCameraBug`)  
3. Commit changes (`git commit -m "fix: resolved crash when camera is denied"`)  
4. Push and open a Pull Request  

## 📬 Support
If you have any questions, ideas, or bugs to report:
> **Email:** [pratyushpratiksinha@gmail.com](mailto:pratyushpratiksinha@gmail.com)
