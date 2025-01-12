#  My Weather App 🌦️

## Features
- Real-Time Weather Data: Fetch and display current weather for any location.
- View location on map for current and favorited locations
- Favorites Management: Save and view your favorite locations.
- Clean Codebase: Written with Swift best practices and no external dependencies.

## Architecture

### MVVM (Model-View-ViewModel)
- The app uses the MVVM pattern for separation of concerns:
- Model: Represents data and its associated logic. Includes structs for weather data and favorite locations.
- ViewModel: Mediates between the View and Model, containing business logic and data formatting for display.
- View: Handles user interaction and displays information.

## How to Build

### Prerequisites
- Xcode: Version 15.0 or later.
- Swift: Version 5.9 or later.
