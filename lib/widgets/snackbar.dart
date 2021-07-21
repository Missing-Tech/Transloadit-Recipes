import 'package:flutter/material.dart';
import 'package:transloadit_recipes/res/colors.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showRecipeSnackBar(
    BuildContext context,
    {required String text}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: CustomColors.peach),
      ),
      backgroundColor: CustomColors.brown,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    ),
  );
}
