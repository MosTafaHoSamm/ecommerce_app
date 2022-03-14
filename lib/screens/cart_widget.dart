import 'package:ecommerceapplication/shared/cubit/home_cubit/dark_cubit.dart';
import 'package:flutter/material.dart';

import '../models/cart_item_model/cart_item_model.dart';
import 'inner_screen/brand_rail.dart';

class CartItem extends StatelessWidget {
  final int index;
  List<Map<String, dynamic>> cartItem = [
    {
      'name': 'Electronics',
      'image': 'assets/images/CatLaptops.png',
    },
    {
      'name': 'Electronics',
      'image': 'assets/images/CatBeauty.jpg',
    },
    {
      'name': 'Electronics',
      'image': 'assets/images/CatClothes.jpg',
    },
    {
      'name': 'Furniture',
      'image': 'assets/images/CatFurniture.jpg',
    },
    {
      'name': 'Laptops',
      'image': 'assets/images/CatLaptops.png',
    },
    {
      'name': 'Phones',
      'image': 'assets/images/CatPhones.png',
    },
    {
      'name': 'Watches',
      'image': 'assets/images/CatWatches.jpg',
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
        Navigator.push(context, MaterialPageRoute(builder: (context){return BrandRailScreen();}));
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
