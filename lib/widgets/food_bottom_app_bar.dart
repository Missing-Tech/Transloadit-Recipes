import 'package:flutter/material.dart';
import 'package:transloadit_recipes/main.dart';
import 'package:transloadit_recipes/res/colors.dart';

import 'notification_dot.dart';
import 'shopping_cart.dart';

class FoodBottomAppBar extends StatefulWidget {
  const FoodBottomAppBar({
    Key? key,
    required this.recipeLength,
  }) : super(key: key);

  final int recipeLength;

  @override
  _FoodBottomAppBarState createState() => _FoodBottomAppBarState();
}

class _FoodBottomAppBarState extends State<FoodBottomAppBar> {
  bool showingBottomSheet = false;

  toggleBottomSheet() {
    showingBottomSheet = false;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  showingBottomSheet
                      ? toggleBottomSheet()
                      : controller = showBottomSheet(
                          context: context,
                          builder: (context) {
                            showingBottomSheet = true;
                            return ShoppingCart(
                              foodList: foodList,
                            );
                          },
                        );
                },
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: Theme.of(context).accentColor,
                ),
              ),
              widget.recipeLength > 0
                  ? NotficationDot(recipeLength: widget.recipeLength)
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
