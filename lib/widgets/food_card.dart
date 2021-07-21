import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/food.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({
    Key? key,
    required this.recipe,
    required this.onSelectedRecipe,
  }) : super(key: key);

  final Food recipe;
  final Function(Food recipe) onSelectedRecipe;

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.recipe.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                widget.recipe.subtitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.recipe.image),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            ListTile(
              subtitle: Text(
                widget.recipe.description,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton.icon(
                  label: Text(
                    !isSelected ? 'SELECT' : 'DESELECT',
                  ),
                  icon: isSelected
                      ? Icon(Icons.radio_button_on)
                      : Icon(Icons.radio_button_off),
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    setState(() {
                      isSelected = !isSelected;
                      widget.onSelectedRecipe(widget.recipe);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
