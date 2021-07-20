import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transloadit/transloadit.dart';
import 'package:path_provider/path_provider.dart';

import 'package:transloadit_recipes/widgets/food_bottom_app_bar.dart';
import 'package:transloadit_recipes/widgets/food_card.dart';
import 'package:transloadit_recipes/defs/food.dart';
import 'package:transloadit_recipes/defs/response.dart';
import 'package:transloadit_recipes/res/colors.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  updateFoodList(Food food) {
    setState(() {
      foodList.contains(food) ? foodList.remove(food) : foodList.add(food);
      if (controller != null) {
        controller!.setState!(() {});
      }
    });
  }

  Future<File> imageToFile({required String path, required String name}) async {
    var bytes = await rootBundle.load(path);
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/$name.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  Future<void> sendToTransloadit(Food food) async {
    setState(() {
      isLoading = true;
    });

    TransloaditAssembly assembly = client.newAssembly(params: {
      'notify_url':
          'https://us-central1-transloadit-recipes.cloudfunctions.net/receivePOST?token=$token'
    });
    assembly.addFile(
        file: await imageToFile(path: food.image, name: food.title));
    assembly.addStep(
        food.title, food.subtitle, Map<String, dynamic>.from(food.ingredients));

    Future<TransloaditResponse> future = assembly.createAssembly();
    TransloaditResponse response = await future;
    results.add(Response(response: response.data, name: food.title));

    setState(() {
      isLoading = false;
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
        recipeLength: foodList.length,
        resultLength: results.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isLoading
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
                setState(() {
                  results.clear();
                  foodList.forEach((element) {
                    sendToTransloadit(element);
                  });
                });
              },
              isExtended: true,
              label: Text('COOK'),
              icon: Icon(Icons.microwave),
            ),
    );
  }
}
