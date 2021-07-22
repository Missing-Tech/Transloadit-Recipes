import 'package:flutter/material.dart';
import 'rounded_square_avatar.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    Key? key,
    this.image,
    required this.name,
  }) : super(key: key);

  final String? image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: image == null
          ? SizedBox(
              height: 55,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            )
          : ListTile(
              leading: RoundedSquareAvatar(image: image),
              title: Text(
                name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
    );
  }
}
