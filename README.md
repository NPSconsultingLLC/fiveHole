# FiveHole 🏒

**A comprehensive goalie statistics tracking app for hockey goalies**

Track saves, goals against, save percentage, and visualize where goals are scored on the net. Built with SwiftUI for iOS 15+.

---

## 📱 Features

### Core Functionality
- **Live Game Tracking**: Track saves and goals in real-time during games
- **Goal Location Mapping**: Visual net diagram showing where goals were scored
  - 7-zone net visualization (Top L/R, Middle L/R, Bottom L/R, Five-Hole)
  - Interactive goal location selection
  - Metadata tracking (redirected shots, penalty shots, overtime goals)
- **Automatic Statistics**: Real-time save percentage and shot totals
- **Multiple Goalies**: Create and manage multiple goalie profiles
- **Game Review**: Review and save completed games

### Additional Features
- **CloudKit Sync**: Automatic data sync across devices (iCloud required)
- **In-App Purchases**: Support the app with optional purchases
  - Remove ads
  - Support tiers (Coffee, Beer, Burger, Premium)
  - StoreKit 2 implementation
- **Dark Mode**: Full support for light/dark appearance
- **Custom Design**: Neumorphic UI with gradient buttons

---

## 🛠️ Technology Stack

| Technology | Version | Purpose |
|-----------|---------|---------|
| **iOS** | 15.6+ | Minimum deployment target |
| **SwiftUI** | - | UI framework |
| **Core Data** | - | Local data persistence |
| **CloudKit** | - | iCloud sync |
| **Firebase** | 8.15.0 | Analytics, Crashlytics, Performance |
| **Google Mobile Ads** | 12.14.0 | Ad monetization |
| **StoreKit 2** | - | In-app purchases |
| **Swift Package Manager** | - | Dependency management |

---

## 📁 Project Structure

```
FiveHole/
├── FiveHole/
│   ├── FiveHoleApp.swift              # App entry point
│   ├── Info.plist                     # App configuration
│   │
│   ├── Controllers/
│   │   └── GameCalculator.swift       # Statistics calculations
│   │
│   ├── Components/
│   │   ├── AdBannerView.swift         # Google Mobile Ads banner
│   │   └── Buttons/
│   │       └── NeumorphicButton.swift # Custom button styles
│   │
│   ├── CoreData/
│   │   ├── Persistence.swift          # Core Data stack (async/await)
│   │   └── FiveHole.xcdatamodeld      # Data model
│   │       ├── Goalies (entity)
│   │       ├── Games (entity)
│   │       └── GoalsAgainst (entity)
│   │
│   ├── Views/
│   │   ├── Extensions/
│   │   │   └── ColorExtensions.swift  # Custom color palette
│   │   │
│   │   ├── GameInput/
│   │   │   ├── GameInputView.swift
│   │   │   ├── UserInputView.swift
│   │   │   ├── GoalLocationView.swift
│   │   │   ├── GoalieNetVisualization.swift
│   │   │   ├── GoalTypes.swift        # Goal data models
│   │   │   └── GoalieAddSelectPage.swift
│   │   │
│   │   ├── GameReview/
│   │   │   └── GameReviewView.swift
│   │   │
│   │   ├── Goalies/
│   │   │   ├── AddNewGoalieAlert.swift
│   │   │   └── GoaliePickerView.swift
│   │   │
│   │   ├── Settings/
│   │   │   ├── SettingsView.swift
│   │   │   ├── SettingsDetailView.swift
│   │   │   ├── RemoveAdsCollection.swift
│   │   │   ├── InAppPurchases/
│   │   │   │   └── StoreManager.swift # StoreKit 2 manager
│   │   │   ├── Credits/
│   │   │   │   └── CreditsView.swift
│   │   │   ├── ContactSupport/
│   │   │   │   └── EmailHelper.swift
│   │   │   └── EasterEggs/
│   │   │       └── FireworksParticleView.swift
│   │   │
│   │   └── TabContainer/
│   │       └── TabContainerView.swift # Main tab view
│   │
│   └── Assets.xcassets                # App icons & colors
│
├── FiveHoleTests/
└── FiveHoleUITests/
```

---

## 🚀 Getting Started

### Prerequisites
- **Xcode 14.0+**
- **iOS 15.6+** device or simulator
- **Apple Developer Account** (for Firebase & CloudKit setup)
- **CocoaPods removed** (project uses Swift Package Manager)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/NPSconsultingLLC/fiveHole.git
   cd fiveHole
   ```

2. **Open in Xcode**
   ```bash
   open FiveHole.xcodeproj
   ```
   ⚠️ **Important**: Open the `.xcodeproj` file, NOT a `.xcworkspace` file

3. **Install Dependencies**
   - Xcode will automatically resolve Swift Package Manager dependencies
   - Wait for Firebase and Google Mobile Ads to download

4. **Configure Firebase** (Optional - required for analytics)
   - Replace `GoogleService-Info.plist` with your own from [Firebase Console](https://console.firebase.google.com)
   - Or keep the existing file for testing

5. **Configure CloudKit**
   - Sign in with your Apple ID in Xcode preferences
   - Select your development team in project settings
   - CloudKit container: `iCloud.com.strykeout.goalieScout2`

6. **Build and Run**
   - Select a target device (iPhone 11+ recommended)
   - Press `Cmd + R` to build and run

---

## 🔑 Configuration

### Ad Unit IDs
Located in `AdBannerView.swift`:
```swift
// Test Ads (default for DEBUG builds)
static let testBanner = "ca-app-pub-3940256099942544/2934735716"

// Production Ads
static let productionBanner = "ca-app-pub-1998600979835274~9355435059"
```

### In-App Purchase Product IDs
Located in `StoreManager.swift`:
```swift
static let removeAds = "com.strykeout.goalieScout2.RemoveAds"
static let coffee = "com.stryekout.goalieScout2.Coffee"
static let beer = "com.strykeout.goalieScout2.Beer"
static let burger = "com.strykeout.goalieScout2.Burger"
static let premium = "com.strykeout.goalieScout2.wow"
```

### Bundle Identifier
```
com.stryekout.goalieScout2
```

---

## 📊 Core Data Schema

### Goalies Entity
```swift
- id: UUID
- fName: String
- lName: String
- tName: String (team name)
- selectedGoalie: Bool
- toGame: [Games] (relationship)
```

### Games Entity
```swift
- id: UUID
- gameDate: Date
- opponent: String
- saves: Int16
- totalShots: Int16
- goalsFor: Int16
- season: Int16
- isWin: Bool
- toGoalie: Goalies (relationship)
- toGoalsAgainst: [GoalsAgainst] (relationship)
```

### GoalsAgainst Entity
```swift
- location: String
- toGames: Games (relationship)
```

---

## 🎨 Custom Color Palette

The app uses a custom neumorphic color scheme defined in `ColorExtensions.swift`:

```swift
NPSBackgroundGradientStart  // Dark background
NPSBackgroundGradientEnd    // Light background
NPSTextColor                // Adaptive text
NPSButtonStart              // Button gradient start
NPSButtonEnd                // Button gradient end
NPSDarkStart/NPSDarkEnd     // Dark neumorphic shadows
NPSLightStart/NPSLightEnd   // Light neumorphic highlights
```

---

## 🧪 Testing

### Unit Tests
```bash
# Run all tests
Cmd + U

# Or specific test file
FiveHoleTests/FiveHoleTests.swift
```

**Current Test Coverage:**
- ✅ Save percentage calculation (100% accuracy)
- ✅ Total shots calculation
- ✅ Edge cases (shutouts, zero shots)

### UI Tests
```bash
FiveHoleUITests/FiveHoleUITests.swift
```
- Launch performance testing

---

## 🐛 Known Issues

1. **Photo Picker Not Saving Images**
   - Status: Incomplete implementation
   - Location: `AddNewGoalieAlert.swift`
   - TODO: Implement image selection and storage

2. **Game Saving Incomplete**
   - Status: UI present but saving logic not fully implemented
   - Location: `GameReviewView.swift`
   - Workaround: Data tracked in-memory during session

3. **CloudKit Sync Conflicts**
   - Status: Can occur with offline changes
   - Mitigation: Property-level merge policy enabled

---

## 🗺️ Roadmap

### Phase 1: Core Completion (Current)
- [x] Modern dependency management (SPM)
- [x] StoreKit 2 implementation
- [x] Goal location visualization
- [ ] Complete game saving functionality
- [ ] Photo picker implementation
- [ ] Game history view

### Phase 2: Enhanced Features
- [ ] Statistics dashboard
  - Career stats
  - Season comparisons
  - Trend graphs
- [ ] Data export (CSV/PDF)
- [ ] Share game results
- [ ] Custom goal location analytics

### Phase 3: Polish
- [ ] Onboarding flow
- [ ] Widget support (iOS 16+)
- [ ] Apple Watch companion app
- [ ] iPad optimization

---

## 🔒 Privacy & Permissions

### Required Permissions
```xml
<!-- Info.plist -->
NSCameraUsageDescription        - Take goalie profile photos
NSPhotoLibraryUsageDescription  - Select photos from library
NSUserTrackingUsageDescription  - Personalized ads (ATT required)
```

### Data Collection
- **iCloud**: Syncs game and goalie data (user-controlled)
- **Firebase Analytics**: Anonymous usage statistics
- **Google Ads**: IDFA for ad personalization (with consent)

---

## 📄 License

MIT License

Copyright (c) 2020-2024 Nathan Stryker

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## 👨‍💻 Author

**Nathan Stryker**
- Email: Nathan@Strykeout.com
- Company: NPS Consulting LLC
- GitHub: [@NPSconsultingLLC](https://github.com/NPSconsultingLLC)

---

## 🙏 Acknowledgments

- **Firebase** - Backend services
- **Google Mobile Ads** - Monetization
- **Apple** - SwiftUI, Core Data, StoreKit 2, CloudKit
- **Hockey Community** - Feature inspiration and testing

---

## 📱 Support

For bug reports or feature requests:
1. Open an issue on GitHub
2. Email: Nathan@Strykeout.com
3. Use in-app "Contact Support" feature

---

## 🔄 Version History

### v2.0 (In Development)
- ✅ Migrated to Swift Package Manager
- ✅ Updated to StoreKit 2
- ✅ iOS 15+ async/await patterns
- ✅ Goal location visualization
- ✅ Modern Google Mobile Ads SDK

### v1.0 (2020)
- Initial release
- Basic game tracking
- Core Data persistence
- Firebase integration

---

**Last Updated:** December 26, 2024

**Status:** 🚧 Active Development

---

## 🏁 Quick Start Commands

```bash
# Clone and open
git clone https://github.com/NPSconsultingLLC/fiveHole.git && cd fiveHole
open FiveHole.xcodeproj

# Build
xcodebuild -scheme FiveHole -sdk iphonesimulator

# Test
xcodebuild test -scheme FiveHole -destination 'platform=iOS Simulator,name=iPhone 15'
```

---

**Made with ❤️ for hockey goalies**
