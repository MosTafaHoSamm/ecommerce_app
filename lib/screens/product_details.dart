import 'package:ecommerceapplication/models/product_model.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Cart.dart';
import 'feeds.dart';

class ProductsDetails extends StatelessWidget {
    ProductsDetails(
        {Key? key,
          required this.id,
          required this.title
          , required this.description,
          required this.categoryName,
          required this.imageUrl,
          required this.quantity,
          required this.brand,
          required this.price,
          required this.inFavorite,
        required this.productModel}) : super(key: key);

    final String id;
    final String title;
    final String description;
    final String categoryName;
    final String imageUrl;
    final int quantity;
    final String brand;
    final double price;
    final bool inFavorite;
     ProductModel productModel ;



    @override
  Widget build(BuildContext context) {
    var cubit = DarkCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cubit.isDark?Colors.black:Colors.grey.shade700,
        centerTitle: true,
        title: Text("Detail".toUpperCase()),
        actions: [
          IconButton(
              onPressed: () {
                navigateAndFinish(context, WishListScreen());
              },
              icon: Icon(
                FontAwesomeIcons.solidHeart,
                color: Colors.red,
              )),
          IconButton(
              onPressed: () {
                navigateAndFinish(context, CartScreen());
              },
              icon: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Colors.white,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.grey,
            height: MediaQuery.of(context).size.height * 0.47,
            width: double.infinity,
            child: Container(
                padding: EdgeInsets.all(16),
                child: Image.network(
                    imageUrl)),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 250)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.save)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  color: Colors.grey[700],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Theme.of(context).textSelectionColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "US \$ ${price}",
                        style: TextStyle(
                          color: cubit.isDark
                              ? Theme.of(context).disabledColor
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(thickness: 1),
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: cubit.isDark
                              ? Theme.of(context).disabledColor
                              : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Divider(thickness: 1),
                      ),
                      _details(context, "Brand", brand),
                      _details(context, "Quantity", "${quantity} Left"),
                      _details(context, "Category", categoryName),
                      _details(context, "Popularity", inFavorite),
                      SizedBox(
                        height: 10,
                      ),
                      // Divider(
                      //   height: 1,
                      // ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration( 
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: cubit.isDark?Colors.grey.shade900:Colors.white,
                  ),
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "No Reviews yet ",
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Be The First Reviewer ! ",
                        style: TextStyle(
                            color: Theme.of(context).textSelectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(

                              topLeft:Radius.circular(20),
                              topRight:Radius.circular(20),
                          ),
                          color: cubit.isDark?Colors.grey:Colors.grey,

                        ),

                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 20,bottom: 20),

                              child: Text(

                                "Suggested Products :",
                                style: TextStyle(
                                    color: Theme.of(context).textSelectionColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        color: cubit.isDark?Colors.grey:Colors.grey,

                        height: 320,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return   productItem(context,productModel ,index  );
                            },
                            itemCount: 7),
                      ),
                      Container(
                        width:double.infinity,height: 60,color:cubit.isDark?Colors.grey:Colors.grey,)


                    ],
                  ),
                ),
              ],
            ),

          ),Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  flex:3,
                  child: Container(
                    height: 40,
                    color: Colors.red.shade900,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(

                        "Add to Cart".toUpperCase(),
                        textAlign:TextAlign.center,

                        style: TextStyle(
                            color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex:2,

                  child: Container(
                    height: 40,
                    color: Colors.white,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "Buy Now".toUpperCase(),
                            textAlign:TextAlign.center,
                            style: TextStyle(
                                color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(width: 5,),
                          Icon(FontAwesomeIcons.creditCard,color: Colors.green.shade500,size: 17,)
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex:1,

                  child: Container(
                    height: 40,
                    color: Colors.grey.shade400,
                    child: OutlinedButton(
                        style: ButtonStyle(),
                        onPressed: () {},
                        child:
                        Icon(FontAwesomeIcons.solidHeart,color: Colors.red.shade500,size: 20,)


                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _details(context, title, sub) {
  var cubit = DarkCubit.get(context);
  return Padding(
    padding: const EdgeInsets.only(top: 5, right: 5, bottom: 5),
    child: Row(
      children: [
        Expanded(
          child: Text(
            "${title} :",
            style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            " ${sub}",
            style: TextStyle(
              color:
                  cubit.isDark ? Theme.of(context).disabledColor : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
