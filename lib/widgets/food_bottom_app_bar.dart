import 'package:flutter/material.dart';
import 'package:transloadit_recipes/main.dart';
import 'package:transloadit_recipes/res/colors.dart';
import 'package:transloadit_recipes/utils/food_list.dart';

import 'notification_dot.dart';
import 'shopping_cart_drawer.dart';
import 'snackbar.dart';

class FoodBottomAppBar extends StatefulWidget {
  const FoodBottomAppBar({
    Key? key,
    required this.recipeLength,
    required this.resultLength,
  }) : super(key: key);

  final int recipeLength;
  final int resultLength;

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      results.length > 0
                          ? Navigator.pushNamed(context, '/receipt')
                          : showRecipeSnackBar(
                              context,
                              text: 'No receipts yet!',
                            );
                    },
                  );
                },
                icon: Icon(
                  Icons.receipt_long,
                  color: Theme.of(context).accentColor,
                ),
              ),
              widget.resultLength > 0
                  ? NotficationDot(recipeLength: widget.resultLength)
                  : SizedBox(),
            ],
          ),
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
                              foodList: FoodList.foodList,
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
