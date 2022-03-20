import 'package:badges/badges.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';
import '../shared/cubit/home_cubit/dark_cubit.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({Key? key,}) : super(key: key);
  static const routeName = '/feeds';
    List<ProductModel> productModel = [
    ProductModel(
        id: "مكسرات",
        title: "مكسرات أبو عوف",
        imageUrl: "https://m.media-amazon.com/images/I/51VjYShK-0L._AC_.jpg",
        description: "مكسرات متعددة من ابو عوف، 200 غرام",
        quantity: 5,
        categoryName: "مكسرات مختلطة",
        brand: "ابو عوف",
        price: 130.50,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "مكسرات",
        title: "أحذية رياضية",
        imageUrl: "https://m.media-amazon.com/images/I/31kAbTIftvL._AC_.jpg",
        description:
            "حذاء سنيكرز رياضي شمواه برباط بتصميم كاجوال بلونين، مقاس N12",
        quantity: 9,
        categoryName: "أحذية رياضية",
        brand: "جينيرك",
        price: 175.00,
        inFavorite: false,
        inPopular: false),
    ProductModel(
        id: "ساعات المعصم",
        title: "ساعة مايكل",
        imageUrl:
            "https://m.media-amazon.com/images/I/91nuh9pm6FL._AC_SY500_.jpg",
        description: "ساعة مايكل كورس للنساء MK4310 - لون احمر",
        quantity: 16,
        categoryName: "أحذية رياضية",
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
        categoryName: "طقم مقلاة",
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
        categoryName: "ألعاب",
        brand: "ألعاب",
        price: 227.00,
        inFavorite: false,
        inPopular: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 190 / 330,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                  productModel.length,
                  (index) => productItem(
                        context,
                        productModel[index],
                    index
                      )),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    )

        // StaggeredGridView.countBuilder(
        //   crossAxisCount: 4,
        //   itemCount: 10,
        //    itemBuilder: (BuildContext context, int index) => productItem(context),
        //   staggeredTileBuilder: (int index) =>
        //    StaggeredTile.count(2, index.isEven ?3.3  : 4),
        //   mainAxisSpacing: 10.0,
        //   crossAxisSpacing: 10.0,
        // )

        );
  }
}

Widget productItem(context, ProductModel model,index) {
  var cubit = DarkCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      onTap: () {
        navigateAndFinish(
            context,
            ProductsDetails(
              title: model.title,
              id: model.id,
              categoryName: model.categoryName,
              description: model.description,
              brand: model.brand,
              price: model.price,
              quantity: model.quantity,
              imageUrl: model.imageUrl,
              inFavorite: model.inFavorite,
              productModel: model,
            ));
      },
      child: Container(
        width: 200,
        height: 290,
        decoration: BoxDecoration(
            color: cubit.isDark ? Colors.grey.shade700 : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                        minHeight: 100,
                        maxHeight: MediaQuery.of(context).size.height * .2),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('${model.imageUrl}'),
                            fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  child: Badge(
                    animationType: BadgeAnimationType.fade,
                    toAnimate: true,
                    shape: BadgeShape.square,
                    badgeColor: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    badgeContent:
                        Text('New', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8,
                  ),
                  child: Text(
                    "${model.description}",
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8,
                  ),
                  child: Text(
                    "\$ ${model.price}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Quantity : ${model.quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              radius: 20,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              onTap: () {},
                              child: Icon(
                                Icons.more_horiz_rounded,
                                color: Colors.grey,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
