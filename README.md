
# NewsBay - iOS Posts App

## Project Overview

NewsBay is a modern iOS application built with SwiftUI that allows users to browse, search, and view posts from the DummyJSON API. The app is designed with a clean and scalable architecture, following modern iOS development best practices.

## Features

- **Authentication:** Secure login with JWT token handling. The app supports persistent login and a mock registration flow.
- **Dashboard:** A dynamic dashboard that showcases featured and recent posts.
- **Post Viewing:** View all posts with pagination.
- **Search:** Real-time backend search for posts.
- **Pull-to-Refresh:** Refresh the post list with a simple pull gesture.

## Architecture

The project follows the **MVVM (Model-View-ViewModel) + Repository** architectural pattern.

- **Model:** The data layer, consisting of Swift data models that represent the application's data structures.
- **View:** The UI layer, built with SwiftUI. The views are responsible for displaying data and capturing user input.
- **ViewModel:** The presentation logic layer, which prepares data for the view and handles user interactions.
- **Repository:** The data abstraction layer, which separates the application's business logic from the data sources (network or local database).

## Technology Stack

- **UI Framework:** SwiftUI
- **Local Storage:** SwiftData
- **Networking:** Async/await with URLSession
- **Build Configuration:** XCConfig
- **Testing:** XCTest

## Setup Instructions

1.  **Open the project in Xcode:**
    ```sh
    open NewsBay.xcodeproj
    ```
2.  **Select a build scheme:**
    - In Xcode, click on the active scheme (next to the run/stop buttons) and choose one of the following:
        - `App-Development`
        - `App-Staging`
        - `App-Production`
3.  **Run the app:**
    - Select a simulator or a connected device and click the run button.

## Build Configurations

The project is configured with three build schemes, each with its own set of configurations managed by `.xcconfig` files.

- **Development:** For day-to-day development.
- **Staging:** For testing and QA.
- **Production:** For the final release.

## Authentication

The app uses the DummyJSON API for authentication. You can use the following hardcoded credentials to log in:

- **Username:** `emilys`
- **Password:** `emilyspass`

Or:

- **Username:** `michaelw`
- **Password:** `michaelwpass`

For more users, please refer to the [DummyJSON documentation](https://dummyjson.com/docs).

## Testing

The project includes a suite of unit tests covering the business logic of the application. To run the tests:

1.  In Xcode, open the Test Navigator (Cmd + 6).
2.  Click the play button next to the `NewsBayTests` test plan.
