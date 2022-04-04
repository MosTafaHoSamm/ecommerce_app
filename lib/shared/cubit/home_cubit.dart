import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/product_model.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeStates());
  static HomeCubit get(context) => BlocProvider.of(context);
  int current = 0;
  void dotSlide(index) {
    current = index;
    emit(ChangeHomeStates());
  }

  List<ProductModel> products = [
    ProductModel(
        id: "tea",
        title: "ليبتون شاي",
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/91vW5upayCL.__AC_SX300_SY300_QL70_ML2_.jpg",
        description: "ليبتون شاي اخضر كلاسيكي، 100 كيس شاي",
        quantity: 5,
        categoryName: "طعام",
        brand: "Apple",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "meat",
        title: "شبكة شواية اللحوم",
        imageUrl:
            "https://m.media-amazon.com/images/I/71XeaKL2qyL._AC_SX522_.jpg",
        description: "شبكة شواية اللحوم من فوتا جريلز3014 - 30x40 سم",
        quantity: 12,
        categoryName: "طعام",
        brand: "H&M",
        price: 200.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "mix",
        title: "مكسرات أبو عوف",
        imageUrl: "https://m.media-amazon.com/images/I/51VjYShK-0L._AC_.jpg",
        description: "مكسرات متعددة من ابو عوف، 200 غرام",
        quantity: 5,
        categoryName: "طعام",
        brand: "Apple",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "juice ",
        title: "شراب سريع التحضير ",
        imageUrl: "https://m.media-amazon.com/images/I/81G16umPeTL._AC_SX569_.jpg",
        description: "شراب سريع التحضير بنكهة المانجو من تانج 450 جرام",
        quantity: 5,
        categoryName: "طعام",
        brand: "Apple",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "shoes1",
        title: "أحذية رياضية",
        imageUrl: "https://m.media-amazon.com/images/I/31kAbTIftvL._AC_.jpg",
        description:
            "حذاء سنيكرز رياضي شمواه برباط بتصميم كاجوال بلونين، مقاس N12",
        quantity: 9,
        categoryName: "الملابس",
        brand: "Nike",
        price: 175.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "shoes2",
        title: "صندل شمواه",
        imageUrl: "https://m.media-amazon.com/images/I/41O4uxZv1ZL._AC_.jpg",
        description: "صندل شمواه صناعي فلات مزين بفصوص بشرائط متعددة",
        quantity: 3,
        categoryName: "أحذية",
        brand: "Nike",
        price: 200.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "shoes3",
        title: "شبشب",
        imageUrl: "https://m.media-amazon.com/images/I/51mEZXnYpDL._AC_SX500_.jpg",
        description: "شبشب سيول سلايد للنساء من اوندا",
        quantity: 3,
        categoryName: "الملابس",
        brand: "Adidas",
        price: 200.454,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "watch1",
        title: "ساعة مايكل",
        imageUrl:
            "https://m.media-amazon.com/images/I/91nuh9pm6FL._AC_SY500_.jpg",
        description: "ساعة مايكل كورس للنساء MK4310 - لون احمر",
        quantity: 16,
        categoryName: "ساعات",
        brand: "Samsung",
        price: 177.57,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "watch2",
        title: "ساعة مايكل",
        imageUrl:
            "https://m.media-amazon.com/images/I/61RXMQtXS+L._AC_SX425_.jpg",
        description:
            "سوار تتبع اللياقة البدنية 1.47 بوصة شاشة اموليد تعمل باللمس باند 6 من هواوي - اسود جرافيت",
        quantity: 4,
        categoryName: "ساعات",
        brand: "Apple",
        price: 177.57,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "pan",
        title: "طاسات تيفال",
        imageUrl:
            "https://m.media-amazon.com/images/I/51z6uvaI3+L._AC_SX425_.jpg",
        description: "طقم طاسات تيفال للقلي شديدة التحمل 3 قطع",
        quantity: 55,
        categoryName: "طعام",
        brand: "H&M",
        price: 120.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "screen",
        title: "تلفزيون سمارت بشاشة LED",
        imageUrl:
            "https://m.media-amazon.com/images/I/71xvCVFFOQL._AC_SX679_.jpg",
        description:
            "تلفزيون سمارت بشاشة LED مسطجة اتش دي 55 بوصة بدقة 4K مع جهاز استقبال مدمج من سامسونج، موديل UA55TU8300",
        quantity: 88,
        categoryName: "إلكترونيات",
        brand: "Huawei",
        price: 120.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "dance",
        title: " ألعاب إلكترونية",
        imageUrl:
            "https://m.media-amazon.com/images/I/412BOs2vD1S._AC_SX425_.jpg",
        description:
            "لعبة محشوة قطيفة ممتعة 32 سم نبات الرقص الكهربائي الصبار مع موسيقى لهدايا الاطفال، ديكورات المنزل والمكتب، هدايا ابداعية لالعاب الاطفال التعليمية",
        quantity: 98,
        categoryName: "إلكترونيات",
        brand: "DELL",
        price: 227.00,
        inFavorite: false,
        inPopular: true),
    ProductModel(
        id: "haircut",
        title: " ماكينة ازالة الشعر سيلك ابيل للعناية",
        imageUrl:
            "https://m.media-amazon.com/images/I/61vS3ne9R0L._AC_SY355_.jpg",
        description:
            "اكينة ازالة الشعر سيلك ابيل للعناية بالجمال 9/995 BS من براون، مجموعة مكونة من 9 قطع لازالة الشعر المبلل والجاف مع 11 رؤوس اضافية متضمنة. فيس سبا من براون",
        quantity: 5,
        categoryName: "الصحة والجمال",
        brand: "H&M",
        price: 3001.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "spray",
        title: "سبراي مزيل لرائحة العرق بيرل اند بيوتي للنساء من نيفيا، 150 مل",
        imageUrl:
            "https://m.media-amazon.com/images/I/61VfI2sQ05L._AC_SY355_.jpg",
        description:
            "اكينة ازالة الشعر سيلك ابيل للعناية بالجمال 9/995 BS من براون، مجموعة مكونة من 9 قطع لازالة الشعر المبلل والجاف مع 11 رؤوس اضافية متضمنة. فيس سبا من براون",
        quantity: 5,
        categoryName: "الصحة والجمال",
        brand: "H&M",
        price: 3001.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "wall",
        title: "تابلوه / تابلوهات مودرن أطفال",
        imageUrl:
            "https://m.media-amazon.com/images/I/7161t5aFwvL._AC_SX425_.jpg",
        description:
            "تابلوه / تابلوهات مودرن أطفال خشب - برواز - معلقات - صورة - لوحة حائط - حجرة أطفال مقاس 100 في 70 سم (4357)",
        quantity: 5,
        categoryName: " الأثاث",
        brand: "Apple",
        price: 3001.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "mobileReno",
        title: "موبايل رينو 6 اوروا",
        imageUrl:
            "https://m.media-amazon.com/images/I/41dXAQoIm2L._AC_.jpg",
        description:
            "موبايل رينو 6 اوروا بشريحتين اتصال وذاكرة رام 8 جيجابايت 128 جيجابايت 4G LTE)",
        quantity: 5,
        categoryName: " موبايلات",
        brand: "Huawei",
        price: 3001.00,
        inFavorite: false,
        inPopular: true),
    ProductModel(
        id: "iphone",
        title: "موبايل أيفون 13 برو ماكس",
        imageUrl:
            "https://m.media-amazon.com/images/I/61i8Vjb17SL._AC_SX425_.jpg",
        description:
            "موبايل ايفون 13 Pro Max، 256 جيجابايت، ازرق سييرا",
        quantity: 5,
        categoryName: " موبايلات",
        brand: "Apple",
        price: 23000.00,
        inFavorite: false,
        inPopular: true),
    ProductModel(
        id: "reno",
        title: "موبايل رينو 6 اوروا",
        imageUrl:
            "https://m.media-amazon.com/images/I/41SpbRJ0SqL._AC_.jpg",
        description:
            "موبايل نوكيا 150 بشريحتي اتصال - 2.4 بوصة، 4 ميجا، رام 4 ميجا، 2 جيجا - ازرق سيان",
        quantity: 5,
        categoryName: " موبايلات",
        brand: "Apple",
        price: 3001.00,
        inFavorite: false,
        inPopular: false),
  ];
  List<ProductModel> getProducts() {
    return products;
  }

  List<ProductModel> getCategory(String categoryName) {
    List<ProductModel> category = products
        .where((element) => element.categoryName

            .contains(categoryName ))
        .toList();
    return category;
  }

  List<ProductModel>getBrand(brandName){
    List<ProductModel> barndproducts=products.where((element) =>element.brand.contains(brandName.toString())).toList();
    return barndproducts;

  }

  List<ProductModel>getPopular(){
    return products.where((element) => element.inPopular).toList();
  }
  ProductModel getProductDetails(String productId){
    return  products.firstWhere((element) => element.id==productId);
  }
  List<ProductModel>searchQuery(value){
    return products.where((element) => element.title.contains(value)).toList();
  }
}
