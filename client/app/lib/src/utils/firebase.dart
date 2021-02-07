import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise() async {
    print("Hello Again, Hoe's everything going?");
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    // If you want to test the push notification locally,
    // you need to get the token and input to the Firebase console
    // https://console.firebase.google.com/project/YOUR_PROJECT_ID/notification/compose
    print("threee");
    String token = await _fcm.getToken();
    print("fourrrrrr");
    print(
        "*************************************************FirebaseMessaging token: $token");

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        var notification;
        if (Platform.isAndroid) {
          notification = PushNotificationMessage(
            title: message['notification']['title'],
            body: message['notification']['body'],
          );
        } else if (Platform.isIOS) {
          notification = PushNotificationMessage(
            title: message['aps']['alert']['title'],
            body: message['aps']['alert']['body'],
          );
        }
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}

class PushNotificationMessage {
  final String title;
  final String body;
  PushNotificationMessage({
    @required this.title,
    @required this.body,
  });
}
