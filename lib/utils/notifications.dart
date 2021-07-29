import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class Notifications {
  static Future<void> initializeNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.getToken().then((t) {
      token = t!;
    });
  }

  static Future<void> listenForNotification(BuildContext context) async {
    // Received a notification while app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      navigateToScreen(context, message);
      showNotification(message);
    });

    // Opened a notification while app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      navigateToScreen(context, message);
    });
  }

  static navigateToScreen(BuildContext context, RemoteMessage message) {
    Navigator.pushNamed(context, '${message.data["screen"]}');
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'Food Notification Channel', // title
      'This channel is used for telling you when your food is done.', // description
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            importance: channel.importance,
          ),
        ),
      );
    }
  }
}
