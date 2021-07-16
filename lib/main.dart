import 'dart:async';

import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/res/theme.dart';

import 'res/foods.dart';
import 'widgets/food_bottom_app_bar.dart';
import 'widgets/food_cart.dart';
import 'package:transloadit/transloadit.dart';

TransloaditClient client = TransloaditClient(
    authKey: '72a70fba93ce41cba617cfd7c2a44b1a',
    authSecret: '3b2845e9330051ed3adc06b4217c42e4f504f8f3');

List<Food> foodList = [];

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
      home: MyHomePage(
        title: 'Transloadit Recipes',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<_MyHomePageState> globalKey = GlobalKey<_MyHomePageState>();

  updateFoodList(Food food) {
    setState(() {
      foodList.contains(food) ? foodList.remove(food) : foodList.add(food);
      if (controller != null) {
        controller!.setState!(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: [
            FoodCard(
              recipe: Foods.salad,
              onSelectedRecipe: updateFoodList,
            ),
            FoodCard(
              recipe: Foods.beef,
              onSelectedRecipe: updateFoodList,
            ),
            FoodCard(
              recipe: Foods.lamb,
              onSelectedRecipe: updateFoodList,
            ),
          ],
        ),
      ),
      bottomNavigationBar: FoodBottomAppBar(
        recipeLength: foodList.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        isExtended: true,
        label: Text('COOK'),
        icon: Icon(Icons.microwave),
      ),
    );
  }
}
