class Food {
  Food({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.image,
    required this.ingredients,
  });

  final String title;
  final String subtitle;
  final String description;
  final String image;
  final Map<dynamic, dynamic> ingredients;
}
