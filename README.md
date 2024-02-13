# EDUCA APP

Educa is an online learning platform built using Flutter and Firebase. This project aims to demonstrate Clean Architecture and the concept of Test-Driven Design.

## How to run this project

Clone this repository.

```
git clone git@github.com:fzl-22/educa-app.git
```

Get into the project directory.

```
cd educa-app
```

Install project's dependencies.

```
flutter pub get
```

Create a Firebase project on [https://console.firebase.google.com](https://console.firebase.google.com), and activate and configure Firebase Auth, Firebase Firestore, and Firebase Cloud Storage. Then, run this command to connect this app to newly created Firebase project.

```
flutterfire configure --project=<project-name> --platforms=android,ios
```

Make sure to turn on and connect to a physical device or an emulator, and execute this command to run the project.

```
flutter run
```

## How to build this project

To build this project as a release application, execute this following command.

```
flutter build apk --release
```

When the build completed, the release apk can be located at `build/app/outputs/flutter-apk/app-release.apk`.
