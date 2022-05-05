

class WishListItemModel {
  late String title;
  late String docId;
  late String id;
 late double  price;
  late String imageUrl;

  WishListItemModel(
      {required this.title,
      required this.price,
      required this.imageUrl,
      required this.docId,
      required this.id});

  WishListItemModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    docId = json['docId'];
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'docId': docId,
      'imageUrl': imageUrl,
      'id': id,
    };
  }
}
