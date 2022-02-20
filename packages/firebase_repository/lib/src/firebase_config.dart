import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: '',
        authDomain: '',
        databaseURL: '',
        projectId: '',
        storageBucket: '',
        messagingSenderId: '',
        appId: '',
        measurementId: '',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        authDomain: '',
        iosBundleId: '',
        iosClientId:'',
        databaseURL: '',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:971858661197:android:4cac3182b035d448e0f104',
        apiKey: 'AIzaSyCacD0LOpaw2-8kJmZzuKSfBVJFejt4R-E',
        projectId: 'flutter-apps-4e523', messagingSenderId: ''
      );
    }
  }
}