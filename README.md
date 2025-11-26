# Jollycast - Podcast Streaming Application

A Flutter-based podcast streaming application with offline support, audio playback, and a modern UI inspired by Spotify.

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [State Management](#state-management)
- [Implementation Details](#implementation-details)
- [Assumptions](#assumptions)
- [Future Improvements](#future-improvements)
- [Development](#development)

## 🎯 Project Overview

Jollycast is a podcast streaming application that allows users to discover, play, and manage podcast episodes. The app features a modern UI with smooth animations, offline caching capabilities, and real-time connectivity monitoring.

## ✨ Features

### Core Features

- **User Authentication**: Secure login with phone number and password, session persistence
- **Discover Screen**: Browse trending episodes, editor's picks, top podcasts, latest episodes, and handpicked content
- **Audio Player**: Full-featured audio player with play/pause, seek, rewind, and fast-forward controls
- **Mini Player**: Persistent mini player that appears above the bottom navigation bar
- **Offline Mode**: Automatic caching of API responses for offline access
- **Connectivity Monitoring**: Real-time network status detection with user notifications
- **Pull-to-Refresh**: Liquid pull-to-refresh animation for data updates
- **Shimmer Loading**: Elegant loading states with shimmer effects
- **Image Caching**: Automatic image caching for improved performance

### UI/UX Features

- Responsive design using `flutter_screenutil`
- Custom animations and transitions
- Gradient backgrounds and blur effects
- Consistent design system with reusable components
- Smooth page transitions (slide-up animations)

## 🛠 Tech Stack

### Core Dependencies

- **Flutter SDK**: ^3.9.2
- **State Management**: `provider` (^6.1.5+1)
- **HTTP Client**: `http` (^1.3.0)
- **Audio Playback**: `just_audio` (^0.10.5)
- **Image Caching**: `cached_network_image` (^3.4.1)
- **Local Storage**:
  - `shared_preferences` (^2.3.2) - User preferences
  - `flutter_secure_storage` (^9.2.2) - Secure token storage
  - `hive` (^2.2.3) + `hive_flutter` (^1.1.0) - Fast caching

### UI/UX Libraries

- `flutter_screenutil` (^5.9.3) - Responsive sizing
- `flutter_svg` (^2.0.17) - SVG support
- `shimmer` (^3.0.0) - Loading animations
- `liquid_pull_to_refresh` (^3.0.1) - Pull-to-refresh
- `google_fonts` (^6.2.1) - Custom typography

### Utilities

- `connectivity_plus` (^6.1.0) - Network connectivity monitoring
- `intl` (^0.19.0) - Internationalization and date formatting
- `logger` (^2.5.0) - Structured logging
- `fluttertoast` (^8.2.12) - Toast notifications

### Development Tools

- `build_runner` (^2.4.14) - Code generation
- `flutter_gen_runner` (^5.10.0) - Asset generation
- `flutter_lints` (^5.0.0) - Linting rules

## 📁 Project Structure

```
lib/
├── config/
│   └── api_endpoints.dart          # API endpoint configurations
├── core/
│   ├── auth/
│   │   └── auth_wrapper.dart        # Authentication routing logic
│   ├── model/
│   │   ├── auth/                   # Authentication models
│   │   └── episodes/                # Episode and podcast models
│   ├── provider/
│   │   ├── auth_controller.dart    # Authentication state management
│   │   ├── episodes_controller.dart # Episodes data management
│   │   └── audio_player_controller.dart # Audio playback state
│   └── services/
│       ├── api_service.dart         # HTTP client with caching
│       ├── auth_service.dart        # Authentication API calls
│       ├── episodes_service.dart    # Episodes API calls
│       ├── storage_service.dart     # Secure storage abstraction
│       ├── cache_service.dart       # API response caching
│       └── connectivity_service.dart # Network status monitoring
├── gen/
│   └── assets.gen.dart             # Generated asset references
├── utils/
│   ├── auth_exception.dart         # Custom authentication exception
│   ├── error_parser.dart           # API error parsing
│   ├── logger.dart                 # Logging utility
│   ├── navigation_helper.dart      # Navigation utilities
│   ├── provider_helper.dart        # Provider access helpers
│   └── toast_infos.dart           # Toast notification helpers
├── view/
│   ├── navigation/
│   │   └── bottom_nav_bar.dart     # Bottom navigation bar
│   ├── screens/
│   │   ├── authentication/         # Login, registration screens
│   │   ├── discover/
│   │   │   └── discover_screen.dart # Main discover/feed screen
│   │   ├── player/
│   │   │   └── player_screen.dart   # Full-screen audio player
│   │   ├── categories/              # Categories screen
│   │   ├── library/                 # User library screen
│   │   └── main/
│   │       └── main_screen.dart     # Main screen with navigation
│   └── widgets/
│       ├── appbar.dart              # Custom app bar
│       ├── button.dart              # Custom button widget
│       ├── card.dart                # Episode card components
│       ├── color.dart                # Color constants
│       ├── connectivity_banner.dart # Network status banner
│       ├── interest_tag.dart        # Interest/hashtag tags
│       ├── mini_player.dart         # Mini audio player
│       ├── play_button.dart         # Reusable play/pause button
│       ├── section_header.dart      # Section header component
│       ├── see_all_button.dart      # Action button component
│       ├── shimmer.dart             # Loading shimmer effects
│       ├── text.dart                # Custom text widget
│       └── textfield.dart           # Custom text input
└── main.dart                        # Application entry point
```

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK (^3.9.2 or higher)
- Dart SDK (compatible with Flutter SDK)
- Android Studio / Xcode (for mobile development)
- Git

### Installation Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/iniisking/jollycast.git
   cd jollycast
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate asset references**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

   Or for automatic regeneration on asset changes:

   ```bash
   dart run build_runner watch
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

### Platform-Specific Setup

#### iOS

```bash
cd ios
pod install
cd ..
flutter run
```

#### Android

- Ensure Android SDK is properly configured
- No additional setup required

### Running Tests

```bash
flutter test
```

### Code Formatting

```bash
dart format .
```

### Linting

```bash
dart fix --apply --code=unused_import
```

## 🎛 State Management

### Chosen Approach: Provider Pattern

The project uses **Provider** as the state management solution, chosen for its:

- Simplicity and ease of use
- Built-in Flutter support
- Good performance with selective rebuilds
- Excellent documentation and community support

### State Management Architecture

#### Controllers (ChangeNotifier)

1. **AuthController** (`lib/core/provider/auth_controller.dart`)

   - Manages user authentication state
   - Handles login/logout operations
   - Persists and restores user sessions
   - Manages authentication tokens

2. **EpisodesController** (`lib/core/provider/episodes_controller.dart`)

   - Manages episode data (trending, editor's pick, latest, etc.)
   - Handles API calls for episode data
   - Manages loading and error states
   - Provides pagination support

3. **AudioPlayerController** (`lib/core/provider/audio_player_controller.dart`)

   - Manages audio playback state
   - Controls play/pause/seek operations
   - Tracks playback position and duration
   - Handles buffering states

4. **ConnectivityService** (`lib/core/services/connectivity_service.dart`)
   - Monitors network connectivity status
   - Notifies listeners of connectivity changes
   - Provides online/offline state

#### Provider Setup

Providers are registered in `main.dart`:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ConnectivityService()),
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => EpisodesController()),
    ChangeNotifierProvider(create: (_) => AudioPlayerController()),
  ],
  child: MaterialApp(...),
)
```

#### Accessing State

Using `ProviderHelper` utility for simplified access:

```dart
// Before (verbose)
final controller = Provider.of<EpisodesController>(context, listen: false);
final token = Provider.of<AuthController>(context, listen: false).token;

// After (simplified)
final controller = ProviderHelper.episodes(context);
final token = ProviderHelper.token(context);
```

#### Consumer Pattern

For reactive UI updates:

```dart
Consumer<AudioPlayerController>(
  builder: (context, audioController, child) {
    return PlayButton(episode: episode);
  },
)
```

## 🏗 Implementation Details

### Authentication Flow

1. **Login Process**

   - User enters phone number and password
   - `AuthService.login()` makes API call
   - Token and user data stored securely
   - Session persisted using `StorageService`
   - User redirected to main app

2. **Session Restoration**

   - On app startup, `AuthController` attempts to restore session
   - Token loaded from `flutter_secure_storage`
   - User data loaded from `shared_preferences`
   - Splash screen shown during restoration
   - User redirected based on authentication status

3. **Logout Process**
   - Clears all stored authentication data
   - Resets controllers to initial state
   - Redirects to login screen

### Caching & Offline Mode

#### Cache Service Architecture

1. **CacheService** (`lib/core/services/cache_service.dart`)

   - Uses Hive for fast key-value storage
   - Caches API responses with expiration (24 hours default)
   - Generates cache keys from URL and query parameters
   - Automatically handles expired cache entries

2. **API Service Integration**

   - `ApiService.get()` checks connectivity status
   - If offline: returns cached data if available
   - If online: makes API call and caches response
   - Fallback to cache if API call fails while offline

3. **Cache Key Generation**
   ```dart
   // Generates unique keys from URL + query params
   final key = _generateCacheKey(url, queryParams);
   ```

#### Connectivity Monitoring

1. **ConnectivityService**

   - Monitors network status using `connectivity_plus`
   - Detects WiFi, mobile data, ethernet connections
   - Notifies listeners of status changes
   - Handles plugin unavailability gracefully

2. **User Feedback**
   - Red banner when offline: "No internet connection. Showing cached data."
   - Green banner when connection restored: "Connection restored" (auto-dismisses after 3 seconds)

### Audio Playback

1. **AudioPlayerController**

   - Uses `just_audio` package for smooth playback
   - Manages current episode, position, duration
   - Handles play/pause/seek operations
   - Listens to position and state streams

2. **Player Screen**

   - Full-screen player with blurred background
   - Custom progress bar with gradient
   - Transport controls (rewind, play/pause, fast-forward)
   - Scrollable content with swipe-to-dismiss

3. **Mini Player**
   - Persistent player above bottom navigation
   - Shows current episode info
   - Quick play/pause toggle
   - Tappable to open full player

### UI Components & Design System

#### Reusable Components (DRY Principle)

1. **SectionHeader**

   - Standardized section headers with icons
   - Consistent spacing and typography
   - Used throughout discover screen

2. **SeeAllButton**

   - Standardized action buttons
   - Two variants: default (small) and large
   - Consistent styling and behavior

3. **PlayButton**

   - Unified play/pause button
   - Automatic state detection
   - Multiple sizes (small, medium, large)
   - Integrated with AudioPlayerController

4. **NavigationHelper**

   - Centralized navigation patterns
   - Slide-up transitions
   - Loading dialog management

5. **ProviderHelper**
   - Simplified provider access
   - Type-safe methods
   - Reduces boilerplate code

### Error Handling

1. **Error Parsing**

   - `ErrorParser` utility for consistent error message extraction
   - Handles various API error formats
   - Provides user-friendly error messages

2. **Authentication Errors**

   - Custom `AuthenticationException` for 401 errors
   - Automatic logout on authentication failure
   - User redirected to login screen

3. **Network Errors**
   - Graceful fallback to cached data
   - User notifications via toast messages
   - Shimmer loading states instead of error messages

### Image Loading

- All network images use `CachedNetworkImage`
- Automatic caching and placeholder support
- Error handling with fallback icons
- Consistent image sizing and aspect ratios

## 🤔 Assumptions

### API Assumptions

1. **Authentication**

   - API returns Bearer token format
   - Token is included in `Authorization` header
   - Token expiration handled server-side
   - 401 status code indicates authentication failure

2. **Data Structure**

   - Episodes have consistent structure across endpoints
   - Pagination follows standard format (page, per_page)
   - Image URLs are always valid and accessible
   - Duration is provided in seconds

3. **Error Responses**
   - API returns JSON error responses
   - Error messages are in consistent format
   - Status codes follow HTTP standards

### User Experience Assumptions

1. **Offline Usage**

   - Users expect cached data when offline
   - Users understand "cached data" messaging
   - 24-hour cache expiration is acceptable

2. **Audio Playback**

   - Users expect smooth audio playback
   - Background playback is acceptable
   - Playback state should persist across screens

3. **Performance**
   - Images should load quickly
   - API responses should be cached
   - App should work smoothly on mid-range devices

### Technical Assumptions

1. **Platform Support**

   - Primary focus on iOS and Android
   - Web and desktop support secondary
   - Minimum iOS 12+ and Android API 21+

2. **Storage**

   - Secure storage available on all platforms
   - Sufficient storage space for cache
   - Cache can be cleared if needed

3. **Network**
   - Users have intermittent connectivity
   - WiFi and mobile data are primary connections
   - VPN connections are supported

## 🔮 Future Improvements

### Performance Optimizations

1. **Image Optimization**

   - Implement image compression
   - Add progressive image loading
   - Optimize image sizes for different screen densities

2. **Caching Improvements**

   - Implement cache size limits
   - Add cache eviction policies
   - Implement cache preloading for popular content

3. **API Optimization**
   - Implement request batching
   - Add request deduplication
   - Implement response compression

### Features

1. **Playback Features**

   - Playback speed control (0.5x, 1x, 1.5x, 2x)
   - Sleep timer functionality
   - Queue management (play next, add to queue)
   - Playlist creation and management

2. **Social Features**

   - Episode sharing
   - User reviews and ratings
   - Follow/unfollow podcasts
   - Social feed integration

3. **Discovery**

   - Advanced search functionality
   - Category filtering
   - Personalized recommendations
   - Trending charts and analytics

4. **User Features**
   - User profiles
   - Listening history
   - Download episodes for offline playback
   - Favorite/bookmark episodes

### Code Quality

1. **Testing**

   - Unit tests for controllers
   - Widget tests for components
   - Integration tests for critical flows
   - E2E tests for user journeys

2. **Documentation**

   - API documentation
   - Component documentation
   - Architecture decision records
   - Code comments and docstrings

3. **Refactoring**
   - Extract more reusable components
   - Implement repository pattern for data access
   - Add dependency injection
   - Improve error handling consistency

### Architecture

1. **State Management**

   - Consider migrating to Riverpod for better testability
   - Implement state persistence
   - Add state debugging tools

2. **Code Organization**

   - Implement feature-based folder structure
   - Add domain layer for business logic
   - Separate presentation and data layers

3. **Dependency Management**
   - Implement dependency injection (get_it)
   - Add service locator pattern
   - Improve testability with interfaces

### UI/UX

1. **Accessibility**

   - Add screen reader support
   - Improve color contrast
   - Add keyboard navigation
   - Implement accessibility labels

2. **Animations**

   - Add more micro-interactions
   - Implement page transitions
   - Add loading animations
   - Improve gesture feedback

3. **Theming**
   - Implement dark/light theme toggle
   - Add custom theme colors
   - Support system theme preference

### Security

1. **Data Protection**

   - Implement certificate pinning
   - Add biometric authentication
   - Encrypt sensitive data
   - Implement secure token refresh

2. **Privacy**
   - Add privacy policy screen
   - Implement data deletion
   - Add user consent management
   - Comply with GDPR/CCPA

### Monitoring & Analytics

1. **Error Tracking**

   - Integrate crash reporting (Sentry, Firebase Crashlytics)
   - Add error analytics
   - Implement error recovery mechanisms

2. **Analytics**
   - Add user behavior tracking
   - Implement performance monitoring
   - Add A/B testing framework
   - Track feature usage

## 🔄 CI/CD

### Current Implementation

This project uses **GitHub Actions** for Continuous Integration and Continuous Deployment. The CI/CD pipelines are configured in `.github/workflows/`.

#### Workflow Files

1. **CI Workflow** (`.github/workflows/ci.yml`)

   - **Triggers**: Runs on push to `main`, `master`, `develop` branches and on pull requests
   - **Flutter Version**: 3.35.4 (stable channel)
   - **Java Version**: 17 (Zulu distribution)

2. **Release Workflow** (`.github/workflows/release.yml`)
   - **Triggers**: Runs on version tags matching pattern `v*.*.*` (e.g., `v1.0.0`)
   - **Flutter Version**: 3.35.4 (stable channel)
   - **Java Version**: 17 (Zulu distribution)

#### CI Pipeline Jobs

The CI workflow includes three jobs:

**1. Test & Analyze Job**

- Code formatting verification (`dart format --output=none --set-exit-if-changed .`)
- Static code analysis (`flutter analyze`)
- Test execution with coverage (`flutter test --coverage`)
- Coverage upload to Codecov

**2. Build Android Job**

- Builds Android APK (`flutter build apk --release`)
- Builds Android App Bundle (`flutter build appbundle --release`)
- Uploads APK and AAB artifacts (30-day retention)

**3. Build iOS Job**

- Builds iOS app (`flutter build ios --release --no-codesign`)
- Uploads iOS build artifact (30-day retention)

#### Release Pipeline

The release workflow automatically:

- **Builds Artifacts**

  - Android APK
  - Android App Bundle (AAB)
  - Web build

- **Creates GitHub Release**
  - Extracts version from tag
  - Attaches APK and AAB files
  - Generates release notes automatically
  - Publishes as non-draft, non-prerelease

### Workflow Configuration Details

#### CI Workflow Triggers

```yaml
on:
  push:
    branches: [master, main, develop]
  pull_request:
    branches: [master, main, develop]
```

#### Release Workflow Triggers

```yaml
on:
  push:
    tags:
      - "v*.*.*"
```

### Viewing CI/CD Status

- **GitHub Actions Tab**: View all workflow runs, logs, and artifacts
- **Pull Requests**: See CI status directly on PRs
- **Releases Page**: View release artifacts and notes
- **Codecov**: Monitor test coverage trends

### Creating a Release

To trigger a release:

```bash
# Create and push a version tag
git tag v1.0.0
git push origin v1.0.0
```

The release workflow will automatically:

1. Build all platform artifacts
2. Create a GitHub release
3. Attach APK and AAB files
4. Generate release notes

### CI/CD Best Practices

The current setup follows these practices:

1. **Automated Testing**

   - Tests run on every push and PR
   - Coverage tracking with Codecov
   - Formatting validation prevents unformatted code

2. **Build Verification**

   - Multi-platform builds (Android, iOS)
   - Artifact retention for 30 days
   - Build failures block merges

3. **Release Automation**
   - Semantic versioning via tags
   - Automatic release note generation
   - Artifact attachment for distribution

### Local CI/CD Testing

To test workflows locally before pushing:

```bash
# Install act (GitHub Actions local runner)
brew install act  # macOS

# Run CI workflow locally
act push

# Run specific job
act -j test
```

## 💻 Development

### Code Generation

Generate asset references:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch for changes:

```bash
dart run build_runner watch
```

### Code Quality

Format code:

```bash
dart format .
```

Fix linting issues:

```bash
dart fix --apply
```

Remove unused imports:

```bash
dart fix --apply --code=unused_import
```

### Running Tests

Run all tests:

```bash
flutter test
```

Run with coverage:

```bash
flutter test --coverage
```

### Building

Build APK:

```bash
flutter build apk
```

Build iOS:

```bash
flutter build ios
```

## 📝 License

This project is private and proprietary.

## 👥 Contributors

- IniOluwa Longe - Mobile Engineer (Flutter)

---

**Note**: This project follows DRY (Don't Repeat Yourself) and KISS (Keep It Simple, Stupid) principles, with reusable components and utilities throughout the codebase.
