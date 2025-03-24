# space_track

A package tracking application for logistics management.

## Getting Started

create env files with below format in lib/env directory named .env (for production) .env.dev (for development), .env.staging (for staging) -

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



[APK Download Link DEV](https://drive.google.com/file/d/19BuWKpTBodjGYPhDX9s0dVuYpxSzkKN-/view?usp=drive_link)
[APK Download Link Staging](https://drive.google.com/file/d/1IUy1rZbSacj9DJd6xYAyDNFX9eczq4Ft/view?usp=drive_link)
[APK Download Link Prod](https://drive.google.com/file/d/1VqcOMP3VcbCRKAcXDXnifcdMU3kyUDOi/view?usp=drive_link)


# Libraries Used in this project:

## Scandit Libraries
1. [Scandit Flutter Data Capture Barcode](https://pub.dev/packages/scandit_flutter_datacapture_barcode)
2. [Scandit flutter data capture parser](https://pub.dev/packages/scandit_flutter_datacapture_parser)
3. [Scandit Flutter Data Capture Core](https://pub.dev/packages/scandit_flutter_datacapture_core)

## For Local Database
4. [Hive](https://pub.dev/packages/hive)
5. [Hive Flutter](https://pub.dev/packages/hive_flutter)

## For State Management
6. [Get](https://pub.dev/packages/get)

## For Image Picker and Image Processing
7. [Image Picker](https://pub.dev/packages/image_picker)
8. [Path Provider](https://pub.dev/packages/path_provider)
9. [Permission Handler](https://pub.dev/packages/permission_handler)

## For Creating Unique ID
10. [UUID](https://pub.dev/packages/uuid)

## For Decorating with Dotted Border
11. [Dotted Border](https://pub.dev/packages/dotted_border)

## For Date Formatting
12. [Intl](https://pub.dev/packages/intl)

## For Environment Variables
13. [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
