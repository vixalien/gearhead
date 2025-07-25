# GearHead

A Flutter social media app for car enthusiasts to connect, share their rides, and discover amazing automotive content.

## Features

- 🔐 **Firebase Authentication** - Secure user registration and login
- 📱 **Instagram-style Interface** - Modern and intuitive design
- 🚗 **Car-focused Content** - Share and discover automotive posts
- 👤 **User Profiles** - Personalized user experience
- 🎨 **Splash Screen** - Elegant onboarding experience
- 🔄 **Real-time Authentication** - Seamless login state management

## Screenshots

The app includes:
- Animated splash screen with app branding
- User authentication (signup/login/password reset)
- Social media feed for car enthusiasts
- User profile management
- Logout functionality

## Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code with Flutter extensions

### Firebase Setup

1. **Create a Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project or use existing one
   - Enable Authentication service

2. **Configure Authentication**
   - In Firebase Console, go to Authentication > Sign-in method
   - Enable "Email/Password" provider
   - Configure other providers as needed

3. **Add Firebase to your Flutter app**
   - Follow the [official Firebase setup guide](https://firebase.google.com/docs/flutter/setup)
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

### Running the App

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── services/
│   └── auth_service.dart    # Firebase Authentication service
├── screens/
│   ├── auth_wrapper.dart    # Authentication state handler
│   ├── splash_screen.dart   # Animated splash screen
│   ├── login.dart           # Login screen
│   ├── signup.dart          # Registration screen
│   ├── homepage.dart        # Main feed
│   ├── profile.dart         # User profile
│   └── forgot_password.dart # Password reset
└── components/
    ├── bottom_navigation.dart
    └── navigation_handler.dart
```

## Authentication Flow

1. **App Launch** → Splash Screen (if not authenticated)
2. **Splash Screen** → Login or Signup options
3. **Authentication** → Homepage (automatic redirect)
4. **Logout** → Back to Splash Screen

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^3.15.2
  firebase_auth: ^5.1.4
```

## Firebase Security Rules

Make sure to configure appropriate Firestore security rules for production:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Troubleshooting

### Firebase Authentication Issues

If you encounter authentication errors:

1. **Verify Firebase Configuration:**
   - Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are properly placed
   - Check that Firebase Authentication is enabled in your project

2. **Clean and Rebuild:**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

3. **Check Firebase Console:**
   - Go to Authentication → Sign-in method
   - Ensure Email/Password provider is enabled
   - If App Check is enabled, disable enforcement for development

### Common Issues

- **Build errors**: Run `flutter clean && flutter pub get`
- **Auth state not updating**: Check that AuthWrapper is properly configured
- **Navigation issues**: Ensure all routes are defined in main.dart
- **reCAPTCHA errors**: Disable App Check enforcement in Firebase Console

## Support

For support or questions, please open an issue in the GitHub repository.
