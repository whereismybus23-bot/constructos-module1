// File generated manually for ConstructOS
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError('Firebase is not configured for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC9J2wULtvBm_L-9km98qdbx2Ok_rXiawk',
    appId: '1:849976822411:web:c48e008f0dbaccdd44228e',
    messagingSenderId: '849976822411',
    projectId: 'constructos-23',
    authDomain: 'constructos-23.firebaseapp.com',
    storageBucket: 'constructos-23.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVMsCvd2IybLdZbX5B-ASQNQnr5e4tNPo',
    appId: '1:849976822411:android:710963d1e58ae22444228e',
    messagingSenderId: '849976822411',
    projectId: 'constructos-23',
    storageBucket: 'constructos-23.firebasestorage.app',
  );
}
