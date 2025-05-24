
# 📱 iOS App Development Guide

## 🔍 Project Overview
This iOS app helps users **analyze food items through image capture** and receive **detailed nutritional insights** using AI-based image recognition. The goal is to promote healthy dietary choices with a delightful user experience.

## 🗂 Project Layout
```
iOSApp-VibeCodingTest/
├── App/
│   └── iOSApp_VibeCodingTestApp.swift         # App entry point (SwiftUI lifecycle)
│
├── Features/
│   ├── Login/
│   │   ├── LoginView.swift                     # UI for user login/onboarding
│   │   └── LoginViewModel.swift                # Handles login state and logic
│
│   ├── MainTab/
│   │   └── MainTabView.swift                   # TabView containing Home, Analysis, Settings
│
│   ├── Home/
│   │   ├── HomeView.swift                      # Dashboard showing today's summary and entries
│   │   └── HomeViewModel.swift                 # Computes daily macros and calories
│
│   ├── Settings/
│   │   ├── View/
│   │   │   ├── GoalSettingsView.swift          # Goal configuration UI
│   │   │   └── SettingsView.swift              # Main settings screen
│   │   └── ViewModel/
│   │       ├── GoalSettingsViewModel.swift     # Handles saving/editing nutrition goals
│   │       └── SettingsViewModel.swift         # Manages settings data
│
│   ├── Camera/
│   │   ├── View/
│   │   │   ├── CameraCaptureView.swift         # AVFoundation live camera preview
│   │   │   ├── CameraProcessingView.swift      # Post-capture image editing UI
│   │   │   └── CameraView.swift                # Manages camera lifecycle and flow
│   │   └── ViewModel/
│   │       ├── CameraProcessingViewModel.swift# Handles editable values after analysis
│   │       └── CameraViewModel.swift           # Tracks camera + vision states
│   │   └── Service/
│   │       └── CameraService.swift             # Async service calling OpenAI Vision API
│
│   ├── Analysis/
│   │   ├── Model/
│   │   │   └── MacroEntry.swift                # Simple model for macro chart entries
│   │   ├── View/
│   │   │   ├── AnalysisView.swift              # Full history and trend analysis
│   │   │   ├── DailyTrendChart.swift           # Chart of calories per day
│   │   │   └── MacroBarChart.swift             # Visual distribution of macros
│   │   └── ViewModel/
│   │       └── AnalysisViewModel.swift         # Groups items and computes chart data
│
├── Models/
│   ├── FoodItem.swift                          # SwiftData model for food log
│   ├── UserSettings.swift                      # SwiftData model for user macros goal
│   └── VisionAPIResponse.swift                 # Decodable struct for OpenAI API result
│
├── Shared/
│   ├── Components/
│   │   ├── CalorieSummaryCard.swift            # Widget showing calories progress
│   │   ├── CircularProgressBar.swift           # Ring progress used in macro views
│   │   ├── FloatingActionButton.swift          # FAB for launching camera
│   │   ├── FoodCard.swift                      # Compact display of a food item
│   │   ├── FoodEditView.swift                  # Editing UI for saved entries
│   │   ├── MacroCard.swift                     # Individual macro card
│   │   └── MacrosSummaryView.swift             # Groups all macro cards
│   ├── Constants/
│   │   └── AppStorageKeys.swift                # Keys for persistent settings storage
│   └── Extensions/
│       ├── Binding+Extension.swift             # Utility for optional or onChange binding
│       ├── Date+Extension.swift                # Helpers like isToday, startOfDay, etc.
│       ├── DateFormatter+Extension.swift       # Reusable static formatters
│       └── UIImage+Extension.swift             # Image compression and processing
│
├── Resources/
│   └── Assets/                                 # All asset catalogs (AppIcon, images, etc.)
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
