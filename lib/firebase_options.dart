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
    apiKey: 'AIzaSyAKK6UbqxnfuJE76UgwisNeq-7urqBgF6c',
    appId: '1:718136613879:web:0b8b91ee1ff2d1b5256cf2',
    messagingSenderId: '718136613879',
    projectId: 'blog-app-2fe30',
    authDomain: 'blog-app-2fe30.firebaseapp.com',
    storageBucket: 'blog-app-2fe30.appspot.com',
    measurementId: 'G-1FGNENWSLH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLZzJacerI-zikUYFTCcwFCMjy1PiRqoM',
    appId: '1:718136613879:android:49da61f751507480256cf2',
    messagingSenderId: '718136613879',
    projectId: 'blog-app-2fe30',
    storageBucket: 'blog-app-2fe30.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDmnnt9ueN-d_-SME9ytMir-MuG6EB_E0c',
    appId: '1:718136613879:ios:325e450f42008577256cf2',
    messagingSenderId: '718136613879',
    projectId: 'blog-app-2fe30',
    storageBucket: 'blog-app-2fe30.appspot.com',
    iosBundleId: 'com.example.blogApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDmnnt9ueN-d_-SME9ytMir-MuG6EB_E0c',
    appId: '1:718136613879:ios:325e450f42008577256cf2',
    messagingSenderId: '718136613879',
    projectId: 'blog-app-2fe30',
    storageBucket: 'blog-app-2fe30.appspot.com',
    iosBundleId: 'com.example.blogApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKK6UbqxnfuJE76UgwisNeq-7urqBgF6c',
    appId: '1:718136613879:web:d26e5555ceea05f1256cf2',
    messagingSenderId: '718136613879',
    projectId: 'blog-app-2fe30',
    authDomain: 'blog-app-2fe30.firebaseapp.com',
    storageBucket: 'blog-app-2fe30.appspot.com',
    measurementId: 'G-N5264BQ6PH',
  );
}
