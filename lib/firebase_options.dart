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
    apiKey: 'AIzaSyBI8HIk1HhoeGLWGDHU0-JZ2DhfdmG0v-w',
    appId: '1:311325913216:web:298bc1a06dda2c2cbab665',
    messagingSenderId: '311325913216',
    projectId: 'goldline-79ccc',
    authDomain: 'goldline-79ccc.firebaseapp.com',
    storageBucket: 'goldline-79ccc.appspot.com',
    measurementId: 'G-VMW8VKH6Q9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANZT43ptN8jblMQE2qRC9UOn2R2W7pmGM',
    appId: '1:311325913216:android:92ad2c11ff72f737bab665',
    messagingSenderId: '311325913216',
    projectId: 'goldline-79ccc',
    storageBucket: 'goldline-79ccc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOhpilyrt0rMoju3li0HoUwecIz2bRG88',
    appId: '1:311325913216:ios:71f2ed204ee8ae2ebab665',
    messagingSenderId: '311325913216',
    projectId: 'goldline-79ccc',
    storageBucket: 'goldline-79ccc.appspot.com',
    iosClientId:
        '311325913216-nvtlanjpnk5l3sejbh5fbg01li9c7a95.apps.googleusercontent.com',
    iosBundleId: 'com.imotionnigeria.goldline',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOhpilyrt0rMoju3li0HoUwecIz2bRG88',
    appId: '1:311325913216:ios:71f2ed204ee8ae2ebab665',
    messagingSenderId: '311325913216',
    projectId: 'goldline-79ccc',
    storageBucket: 'goldline-79ccc.appspot.com',
    iosClientId:
        '311325913216-nvtlanjpnk5l3sejbh5fbg01li9c7a95.apps.googleusercontent.com',
    iosBundleId: 'com.imotionnigeria.goldline',
  );
}
