import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/screens/receipt.dart';

import 'defs/response.dart';
import 'res/theme.dart';
import 'screens/home_page.dart';

List<Food> foodList = [];
List<Response> results = [];
bool isLoading = false;

PersistentBottomSheetController? controller;

void main() {
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
