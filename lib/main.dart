import 'package:flutter/material.dart';
import 'package:transloadit_recipes/res/colors.dart';
import 'package:transloadit_recipes/res/theme.dart';

import 'widgets/recipe_card.dart';
import 'package:transloadit/transloadit.dart';

TransloaditClient client = TransloaditClient(
    authKey: '72a70fba93ce41cba617cfd7c2a44b1a',
    authSecret: '3b2845e9330051ed3adc06b4217c42e4f504f8f3');

Map<String, dynamic> salad = {};
Map<String, dynamic> beef = {};
Map<String, dynamic> lamb = {};

List<Map<String, dynamic>> recipe = [];

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            RecipeCard(
              cardTitle: 'Watermarked Salad',
              cardSubtitle: '/image/resize',
              cardImage: 'assets/images/salad.jpg',
              cardDescription:
                  'Fresh salad, delicately watermarked by our /image/resize Robot.',
              onPressed: () {
                setState(() {
                  recipe.contains(salad)
                      ? recipe.remove(salad)
                      : recipe.add(salad);
                });
              },
            ),
            RecipeCard(
              cardTitle: 'No Background Beef',
              cardSubtitle: '/image/resize',
              cardImage: 'assets/images/beef.jpg',
              cardDescription:
                  'A tender cut of no background beef, optimized to be delicious.',
              onPressed: () {
                setState(() {
                  recipe.contains(beef)
                      ? recipe.remove(beef)
                      : recipe.add(beef);
                });
              },
            ),
            RecipeCard(
              cardTitle: 'Lamb Crop',
              cardSubtitle: '/image/resize',
              cardImage: 'assets/images/lamb.jpg',
              cardDescription:
                  'Carefully marinated in a mixture of parameters and JSON, our lamb crop.',
              onPressed: () {
                setState(() {
                  recipe.contains(lamb)
                      ? recipe.remove(lamb)
                      : recipe.add(lamb);
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: new Container(
                    padding: EdgeInsets.all(2),
                    decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${recipe.length}',
                      style: TextStyle(
                        color: CustomColors.peach,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        notchMargin: 5,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        isExtended: true,
        label: Text('COOK'),
        icon: Icon(Icons.microwave),
      ),
    );
  }
}
