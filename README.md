# Sports App 🏀⚽🏆

A Swift-based iOS app using MVP architecture to display sports data like leagues, teams, fixtures, and more. Built using Core Data, Alamofire, and modern best practices.

---

## 🚀 Getting Started

### ✅ Prerequisites

* Xcode 15+
* iOS 15.0+
* Swift 5.7+
* CocoaPods (or Swift Package Manager, based on your setup)
* Internet connection for API fetching

### 🛆 Dependencies

* [Alamofire](https://github.com/Alamofire/Alamofire)
* Core Data (Built-in)
* SDWebImage
* Lottie

### 🛠️ Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/shereenmohamed923/Sports-App.git
   ```

2. Open the `.xcworkspace` file (if using CocoaPods) or `.xcodeproj` (if SPM).

3. Install dependencies:

   * **CocoaPods**

     ```bash
     pod install
     ```
   * **SPM**: Open Xcode → File → Add Packages → Search and add.

4. Run the project on a simulator or device.

---

## 🧑‍💻 Team Responsibilities

### 👩‍💻 [Shereen Mohamed](https://github.com/shereenmohamed923)

* ✅ **Core Data Integration**: Model setup for saving favorites and offline storage.
* ✅ **Favourite Screen**: Display saved favorite leagues.
* ✅ **League Table Screen**: Show leagues.
* ✅ **Team Details Screen**: Info about team players and coach.
* ✅ **Splash Screen**: App logo animation and transition to home.
* ✅ **Fetching Fixtures and Teams**: Pull upcoming games and team info from the API.

---

### 👨‍💻 [Hazem](https://github.com/Hazem-web)

* ✅ **Unit Testing**: Write test cases for Network.
* ✅ **League Details Screen**: Show upcoming matches, latest matches, teams.
* ✅ **Home Screen**: Main dashboard with sport categories.
* ✅ **Handle No Internet**: Show alerts when there is no internet.
* ✅ **Factory Implementation**: Abstract and centralize creation of factory design pattern.
* ✅ **Network Service Implementation**: Handle API communication and error handling.
* ✅ **Fetching Leagues and Players**: Pull all leagues and player data from the API.

---

## 📱 API Info

* Base URL: `https://apiv2.allsportsapi.com/`
* All endpoints are managed through a centralized `NetworkService` class that conforms to the `Fetchable` protocol.

---

## 🧪 Running Tests

* Open the project in Xcode.
* Select **Product > Test** or press `Cmd + U`.

---

## 🙌 Contributing

Want to help? Submit pull requests with clear titles, and link to an assigned GitHub issue if applicable.
