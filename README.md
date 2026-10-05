# Weather App

A Flutter weather application using the [OpenWeatherMap](https://openweathermap.org/) API to retrieve weather data.

## Requirements

Before running the project, make sure you have:
* Flutter SDK
* Dart SDK
* Xcode (for iOS)
* CocoaPods (for iOS)
* Android Studio (for Android, if needed)

Check your Flutter installation:

```bash
flutter doctor
```

## Getting Started
```bash
git clone <repository-url>

cd weather_app

flutter pub get
flutter pub upgrade
flutter doctor
flutter run
```

## If the Project Has Build Problems
Try cleaning the project and reinstalling dependencies:

```bash
flutter clean
flutter pub get
flutter run
```

## Note
This is an older Flutter project. Some dependencies may require a compatible Flutter/Dart SDK version. If the project fails to build after cloning, check the dependency versions in `pubspec.yaml` and the Flutter/Dart version used by the project.
