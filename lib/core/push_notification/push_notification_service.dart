import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:soulhealer/core/logger/log.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future init() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showNotification(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    return await _fcm.getToken();
  }

  Future subscribe(String topic) async {
    _fcm.subscribeToTopic(topic);
    Log.debug("PNS ", "$topic is subscribed");
    return await _fcm.getToken();
  }

  Future unSubscribe(String topic) async {
    _fcm.unsubscribeFromTopic(topic);
    return await _fcm.getToken();
  }

  void showNotification(message) async {
    var messageNotification = message['notification'];
    print('Show Notification $messageNotification');
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        print("Notification Selected Payload $payload");
      },
    );

    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid
          ? 'com.semproject.soulhealer'
          : 'com.semproject.soulhealer',
      'soulhealerChannel',
      'soulhealerDescription',
      playSound: true,
      icon: "app_icon",
      channelShowBadge: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
      color: Colors.orangeAccent,
    );

    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    try {
      await FlutterLocalNotificationsPlugin().show(
        0,
        messageNotification['title'].toString(),
        messageNotification['body'].toString(),
        platformChannelSpecifics,
        payload: json.encode(messageNotification),
      );
    } catch (e) {
      print(e);
    }
  }
}
