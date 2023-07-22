// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB52R_I39iFrBHOEfrMbsQUR4luiQ0jJPY',
    appId: '1:672029956433:web:cc88ccd2e4ddfb3de59b70',
    messagingSenderId: '672029956433',
    projectId: 'e-comm-8bcfc',
    authDomain: 'e-comm-8bcfc.firebaseapp.com',
    storageBucket: 'e-comm-8bcfc.appspot.com',
    measurementId: 'G-3SSSKRB74E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCoxS9wSyHsxTbeHghFEpqGbwgIIgtvY0c',
    appId: '1:672029956433:android:f99bd374f764376ee59b70',
    messagingSenderId: '672029956433',
    projectId: 'e-comm-8bcfc',
    storageBucket: 'e-comm-8bcfc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5rluKzM7ovLlxrlcIBwPCB011FJ5n9a8',
    appId: '1:672029956433:ios:4f03d8dc57219624e59b70',
    messagingSenderId: '672029956433',
    projectId: 'e-comm-8bcfc',
    storageBucket: 'e-comm-8bcfc.appspot.com',
    iosBundleId: 'com.example.firebaseEcom',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5rluKzM7ovLlxrlcIBwPCB011FJ5n9a8',
    appId: '1:672029956433:ios:4f03d8dc57219624e59b70',
    messagingSenderId: '672029956433',
    projectId: 'e-comm-8bcfc',
    storageBucket: 'e-comm-8bcfc.appspot.com',
    iosBundleId: 'com.example.firebaseEcom',
  );
}
