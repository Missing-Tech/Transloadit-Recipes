import 'package:flutter/material.dart';
import 'package:transloadit_recipes/res/colors.dart';

class NotficationDot extends StatefulWidget {
  const NotficationDot({Key? key, required this.recipeLength})
      : super(key: key);

  final int recipeLength;

  @override
  _NotficationDotState createState() => _NotficationDotState();
}

class _NotficationDotState extends State<NotficationDot> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 8,
      top: 8,
      child: new Container(
        padding: EdgeInsets.all(2),
        decoration: new BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(10)),
        constraints: BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          '${widget.recipeLength}',
          style: TextStyle(
            color: CustomColors.peach,
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
