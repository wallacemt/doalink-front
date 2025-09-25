# DoaLink Flutter App - AI Coding Agent Instructions

## Project Overview

DoaLink is a Flutter donation management app connecting donors with those in need through an interactive map interface. The app features splash screen, authentication flow, Google Maps integration, and a curved bottom navigation bar.

## Architecture Patterns

### Navigation Structure

- **Main App Flow**: `SplashScreen` → `HomePageAuth` (authentication) → `WrapHomeScreen` (main app)
- **Route-based Navigation**: Uses named routes with `WrapHomeScreen` wrapper for bottom navigation
- **Nested Navigation**: `WrapHomeScreen` contains 3 tabs: `/home`, `/map`, `/profile` with CurvedNavigationBar
- **Navigation Pattern**: Always use `Navigator.of(context).pushNamed()` for route transitions

### Component Architecture

```
lib/
├── main.dart                 # App entry point with dotenv loading
├── screens/                  # Full-screen widgets
│   ├── auth/                # Authentication flow
│   ├── app/                 # Main application screens
│   └── splash_screen.dart   # Animated splash with transition
├── widgets/                 # Reusable components
│   ├── auth/               # Auth-specific widgets
│   ├── maps/               # Google Maps components
│   └── loading_screen.dart # Animated loading states
├── theme/app_colors.dart   # Centralized color system
└── config/app_config.dart  # Environment variable management
```

## Critical Development Patterns

### Environment Variables & API Keys

- **Always use AppConfig class** for accessing environment variables:
  ```dart
  import 'package:doalink/config/app_config.dart';
  String apiKey = AppConfig.googleMapsApiKey;
  ```
- **Google Maps API Key**: Configured via `.env` file and Android manifest placeholders
- **Build Configuration**: Android uses Kotlin DSL with .env parsing in `build.gradle.kts`

### Color System (AppColors class)

- **Primary Actions**: `AppColors.orange_500` (#FF9800)
- **Backgrounds**: `AppColors.cleanCian` (#F5F5F5)
- **Text**: `AppColors.black` (#212121), `AppColors.medianCian` (#616161)
- **Accents**: Green variants for success, blue variants for info

### Navigation Wrapper Pattern

`WrapHomeScreen` is crucial - it determines current screen via route parameter:

```dart
WrapHomeScreen(route: '/home')  // Shows AddDonationBoxScreen
WrapHomeScreen(route: '/map')   // Shows MapScreen
WrapHomeScreen(route: '/profile') // Shows UserSettings
```

### Animation Standards

- **Entrance Animations**: Use `animate_do` package with `FadeInUp` duration 1000-1500ms
- **Loading States**: Implement dual AnimationController pattern (rotation + pulse)
- **Transitions**: Splash screen uses 3-second delay with MaterialPageRoute replacement

## Google Maps Integration

- **API Key Management**: Via `AppConfig.googleMapsApiKey` from `.env`
- **Android Configuration**: `manifestPlaceholders["googleMapsApiKey"]` in build.gradle.kts
- **iOS Configuration**: Environment.xcconfig with shell script injection
- **Widget Location**: `lib/widgets/maps/map.dart`

## Build & CI/CD Specifics

- **GitHub Actions**: 6 parallel jobs including analyze, test, Android/iOS builds
- **APK Variants**: ARM64 (primary), ARM32, x64 for different device architectures
- **Environment Injection**: CI uses `GOOGLE_MAPS_API_KEY` secret for production builds
- **Artifact Generation**: Creates ready-to-install APK with proper API keys

## Development Workflow Commands

```bash
# Environment setup
flutter pub get
echo "GOOGLE_MAPS_API_KEY=your_key_here" > .env

# Development
flutter run --debug
flutter build apk --release --split-per-abi

# Testing & Analysis
flutter test --coverage
flutter analyze --fatal-infos
```

## Common Gotchas

- **GlobalKey Conflicts**: Avoid duplicate keys in navigation - use unique keys per screen
- **Environment Loading**: Always call `await dotenv.load()` in main() before runApp()
- **Bottom Navigation**: Use route-based navigation, not index-based for CurvedNavigationBar
- **Google Maps**: Requires both Flutter config AND Android/iOS native configuration
- **Splash Navigation**: Use `pushReplacement()` not `push()` to prevent back navigation

## Dependencies of Note

- `curved_navigation_bar`: Bottom navigation UI
- `google_maps_flutter`: Maps integration
- `flutter_dotenv`: Environment variable management
- `animate_do`: Entrance animations
- `carousel_slider`: Onboarding carousel component

## File Naming Convention

- Screens: `snake_case_screen.dart`
- Widgets: `snake_case.dart`
- Auth components: `auth/` subfolder
- Map components: `maps/` subfolder
