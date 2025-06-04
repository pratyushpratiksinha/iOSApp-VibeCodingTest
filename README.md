# 📱 Food Analysis iOS App

![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

<img src="https://github.com/user-attachments/assets/83203935-db45-49ff-a35a-c5ddfdf480a5" 
     alt="Rounded image" 
     style="width: 180px; height: 180px; border-radius: 15px;">
     
## 🧠 Overview
A sophisticated iOS application that leverages advanced image recognition and nutritional analysis to help users make informed dietary choices. The app allows users to capture images of food items and receive detailed nutritional information, making it easier to track and maintain a healthy diet.

## 🖼️ App Screenshots
### Login Screen
<img src="https://github.com/user-attachments/assets/47b5ee8f-77df-4532-92ca-8036b8c0c5f6" width="300"/>

### Home Screen
<img src="https://github.com/user-attachments/assets/b6ae69be-7c05-4da8-8c91-55ffa8371ea9" width="300"/>
<img src="https://github.com/user-attachments/assets/05b1c8ca-813f-40b6-b093-8ee93a1526da" width="300"/>
<img src="https://github.com/user-attachments/assets/9ada195b-0fc4-411e-ac56-e82d4fe79902" width="300"/>


### Camera Screen
<img src="https://github.com/user-attachments/assets/cd3ef300-c6b8-4170-bb45-4c8d0eed511b" width="300"/>
<img src="https://github.com/user-attachments/assets/39aea0bc-a997-4313-9382-47a002a2c03a" width="300"/>

### History Screen
<img src="https://github.com/user-attachments/assets/09b15a71-0b46-4d0e-a4f8-304bf52bf210" width="300"/>
<img src="https://github.com/user-attachments/assets/01210313-04f0-4561-bd68-28ed17fa462b" width="300"/>

### Analysis Screen
<img src="https://github.com/user-attachments/assets/ae93a746-fb9d-4403-bed5-de58661a15d3" width="300"/>
<img src="https://github.com/user-attachments/assets/80093578-d4e6-48e5-82bd-a54106b0e485" width="300"/>
<img src="https://github.com/user-attachments/assets/8a716978-cba7-4f2a-8a86-bc29e6a041e8" width="300"/>
<img src="https://github.com/user-attachments/assets/142f293a-71ac-43fb-b64d-5bc11a23e590" width="300"/>
<img src="https://github.com/user-attachments/assets/d322d17b-170f-412b-9acf-53207bb18b11" width="300"/>

### Settings Screen
<img src="https://github.com/user-attachments/assets/cddb6137-959f-432a-966a-0ffa89275e29" width="300"/>
<img src="https://github.com/user-attachments/assets/f8b475d6-54f5-4618-9c86-228d4eb1f7bb" width="300"/>
<img src="https://github.com/user-attachments/assets/64149886-c5dd-4b49-8423-da05fdede675" width="300"/>

## ✨ Features
- 📸 **Smart Food Recognition**
  - Capture food using camera
  - Auto-analyze using OpenAI GPT-4o
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
- **AI Integration**: OpenAI GPT-4o API
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
│   ├── History/        # History
│   ├── Analysis/        # Trends, charts
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

## 📬 Contact
Have questions or feedback? Reach out to the developer:  
[pratyushpratiksinha@gmail.com](mailto:pratyushpratiksinha@gmail.com)
