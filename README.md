# 📱 Food Analysis iOS App

## 🧠 Overview
A sophisticated iOS application that leverages advanced image recognition and nutritional analysis to help users make informed dietary choices. The app allows users to capture images of food items and receive detailed nutritional information, making it easier to track and maintain a healthy diet.

## ✨ Features
- 📸 **Smart Food Recognition**
  - Capture food using camera
  - Auto-analyze using OpenAI Vision
- 🔍 **Detailed Nutritional Analysis**
  - Calories, protein, carbs, fats
- 📊 **Visual Data Trends**
  - Daily/weekly charts of intake
- 🛠️ **Customizable Goals**
  - Set personal macro and calorie goals
- 📱 **Modern UI**
  - Built with SwiftUI and MVVM architecture

## 🧰 Technical Stack
- **Framework**: SwiftUI
- **Architecture**: MVVM + `@Observable`
- **AI Integration**: OpenAI GPT-4 Vision API
- **Data Storage**: SwiftData (iOS 18.4+)
- **Charts**: Swift Charts framework
- **Camera**: AVFoundation
- **Development Workflow**:
  - [Cursor](https://www.cursor.sh) – AI-enhanced code editor
  - [SweetPad](https://sweetpad.hyzyla.dev/) – used to run the iOS app directly on an iPhone from Cursor
- **Tools**: Xcode 16.3, SF Symbols

## 📋 Requirements
- iOS 18.4 or later
- Swift 6+
- Xcode 16.3+
- [Cursor](https://www.cursor.sh)
- [SweetPad](https://sweetpad.hyzyla.dev/) (for deploying and testing from Cursor to real iPhone)

## 🧪 Installation
```bash
git clone https://github.com/pratyushpratiksinha/iOSApp-VibeCodingTest.git
cd iOSApp-VibeCodingTest
open iOSApp-VibeCodingTest.xcodeproj
```

> Build and run the project

> ⚠️ **Note:**  
> This is a **camera-based application** and requires a **real iOS device** to run.  
> The iOS Simulator does not support camera input.  
> Make sure your device is connected and selected before building and running the app in Xcode.

## 🚀 Usage
1. Launch the app
2. Set your nutritional goals in **Settings**
3. Tap the ➕ button in home tab to open the camera
4. Capture your food
5. Review, edit, and save the nutritional analysis
6. Monitor trends in the **Analysis** tab

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

## 🤝 Contributing
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments
- SwiftUI for the modern UI implementation
- All contributors and supporters of the project

## 📬 Contact
Have questions or feedback? Reach out to the developer:  
[pratyushpratiksinha@gmail.com](mailto:pratyushpratiksinha@gmail.com)
