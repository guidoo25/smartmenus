// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCfd5aKIiHzViZypd8iXSOt4SeLPz3NFtM',
    appId: '1:526668543292:web:6b6506baed89bc5b7f1a39',
    messagingSenderId: '526668543292',
    projectId: 'smart-menu-9387c',
    authDomain: 'smart-menu-9387c.firebaseapp.com',
    storageBucket: 'smart-menu-9387c.firebasestorage.app',
    measurementId: 'G-HQETHHGGZ1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2kVLZPDzH1awbo5ilhaCM08OH5ZfihMM',
    appId: '1:526668543292:android:2da312bde188cc1f7f1a39',
    messagingSenderId: '526668543292',
    projectId: 'smart-menu-9387c',
    storageBucket: 'smart-menu-9387c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDMYi-ZiVv5Plh0QBscv9EcGp7opSgJen0',
    appId: '1:526668543292:ios:e8ee8a54c5a32a657f1a39',
    messagingSenderId: '526668543292',
    projectId: 'smart-menu-9387c',
    storageBucket: 'smart-menu-9387c.firebasestorage.app',
    iosBundleId: 'com.example.smartmenu',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDMYi-ZiVv5Plh0QBscv9EcGp7opSgJen0',
    appId: '1:526668543292:ios:e8ee8a54c5a32a657f1a39',
    messagingSenderId: '526668543292',
    projectId: 'smart-menu-9387c',
    storageBucket: 'smart-menu-9387c.firebasestorage.app',
    iosBundleId: 'com.example.smartmenu',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfd5aKIiHzViZypd8iXSOt4SeLPz3NFtM',
    appId: '1:526668543292:web:5171fcb710fe74477f1a39',
    messagingSenderId: '526668543292',
    projectId: 'smart-menu-9387c',
    authDomain: 'smart-menu-9387c.firebaseapp.com',
    storageBucket: 'smart-menu-9387c.firebasestorage.app',
    measurementId: 'G-T73QP3LS3D',
  );
}
