import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/defs/response.dart';
import 'package:transloadit_recipes/res/foods.dart';
import 'package:transloadit_recipes/widgets/food_bottom_app_bar.dart';
import 'package:transloadit_recipes/widgets/receipt_card.dart';

import '../main.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({Key? key, required this.results}) : super(key: key);

  final List<Response> results;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (BuildContext context, int index) {
                  return ReceiptCard(
                    result: results[index],
                  );
                },
              ),
              // child: ListView(
              //   children: [
              //     ReceiptHeader(),
              //     ReceiptDivider(),
              //     ReceiptCard(
              //       recipe: Foods.salad,
              //       onSelectedRecipe: updateFoodList,
              //     ),
              //     ReceiptDivider(),
              //     ReceiptCard(
              //       recipe: Foods.beef,
              //       onSelectedRecipe: updateFoodList,
              //     ),
              //     ReceiptDivider(),
              //     ReceiptCard(
              //       recipe: Foods.lamb,
              //       onSelectedRecipe: updateFoodList,
              //     ),
              //   ],
              // ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FoodBottomAppBar(
        recipeLength: foodList.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
          });
        },
        isExtended: true,
        label: Text('CLOSE'),
        icon: Icon(Icons.close),
      ),
    );
  }
}

class ReceiptHeader extends StatelessWidget {
  const ReceiptHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
        ),
        Text(
          'TRANSLOADIT RECIPES',
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          '19/07/2021',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class ReceiptDivider extends StatelessWidget {
  const ReceiptDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          '******************************',
          style: TextStyle(fontSize: 24, letterSpacing: 0.15),
        ),
      ),
    );
  }
}
