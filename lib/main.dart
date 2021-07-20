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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //Handle Secrets
  RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.fetchAndActivate();

  String key = remoteConfig.getValue('key').asString();
  String secret = remoteConfig.getValue('secret').asString();
  client = TransloaditClient(authKey: key, authSecret: secret);

  //Handle push notifications
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.getToken().then((t) {
    token = t!;
  });

  runApp(MyApp());
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
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(title: 'Transloadit Recipes'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/receipt': (context) => ReceiptPage(
              results: results,
            ),
      },
    );
  }
}
