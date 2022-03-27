class CartItemModel {
  final String title;
  final String id;
  final double price;
  final String imageUrl;
  final int quantity;

  CartItemModel(
      {required this.title,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.id});
}
