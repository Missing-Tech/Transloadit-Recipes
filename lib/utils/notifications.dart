import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static Future<void> listenForNotification(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      showNotification(message);
      Navigator.pushNamed(context, '${message.data["screen"]}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Navigator.pushNamed(context, '${message.data["screen"]}');
    });
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
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
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

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        12345,
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
