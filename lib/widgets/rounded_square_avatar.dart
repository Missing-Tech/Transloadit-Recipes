import 'package:flutter/material.dart';

class RoundedSquareAvatar extends StatelessWidget {
  const RoundedSquareAvatar({Key? key, this.image}) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    // return image != null
    //     ? ClipPath(
    //         clipper: MyCustomClipper(),
    //         child: Container(
    //           height: 50,
    //           width: 50,
    //           decoration: BoxDecoration(
    //             image: DecorationImage(
    //               image: AssetImage(image!),
    //               fit: BoxFit.fitHeight,
    //             ),
    //           ),
    //         ),
    //       )
    //     : SizedBox();
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
            ),
          )
        : SizedBox();
  }
}

// class MyCustomClipper extends CustomClipper<Path> {
//   final double radius = 10;

//   @override
//   Path getClip(Size size) {
//     Path path = Path()
//       ..lineTo(0, size.height - radius)
//       ..lineTo(radius, size.height)
//       ..lineTo(size.width - radius, size.height)
//       ..lineTo(size.width, size.height - radius)
//       ..lineTo(size.width, radius)
//       ..lineTo(size.width - radius, 0)
//       ..lineTo(radius, 0)
//       ..lineTo(0, radius)
//       ..close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
