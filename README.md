#  My Weather App 🌦️
A minimalistic weather app built with Swift and SwiftData. This app is designed to fetch weather data directly from an API, save favorite locations using SwiftData, and adhere to best practices while avoiding third-party dependencies.


## Features
- **Real-Time Weather Data**: Fetch and display current weather for any location.
- **View location** on map for current and favorited locations
- **Favorites Management**: Save and view your favorite locations.
- **Clean Codebase**: Written with Swift best practices and no external dependencies.

## Conventions

- Code Style: Follows the Swift API Design Guidelines.
- Naming: Uses camelCase for variables and PascalCase for types.

### Project Organization:
- Models: Data structures and logic.
- Views: UI components.
- ViewModels: Business logic and data transformation for views.
- Services: API and networking logic.
- Persistence: SwiftData integration for local storage.
- Error Handling: Implements Result-based error handling for robust and predictable API calls.

## Architecture

### MVVM (Model-View-ViewModel)
- The app uses the MVVM pattern for separation of concerns:
- **Model**: Represents data and its associated logic. Includes structs for weather data and favorite locations.
- **ViewModel**: Mediates between the View and Model, containing business logic and data formatting for display.
- **View**: Handles user interaction and displays information.

### Dependencies
- None. This app deliberately avoids third-party dependencies to reduce overhead, ensure full control over the codebase, and simplify maintenance.

## How to Build

### Prerequisites
1. **Xcode**: Version 15.0 or later.
2. **Swift**: Version 5.9 or later.

### steps
1. Clone the repository or download as zip file
2. Navigate to the xcodeproj file and open
3. Configure the API Key:
- Navigate to Shared/Utils/APIConstants.swift.
- Replace YOUR_API_KEY_HERE with your weather API key from [OpenWeatherMap](https://home.openweathermap.org/api_keys).
3. Build and run the app

## Additional Notes

### Error Handling:
API errors are handled gracefully with appropriate user feedback (e.g., alerts for no internet or invalid locations).

### Testing:
Includes unit tests for ViewModel and Services. Add more tests for edge cases and SwiftData integration as needed.

### API Rate Limits:
Be mindful of the rate limits imposed by the weather API provider. Ensure error messages guide users appropriately if the limit is exceeded.

