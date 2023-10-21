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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyByrKUngDCnabK9IdatxwYkH6FYlWkfRRQ',
    appId: '1:493011606946:android:2cfbfd4dad57db19cb26fb',
    messagingSenderId: '493011606946',
    projectId: 'wowapp-b5ae5',
    storageBucket: 'wowapp-b5ae5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmTe3NNlEYXcinjH8L8N10MUTePAkDJ9I',
    appId: '1:493011606946:ios:c24ab3ee139ae4f0cb26fb',
    messagingSenderId: '493011606946',
    projectId: 'wowapp-b5ae5',
    storageBucket: 'wowapp-b5ae5.appspot.com',
    androidClientId: '493011606946-l3g55vnd712p4kblf5pb4qjmgma9d5ft.apps.googleusercontent.com',
    iosClientId: '493011606946-4p25defa7ji8p98bkn1f8t2dh636gae8.apps.googleusercontent.com',
    iosBundleId: 'com.wowapp.wowChatApp',
  );
}
