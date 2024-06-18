<p align="center">
  <img src="https://github.com/AndrewEllen/PEAK/blob/main/assets/logo.png?raw=true" width="100" alt="project-logo">
</p>
<p align="center">
    <h1 align="center">PEAK</h1>
</p>
<p align="center">
    <em>Peak into the world of fitness.</em>
</p>
<p align="center">
	<img src="https://img.shields.io/github/license/AndrewEllen/PEAK?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/AndrewEllen/PEAK?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/AndrewEllen/PEAK?style=default&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/AndrewEllen/PEAK?style=default&color=0080ff" alt="repo-language-count">
<p>
<p align="center">
	<!-- default option, no dependency badges. -->
</p>

<br><!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary><br>

- [📍 Overview](#-overview)
- [🧩 Features](#-features)
- [🗂️ Repository Structure](#️-repository-structure)
- [📦 Modules](#-modules)
- [🚀 Getting Started](#-getting-started)
  - [⚙️ Installation](#️-installation)
  - [🤖 Usage](#-usage)
  - [🧪 Tests](#-tests)
- [🛠 Project Roadmap](#-project-roadmap)
- [🤝 Contributing](#-contributing)
- [🎗 License](#-license)
</details>
<hr>

## 📍 Overview

PEAK is a social media app that aims to provide a dedicated platform to the fitness community. It leverages Flutter for seamless UI elements and Firebase for backend support. PEAK facilitates user engagement through features like dynamic commenting, post creation, and user profile management. With robust integration for both Android and iOS platforms, PEAK offers a cohesive user experience.

---

## 🧩 Features

|    |   Feature         | Description |
|----|-------------------|---------------------------------------------------------------|
| ⚙️  | **Architecture**  | The project has a structured architecture with separate directories for Android, iOS, lib (Flutter code), and web. It integrates Flutter with Firebase for authentication, data storage, and UI elements. The codebase follows best practices for app organization and platform-specific configurations. |
| 🔩 | **Code Quality**  | The codebase maintains a high level of quality with clear separation of concerns, consistent styling, and adherence to Flutter best practices. It includes lint rule customization and lint suppression guidelines to ensure code quality consistency. |
| 📄 | **Documentation** | Detailed documentation is provided in the repository, covering linting, testing, configuration, and setup processes. The pubspec.yaml file defines dependencies and configurations, while key files have descriptions explaining their roles and functionalities in the project. |
| 🔌 | **Integrations**  | Key integrations include Firebase for authentication and data storage, Google Sign-In for user authentication, and UUID for unique identifier generation. External dependencies involve Kotlin, Dart, Swift, Gradle, and various Flutter plugins for extended functionality. |
| 🧩 | **Modularity**    | The codebase demonstrates modularity and reusability through separate helper functions, models, providers, and widgets. Each module focuses on a specific task, promoting code reusability and maintainability across different sections of the app. |
| 🧪 | **Testing**       | Testing frameworks and tools used include XCTest for iOS testing and Flutter's testing capabilities for widget and unit testing. The pipeline.yml file ensures consistent linting and testing across branches, enhancing code reliability and quality. |
| ⚡️  | **Performance**   | The project aims for optimized performance with efficient build configurations, smooth Flutter integration in both Android and iOS environments, and streamlined data handling with Firestore. The use of caching mechanisms and dynamic UI elements enhances user experience and app responsiveness. |
| 🛡️ | **Security**      | Security measures include Firebase authentication for user login, Firestore database for data storage with access control, and Google Sign-In for secure authentication. The architecture ensures secure user interactions and data handling within the app environment. |
| 📦 | **Dependencies**  | Key external libraries and dependencies encompass Kotlin, Dart, Swift, Gradle, Flutter plugins for social interactions, Firebase for data management, and UUID for unique identifier generation. These dependencies support various functionalities within the app architecture. |

---

## 🗂️ Repository Structure

```sh
└── PEAK/
    ├── .git
    │   └── objects
    ├── analysis_options.yaml
    ├── android
    │   ├── .gitignore
    │   ├── app
    │   ├── build.gradle
    │   ├── gradle
    │   ├── gradle.properties
    │   ├── peak_android.iml
    │   └── settings.gradle
    ├── assets
    │   └── logo.png
    ├── ios
    │   ├── .gitignore
    │   ├── Flutter
    │   ├── Runner
    │   ├── Runner.xcodeproj
    │   ├── Runner.xcworkspace
    │   └── RunnerTests
    ├── lib
    │   ├── constants.dart
    │   ├── helpers
    │   ├── main.dart
    │   ├── models
    │   ├── pages
    │   ├── providers
    │   └── widgets
    ├── peak.iml
    ├── pipeline.yml
    ├── pubspec.yaml
    ├── README.md
    └── web
        ├── favicon.png
        ├── icons
        ├── index.html
        └── manifest.json
```

---

## 📦 Modules

<details closed><summary>.</summary>

| File                                                                                           | Summary                                                                                                                                                                                                                                                                                      |
| ---                                                                                            | ---                                                                                                                                                                                                                                                                                          |
| [analysis_options.yaml](https://github.com/AndrewEllen/PEAK/blob/master/analysis_options.yaml) | Configures analyzer to enforce coding best practices and analyze Dart code in the project. Includes lint rule customization options and guidelines for lint suppression. Promotes adherence to recommended lints for Flutter apps, packages, and plugins.                                    |
| [pipeline.yml](https://github.com/AndrewEllen/PEAK/blob/master/pipeline.yml)                   | Ensures linting and testing across branches. Runs build and tests using Flutter, caching dependencies for efficiency. Facilitates consistent quality control, particularly on the master branch.                                                                                             |
| [pubspec.yaml](https://github.com/AndrewEllen/PEAK/blob/master/pubspec.yaml)                   | Defines dependencies and configurations for the Peak fitness app. Manages Flutter plugins for authentication, data storage, and UI elements. Sets versioning, asset paths, and linting rules for development. Supports social interactions and fitness tracking within the app architecture. |

</details>

<details closed><summary>android</summary>

| File                                                                                       | Summary                                                                                                                                                                                                                                                |
| ---                                                                                        | ---                                                                                                                                                                                                                                                    |
| [build.gradle](https://github.com/AndrewEllen/PEAK/blob/master/android\build.gradle)       | Manages Android project build dependencies, configuration, and settings. Centralizes Kotlin and Android Gradle plugin versions, declares repository sources, and sets up build directories for subprojects. Streamlines project setup and maintenance. |
| [settings.gradle](https://github.com/AndrewEllen/PEAK/blob/master/android\settings.gradle) | Manages configuration and dependencies for the Flutter app build process, coordinating plugin loading via settings.gradle.                                                                                                                             |

</details>

<details closed><summary>android.app</summary>

| File                                                                                     | Summary                                                                                                                                                                                                                                                                          |
| ---                                                                                      | ---                                                                                                                                                                                                                                                                              |
| [build.gradle](https://github.com/AndrewEllen/PEAK/blob/master/android\app\build.gradle) | Defines Android app build configurations, including Flutter SDK setup, version settings, and Kotlin dependencies. Achieves seamless integration between Flutter and Android, ensuring compatibility and efficient development workflow within the PEAK repositorys architecture. |

</details>

<details closed><summary>android.app.src.main.kotlin.com.example.peak</summary>

| File                                                                                                                            | Summary                                                                                                                                                                                         |
| ---                                                                                                                             | ---                                                                                                                                                                                             |
| [MainActivity.kt](https://github.com/AndrewEllen/PEAK/blob/master/android\app\src\main\kotlin\com\example\peak\MainActivity.kt) | Enables Flutter integration in the PEAK repositorys Android platform by defining the MainActivity class, facilitating smooth interaction between the Flutter framework and Android environment. |

</details>

<details closed><summary>ios.Flutter</summary>

| File                                                                                                         | Summary                                                                                                                                                                                                                            |
| ---                                                                                                          | ---                                                                                                                                                                                                                                |
| [AppFrameworkInfo.plist](https://github.com/AndrewEllen/PEAK/blob/master/ios\Flutter\AppFrameworkInfo.plist) | Defines critical metadata for the iOS app framework, including versioning and identifying information necessary for proper functioning within the Flutter ecosystem.                                                               |
| [Debug.xcconfig](https://github.com/AndrewEllen/PEAK/blob/master/ios\Flutter\Debug.xcconfig)                 | Defines Flutter build configurations, importing settings from Generated.xcconfig for iOS development in the PEAK repository.                                                                                                       |
| [Release.xcconfig](https://github.com/AndrewEllen/PEAK/blob/master/ios\Flutter\Release.xcconfig)             | Defines Flutter build settings for release mode in iOS. Integrates configurations from Generated.xcconfig. Facilitates optimized app performance and compatibility in the iOS environment within the PEAK repository architecture. |

</details>

<details closed><summary>ios.Runner</summary>

| File                                                                                                            | Summary                                                                                                                                                                                                                                  |
| ---                                                                                                             | ---                                                                                                                                                                                                                                      |
| [AppDelegate.swift](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\AppDelegate.swift)               | Implements Flutter integration in iOS, registering plugins to enable seamless communication between native UIKit and Dart code in the PEAK mobile app.                                                                                   |
| [GoogleService-Info.plist](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\GoogleService-Info.plist) | Describes iOS application configuration settings for Google services in the Runner subdirectory.                                                                                                                                         |
| [Info.plist](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Info.plist)                             | Defines app configuration settings in iOS, ensuring proper display and functionality for the Peak app. Includes essential identifiers, version info, interface orientations, and usage descriptions for camera and photo library access. |
| [Runner-Bridging-Header.h](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Runner-Bridging-Header.h) | Integrates plugins into the iOS Flutter project.                                                                                                                                                                                         |

</details>

<details closed><summary>ios.Runner.Assets.xcassets.AppIcon.appiconset</summary>

| File                                                                                                                         | Summary                                                                                                                                                                                   |
| ---                                                                                                                          | ---                                                                                                                                                                                       |
| [Contents.json](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Assets.xcassets\AppIcon.appiconset\Contents.json) | Defines iOS app icon images for various sizes and resolutions, key for visual branding. Supports iPhone, iPad, and marketing icon configurations in the PEAK repositorys Flutter project. |

</details>

<details closed><summary>ios.Runner.Assets.xcassets.LaunchImage.imageset</summary>

| File                                                                                                                           | Summary                                                                                                                                                                                                                                      |
| ---                                                                                                                            | ---                                                                                                                                                                                                                                          |
| [Contents.json](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Assets.xcassets\LaunchImage.imageset\Contents.json) | Defines LaunchImage assets for iOS app deployment in Runner subfolder. Assigns different resolutions for universal idioms. Vital for app branding and appearance during launch. Complements the architecture for a cohesive user experience. |

</details>

<details closed><summary>ios.Runner.Base.lproj</summary>

| File                                                                                                                     | Summary                                                                                                                                                                                          |
| ---                                                                                                                      | ---                                                                                                                                                                                              |
| [LaunchScreen.storyboard](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Base.lproj\LaunchScreen.storyboard) | Defines iOS app launch screen layout with autoresizing, image view, and constraints. Facilitates scale-to-fill content mode with a centered image, enhancing user experience during app startup. |
| [Main.storyboard](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner\Base.lproj\Main.storyboard)                 | Defines the iOS Flutter view controller layout in the Runner app, specifying an initial FlutterViewController with autoresizing properties.                                                      |

</details>

<details closed><summary>ios.Runner.xcodeproj</summary>

| File                                                                                                    | Summary                                                                                                                                                                                                    |
| ---                                                                                                     | ---                                                                                                                                                                                                        |
| [project.pbxproj](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcodeproj\project.pbxproj) | Defines build configurations for the Runner and RunnerTests targets in the Xcode project, setting up debug, release, and profile settings. Manages dependencies and resources for the Flutter application. |

</details>

<details closed><summary>ios.Runner.xcodeproj.project.xcworkspace</summary>

| File                                                                                                                                          | Summary                                                                                                                                                                                                       |
| ---                                                                                                                                           | ---                                                                                                                                                                                                           |
| [contents.xcworkspacedata](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcodeproj\project.xcworkspace\contents.xcworkspacedata) | Defines workspace configuration in Xcode project for seamless integration of Flutter Runner. Optimize project structure and maintain workspace settings for efficient iOS development in the PEAK repository. |

</details>

<details closed><summary>ios.Runner.xcodeproj.project.xcworkspace.xcshareddata</summary>

| File                                                                                                                                                               | Summary                                                                                                                                                                                |
| ---                                                                                                                                                                | ---                                                                                                                                                                                    |
| [IDEWorkspaceChecks.plist](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcodeproj\project.xcworkspace\xcshareddata\IDEWorkspaceChecks.plist)         | Enforces Mac 32-bit warning computation in the iOS project workspace to ensure compatibility.                                                                                          |
| [WorkspaceSettings.xcsettings](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcodeproj\project.xcworkspace\xcshareddata\WorkspaceSettings.xcsettings) | Customize Xcode workspace settings for iOS development, disabling project previews. Optimize development experience and streamline focus within the PEAK repositorys iOS architecture. |

</details>

<details closed><summary>ios.Runner.xcodeproj.xcshareddata.xcschemes</summary>

| File                                                                                                                           | Summary                                                                                                                                                                                                                                 |
| ---                                                                                                                            | ---                                                                                                                                                                                                                                     |
| [Runner.xcscheme](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcodeproj\xcshareddata\xcschemes\Runner.xcscheme) | Outlines Runner apps Xcode scheme for building, testing, profiling, archiving, and analyzing. Orchestrates project elements and configurations seamlessly within the Xcode environment, enhancing development and deployment workflows. |

</details>

<details closed><summary>ios.Runner.xcworkspace</summary>

| File                                                                                                                        | Summary                                                                                             |
| ---                                                                                                                         | ---                                                                                                 |
| [contents.xcworkspacedata](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcworkspace\contents.xcworkspacedata) | Coordinates Xcode workspace integration within PEAKs iOS section by referencing `Runner.xcodeproj`. |

</details>

<details closed><summary>ios.Runner.xcworkspace.xcshareddata</summary>

| File                                                                                                                                             | Summary                                                                                     |
| ---                                                                                                                                              | ---                                                                                         |
| [IDEWorkspaceChecks.plist](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcworkspace\xcshareddata\IDEWorkspaceChecks.plist)         | Improve Xcode workspace integrity by enabling Mac 32-bit warning computation.               |
| [WorkspaceSettings.xcsettings](https://github.com/AndrewEllen/PEAK/blob/master/ios\Runner.xcworkspace\xcshareddata\WorkspaceSettings.xcsettings) | Enables disabling previews in iOS Xcode workspace settings for better development workflow. |

</details>

<details closed><summary>ios.RunnerTests</summary>

| File                                                                                                   | Summary                                                                                                              |
| ---                                                                                                    | ---                                                                                                                  |
| [RunnerTests.swift](https://github.com/AndrewEllen/PEAK/blob/master/ios\RunnerTests\RunnerTests.swift) | Verifies Flutter iOS app functionality. Test Runner app code additions for issues using XCTest in RunnerTests.swift. |

</details>

<details closed><summary>lib</summary>

| File                                                                                 | Summary                                                                                                                                                                                                                                               |
| ---                                                                                  | ---                                                                                                                                                                                                                                                   |
| [constants.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\constants.dart) | Defines app color constants and default text style in Flutter for consistent theming across PEAK repository.                                                                                                                                          |
| [main.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\main.dart)           | Defines app initialization with Firebase, sets up providers for navigation and home feed, and renders the root widget MyApp. MyApp configures the apps design, theme, and default landing page using Flutter and customizations for Peak application. |

</details>

<details closed><summary>lib.helpers.firebase</summary>

| File                                                                                                                | Summary                                                                                                                                                                                                                                          |
| ---                                                                                                                 | ---                                                                                                                                                                                                                                              |
| [comments_handler.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\helpers\firebase\comments_handler.dart) | Handles posting comments, fetching comment counts, and fetching reply counts for posts in the repositorys Firestore database. Implements Firestore operations for managing comment data seamlessly within the application.                       |
| [fetch_post.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\helpers\firebase\fetch_post.dart)             | Retrieves post data from Firestore for a given postID. Utilizes Cloud Firestore to fetch and parse post details, encapsulating them in a PostModel object for the applications use within the PEAK repositorys architecture.                     |
| [likes_handler.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\helpers\firebase\likes_handler.dart)       | Implements Firebase functionality to manage likes in the PEAK app. Key features include handling like operations, updating like counts, and retrieving like data, contributing to seamless user engagement within the overall PEAK architecture. |
| [profile_handlers.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\helpers\firebase\profile_handlers.dart) | Implements Firebase handlers for fetching user data in the PEAK repository. Functions retrieve user post count and user details from Firestore. Integrated with Flutter for dynamic data display.                                                |

</details>

<details closed><summary>lib.models.posts</summary>

| File                                                                                                | Summary                                                                                                                                                                                         |
| ---                                                                                                 | ---                                                                                                                                                                                             |
| [post_model.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\models\posts\post_model.dart) | Defines a PostModel class with poster details and post content for Firestore data mapping. Key in managing structured data within the PEAK projects models for efficient storage and retrieval. |

</details>

<details closed><summary>lib.models.users</summary>

| File                                                                                                              | Summary                                                                                                                                                                                                      |
| ---                                                                                                               | ---                                                                                                                                                                                                          |
| [user_search_model.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\models\users\user_search_model.dart) | Defines a UserSearchModel mapping method for user data within the PEAK repositorys lib\models\users directory. The model encapsulates essential user details such as user ID, name, and profile picture URL. |

</details>

<details closed><summary>lib.pages.comments</summary>

| File                                                                                                        | Summary                                                                                                                                                                                                                         |
| ---                                                                                                         | ---                                                                                                                                                                                                                             |
| [comments_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\comments\comments_page.dart) | Implements dynamic comment loading and posting in a Flutter app using Firebase. Handles comment pagination, replies, and user interactions. Manages comment data retrieval, display, and submission, enhancing user engagement. |

</details>

<details closed><summary>lib.pages.home</summary>

| File                                                                                            | Summary                                                                                                                                                                                                       |
| ---                                                                                             | ---                                                                                                                                                                                                           |
| [home_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\home\home_page.dart) | Implements home feed pagination and post generation. Manages Firestore data fetching and logout functionality. Uses Firebase, Google Sign-In, and UUID package. Supports dynamic post creation and scrolling. |

</details>

<details closed><summary>lib.pages.main</summary>

| File                                                                                              | Summary                                                                                                                                                                                                                                                                                               |
| ---                                                                                               | ---                                                                                                                                                                                                                                                                                                   |
| [front_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\main\front_page.dart) | Implements Google and Twitter sign-in functionality within the FrontPage screen, allowing users to authenticate using their respective accounts. Displays a visually appealing UI with sign-in buttons and registration prompts to enhance user experience and streamline the authentication process. |
| [main_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\main\main_page.dart)   | Enhances app navigation with a main page widget comprising dynamic content and a custom navigation bar. Improves user experience through seamless transitions between various sections like Home, Search, New Post, and Profile based on the selected destination.                                    |

</details>

<details closed><summary>lib.pages.post</summary>

| File                                                                                                    | Summary                                                                                                                                                                                                                                                                      |
| ---                                                                                                     | ---                                                                                                                                                                                                                                                                          |
| [new_post_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\post\new_post_page.dart) | Enables users to create and share posts with images.-Facilitates image cropping, Firebase storage, and Firestore integration.-Implements dynamic UI elements based on user actions.-Enhances user experience with image selection options and post submission functionality. |

</details>

<details closed><summary>lib.pages.profile</summary>

| File                                                                                                     | Summary                                                                                                                                                                                                                                                |
| ---                                                                                                      | ---                                                                                                                                                                                                                                                    |
| [profile_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\profile\profile_page.dart) | Displays users profile with post count, editable username, and clickable posts for detail view. Integrates Firestore queries, authentication, and future handling. Follows Flutter best practices for stateful widgets and asynchronous data fetching. |

</details>

<details closed><summary>lib.pages.search</summary>

| File                                                                                                  | Summary                                                                                                                                                                                                                             |
| ---                                                                                                   | ---                                                                                                                                                                                                                                 |
| [search_page.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\pages\search\search_page.dart) | Implements user search functionality with Firestore integration for retrieving and displaying user profiles. Validates search input and populates search results dynamically. Supports profile page navigation from search results. |

</details>

<details closed><summary>lib.providers.home</summary>

| File                                                                                                                  | Summary                                                                                                                                                                                                                                    |
| ---                                                                                                                   | ---                                                                                                                                                                                                                                        |
| [home_feed_provider.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\providers\home\home_feed_provider.dart) | Manages caching user data, loading user data from cache or database, and updating the home feed list through Firestore queries. Key features include caching mechanisms, database fetches, and list updates for a dynamic user experience. |

</details>

<details closed><summary>lib.providers.navigation</summary>

| File                                                                                                                          | Summary                                                                                                                                                                                                                                |
| ---                                                                                                                           | ---                                                                                                                                                                                                                                    |
| [navigation_provider.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\providers\navigation\navigation_provider.dart) | Manages the apps page navigation states, caching, and transitions. Facilitates seamless transitions between different pages while maintaining cache history. Allows for page changes, cache clearing, and navigation resets with ease. |

</details>

<details closed><summary>lib.widgets</summary>

| File                                                                                                   | Summary                                                                                                                                                                                                                      |
| ---                                                                                                    | ---                                                                                                                                                                                                                          |
| [comment_widget.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\widgets\comment_widget.dart) | Implements a comment widget for displaying comments with user data fetched asynchronously. Renders user information, comment content, and a like button. Interacts with `HomeFeedProvider` to load user data.                |
| [default_modal.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\widgets\default_modal.dart)   | Enables displaying a customizable modal bottom sheet with drag handle in Flutter apps. Maintains a consistent design for modal presentation, ensuring a smooth user experience.                                              |
| [post_widget.dart](https://github.com/AndrewEllen/PEAK/blob/master/lib\widgets\post_widget.dart)       | Displays a post with user details, image, description, like/comment icons.-Dynamically fetches posters data and comment count.-Clicking comment icon shows comments.-Efficiently manages UI elements for a social media app. |

</details>

<details closed><summary>web</summary>

| File                                                                               | Summary                                                                                                                                                                                                                        |
| ---                                                                                | ---                                                                                                                                                                                                                            |
| [index.html](https://github.com/AndrewEllen/PEAK/blob/master/web\index.html)       | Enables web app initialization and service worker handling. Sets metadata, icons, and base paths for the Peak social fitness app. Improves user experience with Flutter integration and dynamic loading of main functionality. |
| [manifest.json](https://github.com/AndrewEllen/PEAK/blob/master/web\manifest.json) | Defines Peak apps web manifest with a standalone display mode, fitness-focused description, and custom icons for various screen sizes. Sets background and theme colors, optimizing user experience and branding.              |

</details>

---

## 🚀 Getting Started

**System Requirements:**

* **Dart**: `version 3.4.0`
* **Flutter**: `version 3.21.0`
* **Android Studio**: `Android Studio Bumblebee 2021.1.1 or later. Or another compatible IDE`

### ⚙️ Installation

<h4>From <code>source</code></h4>

> 1. Clone the PEAK repository:
>
> ```console
> $ git clone https://github.com/AndrewEllen/PEAK
> ```
>
> 2. Change to the project directory:
> ```console
> $ cd PEAK
> ```
>
> 3. Install the dependencies:
> ```console
> $ pub get
> ```

### 🤖 Usage

<h4>From <code>source</code></h4>

> Run PEAK using the command below:
> ```console
> $ dart main.dart
> ```

### 🧪 Tests

> Run the test suite using the command below:
> ```console
> $ dart test
> ```

---

## 🛠 Project Roadmap

- [X] `► Implement commenting and replying to posts`
- [ ] `► Implement following and friends feature`
- [ ] `► Implement direct messaging`

---

## 🤝 Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Report Issues](https://github.com/AndrewEllen/PEAK/issues)**: Submit bugs found or log feature requests for the `PEAK` project.
- **[Submit Pull Requests](https://github.com/AndrewEllen/PEAK/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/AndrewEllen/PEAK/discussions)**: Share your insights, provide feedback, or ask questions.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/AndrewEllen/PEAK
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="center">
   <a href="https://github.com{/AndrewEllen/PEAK/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=AndrewEllen/PEAK">
   </a>
</p>
</details>

---

## 🎗 License

All Rights Reserved.

---

[**Return**](#-overview)

---
