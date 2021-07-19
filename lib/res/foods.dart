import '../defs/food.dart';

class Foods {
  static Food salad = Food(
    title: 'Watermarked Salad',
    subtitle: '/image/resize',
    image: 'assets/images/salad.jpg',
    description:
        'Fresh salad, delicately watermarked by our /image/resize Robot.',
    ingredients: {
      "use": ":original",
      "robot": "/image/resize",
      "result": true,
      "format": "jpg",
      "watermark_url":
          "https://demos.transloadit.com/inputs/transloadit-padded.png",
      "watermark_size": "50%",
      "watermark_position": "center",
      "imagemagick_stack": "v2.0.7"
    },
  );

  static Food beef = Food(
    title: 'No Background Beef',
    subtitle: '/image/resize',
    image: 'assets/images/beef.png',
    description:
        'A tender cut of no background beef, optimized to be delicious.',
    ingredients: {
      "use": ":original",
      "robot": "/image/resize",
      "format": "png",
      "alpha": "Transparent",
      "type": "TrueColor",
      "result": true,
      "transparent": "51,51,51",
      "imagemagick_stack": "v2.0.7"
    },
  );

  static Food lamb = Food(
    title: 'Lamb Crop',
    subtitle: '/image/resize',
    image: 'assets/images/lamb.jpg',
    description:
        'Carefully marinated in a mixture of parameters and JSON, our lamb crop.',
    ingredients: {
      "use": ":original",
      "robot": "/image/resize",
      "result": true,
      "width": 1500,
      "height": 500,
      "resize_strategy": "fillcrop",
      "imagemagick_stack": "v2.0.7"
    },
  );
}
