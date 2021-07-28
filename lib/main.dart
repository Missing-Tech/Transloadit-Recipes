import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:transloadit/transloadit.dart';

import 'defs/food.dart';
import 'res/foods.dart';
import 'screens/receipt_page.dart';
import 'defs/response.dart';
import 'res/theme.dart';
import 'screens/home_page.dart';
import 'utils/notifications.dart';

List<Food> foods = [Foods.salad, Foods.beef, Foods.lamb];
ValueNotifier<List<Response>> results = ValueNotifier<List<Response>>([]);
ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
PersistentBottomSheetController? controller;
late TransloaditClient client;
late String token;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeSecrets();
  await Notifications.initializeNotifications();

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

class MyApp extends StatelessWidget {
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
              results: results.value,
            ),
      },
      navigatorKey: navigatorKey,
    );
  }
}
