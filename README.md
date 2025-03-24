# space_track

A package tracking application for logistics management.

## Getting Started

create a env file with below format in lib/env directory named .env -

    SCANDIT_LICENSE_KEY=your_license_key


Developed with -

    Flutter SDK - 3.24.4
    
    Dart SDk - 3.5.4


The app has three environments -
    
    Development
    Staging
    Production

To run app with a specific environment, use - 

    # Development
    flutter run --flavor dev -t lib/main_dev.dart

    # Staging
    flutter run --flavor staging -t lib/main_staging.dart

    # Production
    flutter run --flavor prod -t lib/main_prod.dart

For building:

    # Development build
    flutter build apk --flavor dev -t lib/main_dev.dart
    flutter build ios --flavor dev -t lib/main_dev.dart

    # Staging build
    flutter build apk --flavor staging -t lib/main_staging.dart
    flutter build ios --flavor staging -t lib/main_staging.dart

    # Production build
    flutter build apk --flavor prod -t lib/main_prod.dart
    flutter build ios --flavor prod -t lib/main_prod.dart



[APK Download Link](https://drive.google.com/file/d/1noffQgQnWJJ2kWn2nAQ1CxWLsGYUXuFj/view?usp=sharing)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
