class ProductModel {
  late String id;
  late String title;
  late String description;
  late String categoryName;
  late String imageUrl;
  late int quantity;
  late String brand;
  late String  docId;
  late double price;
  late bool inFavorite;
  late bool inPopular;

  // final late String publishDate;

  ProductModel({required this.id,

    required this.title,
    required  this.docId,
    // required this.publishDate,
    required this.imageUrl,
    required this.description,
    required this.quantity,
    required this.categoryName,
    required this.brand,
    required this.price,
    required this.inFavorite,
    required this.inPopular});


  ProductModel.fromJson(Map<String, dynamic>json)
  {
    id = json['id'];
    title = json['title'];
    docId = json['docId'];
    imageUrl = json['imageUrl'];
    description = json['description'];
    quantity = json['quantity'];
    categoryName = json['categoryName'];
    brand = json['brand'];
    price = json['price'];
    inFavorite = json['inFavorite'];
    inPopular = json['inPopular'];
  }
  Map<String,dynamic>toMap(){
    return{
    'id': id,
    'title': title,
    'imageUrl': imageUrl,
    'description': description,
    'quantity': quantity,
    'categoryName': categoryName,
    'brand': brand,
    'price':price,
    'docId':docId,
    'inFavorite': inFavorite,
    'inPopular': inPopular
    };
  }
}
