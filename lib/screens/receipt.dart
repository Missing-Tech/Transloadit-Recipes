import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transloadit_recipes/defs/response.dart';
import 'package:transloadit_recipes/widgets/receipt_card.dart';

import '../main.dart';

class ReceiptPage extends StatefulWidget {
  ReceiptPage({Key? key, required this.results}) : super(key: key);

  final List<Response> results;

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.results.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  return index == 0
                      ? Column(
                          children: [ReceiptHeader(), ReceiptDivider()],
                        )
                      : Column(
                          children: [
                            ReceiptCard(
                              result: results[index - 1],
                            ),
                            ReceiptDivider()
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(height: 50),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            Navigator.of(context).pop();
          });
        },
        isExtended: true,
        label: Text('CLOSE'),
        icon: Icon(Icons.close),
      ),
    );
  }
}

class ReceiptHeader extends StatelessWidget {
  const ReceiptHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
      child: Column(
        children: [
          Text(
            'TRANSLOADIT RECIPES',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            DateFormat('dd/MM/yy').format(DateTime.now()),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

class ReceiptDivider extends StatelessWidget {
  const ReceiptDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
        child: Text(
          '******************************',
          style: TextStyle(fontSize: 24, letterSpacing: 0.15),
        ),
      ),
    );
  }
}
