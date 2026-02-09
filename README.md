# User Management App

A Flutter application built for technical assessment, demonstrating **Clean Architecture**, **Cubit State Management**, and proper **API integration** with [Reqres.in](https://reqres.in).

## Features

### Authentication
- Email/password login with validation
- Required field validation
- Email format validation
- Loading state during API call
- Server error display

### User Listing
- Paginated user list (infinite scroll)
- Pull-to-refresh functionality
- Loading/error states with retry

### User Details
- View full user information
- Edit user data
- Update confirmation

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

### Networking
- **Dio** for HTTP requests
- Generic ApiService for GET/POST/PUT/DELETE
- Proper error handling

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
| flutter_screenutil | Responsive sizing |
| flutter_secure_storage | Secure storage |

## Screenshots

*Coming soon*

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/login` | POST | User login |
| `/api/users?page=n` | GET | Paginated users |
| `/api/users/{id}` | GET | User details |
| `/api/users/{id}` | PUT | Update user |

## Author

Built for technical assessment.
