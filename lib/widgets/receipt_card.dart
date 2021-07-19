import 'package:flutter/material.dart';
import 'package:transloadit_recipes/defs/response.dart';

class ReceiptCard extends StatefulWidget {
  const ReceiptCard({
    Key? key,
    required this.result,
  }) : super(key: key);

  final Response result;

  @override
  _ReceiptCardState createState() => _ReceiptCardState();
}

class _ReceiptCardState extends State<ReceiptCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final String mbCost = (widget.result.response['bytes_usage'] / 1000 / 1000)
        .toStringAsFixed(2);

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                widget.result.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.result.response['results']
                        [widget.result.name][0]['ssl_url']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            ListTile(
              subtitle: Text(
                "Cost: ${mbCost}MB",
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
