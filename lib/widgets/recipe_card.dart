import 'package:flutter/material.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({
    Key? key,
    required this.cardTitle,
    required this.cardSubtitle,
    required this.cardImage,
    required this.cardDescription,
    required this.onPressed,
  }) : super(key: key);

  final String cardTitle;
  final String cardSubtitle;
  final String cardImage;
  final String cardDescription;
  final Function onPressed;

  @override
  _RecipeCardState createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
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
                widget.cardTitle,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                widget.cardSubtitle,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.cardImage),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            ListTile(
              subtitle: Text(
                widget.cardDescription,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  child: Text(
                    !isSelected ? 'SELECT' : 'DESELECT',
                  ),
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: () {
                    widget.onPressed();
                    setState(() {
                      isSelected = !isSelected;
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
