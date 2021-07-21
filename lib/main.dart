import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:transloadit/transloadit.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/res/foods.dart';
import 'package:transloadit_recipes/screens/receipt.dart';

import 'defs/response.dart';
import 'res/theme.dart';
import 'screens/home_page.dart';

List<Food> foodList = [];
List<Food> foods = [Foods.salad, Foods.beef, Foods.lamb];
List<Response> results = [];
bool isLoading = false;
PersistentBottomSheetController? controller;
late TransloaditClient client;
late String token;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await initializeSecrets();

  initializeNotifications();

  runApp(MyApp());
}

Future<void> initializeSecrets() async {
  //Handle Secrets
  RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.fetchAndActivate();

  String key = remoteConfig.getValue('key').asString();
  String secret = remoteConfig.getValue('secret').asString();
  client = TransloaditClient(authKey: key, authSecret: secret);
}

Future<void> initializeNotifications() async {
  //Handle push notifications
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((t) {
    token = t!;
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transloadit Recipes',
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
              title: 'Transloadit Recipes',
            ),
        '/receipt': (context) => ReceiptPage(
              results: results,
            ),
      },
      navigatorKey: navigatorKey,
    );
  }
}
