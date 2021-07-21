import 'package:flutter/material.dart';
import 'package:transloadit_recipes/utils/food_list.dart';

import 'package:transloadit_recipes/utils/notifications.dart';
import 'package:transloadit_recipes/utils/transloadit.dart';
import 'package:transloadit_recipes/widgets/food_bottom_app_bar.dart';
import 'package:transloadit_recipes/widgets/food_card.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/res/colors.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Notifications.listenForNotification(context);
    super.initState();
  }

  updateFoodList(Food food) {
    setState(() {
      FoodList.updateFoodList(food);
    });
  }

  onCompleteUpload() {
    setState(() {
      isLoading.value = false;
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
        child: ListView.builder(
          itemCount: foods.length,
          itemBuilder: (BuildContext context, int index) {
            return FoodCard(
              recipe: foods[index],
              onSelectedRecipe: updateFoodList,
            );
          },
        ),
      ),
      bottomNavigationBar: FoodBottomAppBar(
        recipeLength: FoodList.foodList.length,
        resultLength: results.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (BuildContext context, bool value, Widget? child) {
          return value
              ? FloatingActionButton.extended(
                  onPressed: () {},
                  isExtended: true,
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CircularProgressIndicator(color: CustomColors.peach),
                  ),
                  label: Text('COOKING'),
                )
              : FloatingActionButton.extended(
                  onPressed: () {
                    setState(
                      () {
                        results.clear();
                        Transloadit.sendToTransloadit(
                          foodList: FoodList.foodList,
                          onCompleteUpload: onCompleteUpload,
                        );
                      },
                    );
                  },
                  isExtended: true,
                  label: Text('COOK'),
                  icon: Icon(Icons.microwave),
                );
        },
      ),
    );
  }
}
