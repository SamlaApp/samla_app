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
    apiKey: 'AIzaSyC_2iwieCljqmYptZyGeSKge4LElPnffN0',
    appId: '1:589598708972:web:f6ff5c40a52a030f8841c9',
    messagingSenderId: '589598708972',
    projectId: 'samla-ceab0',
    authDomain: 'samla-ceab0.firebaseapp.com',
    storageBucket: 'samla-ceab0.appspot.com',
    measurementId: 'G-681ZRB8K60',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP-gaY-MIwRaCTrW5IARVUYJWxpB4Oq30',
    appId: '1:589598708972:android:0604fc4958f35b5d8841c9',
    messagingSenderId: '589598708972',
    projectId: 'samla-ceab0',
    storageBucket: 'samla-ceab0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3Mhn3eHv-m8GpOLtBuJ884F26er0VlVU',
    appId: '1:589598708972:ios:79e04461b229b5a38841c9',
    messagingSenderId: '589598708972',
    projectId: 'samla-ceab0',
    storageBucket: 'samla-ceab0.appspot.com',
    iosClientId: '589598708972-tt8hlchv185vp69gg7daut4tro4pgrqm.apps.googleusercontent.com',
    iosBundleId: 'com.example.samlaApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3Mhn3eHv-m8GpOLtBuJ884F26er0VlVU',
    appId: '1:589598708972:ios:27eca60fe4534c3b8841c9',
    messagingSenderId: '589598708972',
    projectId: 'samla-ceab0',
    storageBucket: 'samla-ceab0.appspot.com',
    iosBundleId: 'com.example.samlaApp.RunnerTests',
  );
}
