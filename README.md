# 📱 ScreenProtectorKit

`ScreenProtectorKit` is a lightweight Swift package that helps you protect sensitive information inside your iOS app.  
It blocks **screenshots**, **screen recordings**, and hides content in the **app switcher preview**.  

---

## ✨ Features
- 🔒 Prevent screenshots & screen recordings from exposing sensitive screens.  
- 📱 Protection scope:  
  - Entire App  
  - Single Screen  
  - Multiple Screens  
- 🎨 Overlay options:  
  - Black screen  
  - White screen  
  - Custom overlay (e.g., “Protected Content” label).  
- 🛡 Protect App Switcher previews when app goes background.  
- 🚀 Works with **iOS 13+** and Swift Package Manager.  

---

## 📦 Installation

### Swift Package Manager

1. In Xcode, go to **File → Add Packages…**  
2. Enter the repository URL:  

   ```text
   https://github.com/vishalvaghasiya-ios/ScreenProtectorKit.git

	3.	Select the latest version (e.g. 1.0.0).
	4.	Import it in your Swift files:

import ScreenProtectorKit



⸻

🚀 Usage

1. Protect Entire App

ScreenProtectorKit.shared.enableProtection(.fullApp, overlay: .black)


⸻

2. Protect a Single Screen

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    ScreenProtectorKit.shared.enableProtection(.singleScreen(self), overlay: .white)
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    ScreenProtectorKit.shared.disableProtection()
}


⸻

3. Protect Multiple Screens

let controllers = [profileVC, paymentVC]

let customOverlay = UILabel()
customOverlay.text = "🔒 Protected Content"
customOverlay.textAlignment = .center
customOverlay.font = .boldSystemFont(ofSize: 20)
customOverlay.backgroundColor = .black
customOverlay.textColor = .white

ScreenProtectorKit.shared.enableProtection(
    .multipleScreens(controllers),
    overlay: .custom(customOverlay)
)


⸻

4. Disable Protection

ScreenProtectorKit.shared.disableProtection()


⸻

5. Protect App Switcher Preview

func sceneWillResignActive(_ scene: UIScene) {
    ScreenProtectorKit.shared.enableProtection(.fullApp, overlay: .black)
}

func sceneDidBecomeActive(_ scene: UIScene) {
    ScreenProtectorKit.shared.disableProtection()
}


⸻

🏷 Versioning

This package follows Semantic Versioning:
	•	1.0.0 → Initial stable release

To create a new version:

git tag 1.0.0
git push origin 1.0.0


⸻

🛠 Requirements
	•	iOS 13.0+
	•	Swift 5.9+
	•	Xcode 15+

⸻

👨‍💻 Author

Maintained by Vishal Vaghasiya

⸻

📄 License

This project is licensed under the MIT License — feel free to use it in your projects.
