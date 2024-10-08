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
    apiKey: 'AIzaSyDM7s2wKxnGjTwDA8kJKul3q_3etMCA5ME',
    appId: '1:863346653780:web:8f8db93a8b2843d6550bc1',
    messagingSenderId: '863346653780',
    projectId: 'empoverty',
    authDomain: 'empoverty.firebaseapp.com',
    storageBucket: 'empoverty.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC0bQjgBlyF6Of8SEXZtBUaPZS0vQVv8eY',
    appId: '1:863346653780:android:a4a50c3bb2f240a8550bc1',
    messagingSenderId: '863346653780',
    projectId: 'empoverty',
    storageBucket: 'empoverty.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk38o9HNwKQCs1drPTL2-wTWZgadLEN64',
    appId: '1:863346653780:ios:9525724643d3408a550bc1',
    messagingSenderId: '863346653780',
    projectId: 'empoverty',
    storageBucket: 'empoverty.appspot.com',
    iosBundleId: 'com.empoverty.empoverty',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBk38o9HNwKQCs1drPTL2-wTWZgadLEN64',
    appId: '1:863346653780:ios:31f8d240d2b50352550bc1',
    messagingSenderId: '863346653780',
    projectId: 'empoverty',
    storageBucket: 'empoverty.appspot.com',
    iosBundleId: 'com.empoverty.empoverty.RunnerTests',
  );
}
