class CartItemModel {
  late String title;
  late String id;
  late String docId;
  late double price;
  late String imageUrl;
  late   int quantity;

  CartItemModel(
      {required this.title,
      required this.price,
      required this.docId,
      required this.imageUrl,
      required this.quantity,
      required this.id});
  CartItemModel.fromJson(Map<String,dynamic>json){
    title=json['title'];
    price=json['price'];
    docId=json['docId'];
    imageUrl=json['imageUrl'];
    quantity=json['quantity'];
    id=json['id'];
  }
  Map<String,dynamic>toMap(){
    return {
      'title':title,
      'price':price,
      'docId':docId,
      'imageUrl':imageUrl,
      'quantity':quantity,
      'id':id,

    };
  }

}
