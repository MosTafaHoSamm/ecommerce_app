
import 'package:ecommerceapplication/models/product_model.dart';
import 'package:flutter/foundation.dart';

class LayoutProvider with ChangeNotifier{
  List <ProductModel> products=[
    ProductModel(
        id: "طعام",
        title: "ليبتون شاي",
        imageUrl: "https://images-na.ssl-images-amazon.com/images/I/91vW5upayCL.__AC_SX300_SY300_QL70_ML2_.jpg",
        description: "ليبتون شاي اخضر كلاسيكي، 100 كيس شاي",
        quantity: 5,
        categoryName: "طعام",
        brand: "ليبتون",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "مكسرات",
        title: "مكسرات أبو عوف",
        imageUrl: "https://m.media-amazon.com/images/I/51VjYShK-0L._AC_.jpg",
        description: "مكسرات متعددة من ابو عوف، 200 غرام",
        quantity: 5,
        categoryName: "طعام",
        brand: "ابو عوف",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "أحذية",
        title: "أحذية رياضية",
        imageUrl: "https://m.media-amazon.com/images/I/31kAbTIftvL._AC_.jpg",
        description:
        "حذاء سنيكرز رياضي شمواه برباط بتصميم كاجوال بلونين، مقاس N12",
        quantity: 9,
        categoryName: "أحذية",
        brand: "جينيرك",
        price: 175.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "أحذية",
        title: "صندل شمواه",
        imageUrl: "https://m.media-amazon.com/images/I/41O4uxZv1ZL._AC_.jpg",
        description:
        "صندل شمواه صناعي فلات مزين بفصوص بشرائط متعددة",
        quantity: 3,
        categoryName: "أحذية",
        brand: "جينيرك",
        price: 200.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "ساعات المعصم",
        title: "ساعة مايكل",
        imageUrl:
        "https://m.media-amazon.com/images/I/91nuh9pm6FL._AC_SY500_.jpg",
        description: "ساعة مايكل كورس للنساء MK4310 - لون احمر",
        quantity: 16,
        categoryName: "ساعة",
        brand: "مايكل كورس",
        price: 177.57,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "ساعات المعصم",
        title: "ساعة مايكل",
        imageUrl:
        "https://m.media-amazon.com/images/I/61RXMQtXS+L._AC_SX425_.jpg",
        description: "سوار تتبع اللياقة البدنية 1.47 بوصة شاشة اموليد تعمل باللمس باند 6 من هواوي - اسود جرافيت",
        quantity: 4,
        categoryName: "ساعة",
        brand: "مايكل كورس",
        price: 177.57,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "تيفال",
        title: "طاسات تيفال",
        imageUrl:
        "https://m.media-amazon.com/images/I/51z6uvaI3+L._AC_SX425_.jpg",
        description: "طقم طاسات تيفال للقلي شديدة التحمل 3 قطع",
        quantity: 55,
        categoryName: "طعام",
        brand: "طاسات ",
        price: 120.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "سامسونج",
        title: "تلفزيون سمارت بشاشة LED",
        imageUrl:
        "https://m.media-amazon.com/images/I/71xvCVFFOQL._AC_SX679_.jpg",
        description:
        "تلفزيون سمارت بشاشة LED مسطجة اتش دي 55 بوصة بدقة 4K مع جهاز استقبال مدمج من سامسونج، موديل UA55TU8300",
        quantity: 88,
        categoryName: "تلفزيون",
        brand: "سامسونج",
        price: 120.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "ألعاب",
        title: " ألعاب إلكترونية",
        imageUrl:
        "https://m.media-amazon.com/images/I/412BOs2vD1S._AC_SX425_.jpg",
        description:
        "لعبة محشوة قطيفة ممتعة 32 سم نبات الرقص الكهربائي الصبار مع موسيقى لهدايا الاطفال، ديكورات المنزل والمكتب، هدايا ابداعية لالعاب الاطفال التعليمية",
        quantity: 98,
        categoryName: "تلفزيون",
        brand: "ألعاب",
        price: 227.00,
        inFavorite: false,
        inPopular: false),
  ];
  List<ProductModel> getProducts(){
    notifyListeners();
    return products;
  }




}