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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDAXBc_CJlpk2NWjqMeB_DOnTCl9VJknOY',
    appId: '1:907477777625:web:25abdf6d1241db491c92c8',
    messagingSenderId: '907477777625',
    projectId: 'ampirialproject',
    authDomain: 'ampirialproject.firebaseapp.com',
    storageBucket: 'ampirialproject.appspot.com',
    measurementId: 'G-5J7WS6EVNG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwSGxHcwywO6oWRTgGN7WaDGlz_UigIlU',
    appId: '1:907477777625:android:0d73f2f239bfa9381c92c8',
    messagingSenderId: '907477777625',
    projectId: 'ampirialproject',
    storageBucket: 'ampirialproject.appspot.com',
  );
}
