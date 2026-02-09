# User Management App

A Flutter application demonstrating **Clean Architecture**, **Cubit State Management**, and **API integration** with [Reqres.in](https://reqres.in).

## Features

### Authentication
- Email/password login with validation
- Secure token storage
- Auto-login on app restart
- Loading state during API calls
- Server error display

### User Listing
- Paginated user list (infinite scroll)
- Pull-to-refresh functionality
- Loading/error states with retry

### User Details
- View full user information
- Edit user data (name & job)
- Update confirmation with automatic UI refresh

### Localization
- English and Arabic language support
- Easy language switching

## Architecture

This project follows **Clean Architecture** with three layers per feature:

```
features/
├── auth/
│   ├── data/           # DataSource, Models, Repository Implementation
│   ├── domain/         # Entities, Abstract Repository, Use Cases
│   └── presentation/   # Cubit, Screens, Widgets
└── users/
    ├── data/
    ├── domain/
    └── presentation/
```

### State Management
- **Cubit** (flutter_bloc) for reactive state management
- Separate cubits for list and detail views
- Either pattern (dartz) for clean error handling

### Networking
- **Dio** for HTTP requests
- Generic ApiService for GET/POST/PUT/DELETE
- Centralized error handling with ApiErrorHandler

## Getting Started

### Prerequisites
- Flutter SDK 3.10+
- Dart SDK 3.0+

### Installation

```bash
# Clone the repository
git clone <repository-url>

# Navigate to project
cd waseelatask

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## Test Credentials

The app uses [Reqres.in](https://reqres.in) mock API:

| Email | Password |
|-------|----------|
| eve.holt@reqres.in | cityslicka |

## Project Structure

```
lib/
├── core/
│   ├── di/             # Dependency Injection (get_it)
│   ├── helpers/        # App Texts, Constants, Extensions
│   ├── networking/     # Dio, ApiService, Error Handling
│   ├── routing/        # App Routes
│   ├── theming/        # Colors, Styles
│   └── widgets/        # Shared Widgets
├── features/
│   ├── auth/           # Authentication Feature
│   └── users/          # Users Feature
└── main.dart
```

## Dependencies

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| get_it | Dependency injection |
| dio | HTTP client |
| dartz | Functional programming (Either) |
| flutter_screenutil | Responsive sizing |
| flutter_secure_storage | Secure token storage |
| easy_localization | Internationalization |

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/login` | POST | User login |
| `/api/users?page=n` | GET | Paginated users |
| `/api/users/{id}` | GET | User details |
| `/api/users/{id}` | PUT | Update user |
