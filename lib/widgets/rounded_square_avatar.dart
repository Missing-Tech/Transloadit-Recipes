import 'package:flutter/material.dart';

class RoundedSquareAvatar extends StatelessWidget {
  const RoundedSquareAvatar({Key? key, this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return image != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image!),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ))
        : SizedBox();
  }
}
