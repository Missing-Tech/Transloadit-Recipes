import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/food.dart';

import 'food_tile.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({
    Key? key,
    required this.foodList,
  }) : super(key: key);

  final List<Food> foodList;

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.foodList.length,
            itemBuilder: (context, i) {
              if (widget.foodList.length == 0) {
                return FoodTile(image: '', name: 'Nothing in your cart yet!');
              }
              return FoodTile(
                  image: widget.foodList[i].image,
                  name: widget.foodList[i].title);
            },
          ),
        ],
      ),
    );
  }
}
