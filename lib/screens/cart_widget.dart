 import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:flutter/material.dart';

import '../models/cart_item_model/cart_item_model.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';
import 'inner_screen/brand_rail.dart';
import 'inner_screen/catrgory_screen.dart';

class CartItem extends StatelessWidget {
  final int index;
 static List<Map<String, dynamic>> cartItem = [
    {
      'name': 'المطبخ',
      'image': 'assets/images/kitchen.jpg',
    },
    {
      'name': 'أدوات الشرب',
      'image': 'assets/images/toolsDrink.jpg',
    },
    {
      'name': 'الإضاءة',
      'image': 'assets/images/lights.jpg',
    },
    {
      'name': 'الأثاث',
      'image': 'assets/images/furniture.png',
    },
    {
      'name': 'الإحتفالات',
      'image': 'assets/images/festivals.jpg',
    },

    {
      'name': 'أدوات التنظيف',
      'image': 'assets/images/clean.jpg',
    },
    {
      'name': 'أدوات صحية',
      'image': 'assets/images/bath.jpg',
    },
   {
      'name': 'ديكور',
      'image': 'assets/images/decor.jpg',
    },
  ];
  List<CartModel> model = [
    CartModel(image: 'assets/images/CatBeauty.jpg', categoryNames: 'Beauty'),
    CartModel(image: 'assets/images/CatClothes.jpg', categoryNames: 'Clothes'),
    CartModel(
        image: 'assets/images/CatFurniture.jpg', categoryNames: 'Furniture'),
    CartModel(image: 'assets/images/CatLaptops.png', categoryNames: 'Laptops'),
    CartModel(image: 'assets/images/CatPhones.png', categoryNames: 'Phones'),
    CartModel(image: 'assets/images/CatWatches.jpg', categoryNames: 'Watches'),
  ];
  CartItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = DarkCubit.get(context);
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, CategoryScreen.routeName,arguments:cartItem[index]['name'] );

        // print(cartItem[index]['name']);

        // if you need to activate railScreen >>>>>>>>>>>>
        // Navigator.push(context, MaterialPageRoute(builder: (context){return BrandRailScreen();}));

      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('${cartItem[index]['image']}'))),
            ),
          ),
          Container(
              width: 150,
              color: cubit.isDark
                  ? Colors.black.withOpacity(0.6)
                  : Colors.white.withOpacity(0.6),
              child: Text(
                '${cartItem[index]['name']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textSelectionColor),
              ))
        ],
      ),
    );
  }
}
