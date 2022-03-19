class ProductModel {
  final String id;
  final String title;
  final String description;
  final String categoryName;
  final String imageUrl;
  final int quantity;
  final String brand;
  final double price;
  final bool inFavorite;
  final bool inPopular;

  ProductModel(
      {required this.id,

        required this.title,
        required this.imageUrl,
        required this.description,
        required this.quantity,
      required this.categoryName,
      required this.brand,
      required this.price,
      required this.inFavorite,
      required this.inPopular});
}

