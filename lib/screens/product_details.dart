import 'package:badges/badges.dart';
import 'package:ecommerceapplication/models/product_model.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_states.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/components/constatnts.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';
import 'Cart.dart';
import 'feeds.dart';

class ProductsDetails extends StatelessWidget {
  static const String routeName = '/productScreen';

  ProductsDetails({
    Key? key,
    // required this.id,
    // required this.title
    // , required this.description,
    // required this.categoryName,
    // required this.imageUrl,
    // required this.quantity,
    // required this.brand,
    // required this.price,
    // required this.inFavorite,
    // required this.inPupolar,
  }) : super(key: key);

  // final String id;
  // final String title;
  // final String description;
  // final String categoryName;
  // final String imageUrl;
  // final int quantity;
  // final String brand;
  // final double price;
  // final bool inFavorite;
  // final bool inPupolar;

  @override
  Widget build(BuildContext context) {
    final String routeArgs =
        ModalRoute.of(context)?.settings.arguments as String;
    print(routeArgs);

    var cubit = DarkCubit.get(context);
    var cubitH = HomeCubit.get(context);
    var cubitCart = CartCubit.get(context);
    var wishListCubit = WishListCubit.get(context);

    ProductModel model = cubitH.getProductDetails(routeArgs);
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: cubit.isDark ? Colors.black : Colors.grey.shade700,
            centerTitle: true,
            title: Text("Detail".toUpperCase()),
            actions: [
              uId!=null?wishListListener(widget: WishListScreen(), context: context):Container(),
              uId!=null? cartListener(context: context, widget: CartScreen()):Container(),
              SizedBox(
                width: 10,
              ),
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
                    child: Image.network(model.imageUrl)),
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
                            model.title,
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "US \$ ${model.price}",
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
                            model.description,
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
                          _details(context, "Brand", model.brand),
                          _details(
                              context, "Quantity", "${model.quantity} Left"),
                          _details(context, "Category", model.categoryName),
                          _details(
                              context,
                              "Popularity",
                              model.inPopular
                                  ? "people purchased this product"
                                  : "not yet"),
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
                        color:
                            cubit.isDark ? Colors.grey.shade900 : Colors.white,
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
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: cubit.isDark ? Colors.grey : Colors.grey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Text(
                                    "Suggested Products :",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            color: cubit.isDark ? Colors.grey : Colors.grey,
                            height: 320,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return productItem(
                                      context, cubitH.products[index], index);
                                },
                                itemCount: cubitH.products.length),
                          ),
                          Container(
                            width: double.infinity,
                            height: 60,
                            color: cubit.isDark ? Colors.grey : Colors.grey,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: uId!=null?Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        color: Colors.red.shade900,
                        child: OutlinedButton(
                          onPressed: cubitCart.cartItems.containsKey(model.docId)
                              ? () {
                            print('DocId :${CartCubit.get(context).model.docId} ');
                            print('Check : ${cubitCart.cartItems.containsKey(CartCubit.get(context).model.docId)}');
                          }
                              : () {
                                  cubitCart.addItemToCart(
                                      context: context,
                                    productId: model.docId,
                                      id: model.id,
                                      title: model.title,
                                      imageUrl: model.imageUrl,
                                      price: model.price,
                                  userId: uId!);
                                },
                          child: Text(
                            cubitCart.cartItems.containsKey(model.docId)
                                ? "IN CART"
                                : "Add to Cart".toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 40,
                        color: Colors.white,
                        child: OutlinedButton(
                          onPressed: () {
// ...somewhere in your Flutter app...
                            launchWhatsApp(model);

                          },
                          child: Row(
                            children: [
                              Text(
                                "Buy Now".toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Image.asset('assets/images/whatsapp.png',
                              height: 20,
                              width: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 40,
                        color: Colors.grey.shade400,
                        child: OutlinedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            // print( wishListCubit.wishlistItems.values.toList() [0].docId);

                            print( model.docId );

                            wishListCubit.docs.contains(model.docId)

                                ? wishListCubit.removeFromWishList(
                                    context, model.docId)
                                : wishListCubit.addToWish(context,
                                    productId: model.docId,
                                    title: model.title,
                                    price: model.price,
                                    imageUrl: model.imageUrl,
                                    id: model.id,
                            docId: model.docId);
                          },
                          child: BlocConsumer<WishListCubit, WishListStateS>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Icon(
                                FontAwesomeIcons.solidHeart,
                                color: wishListCubit.docs.contains(model.docId)
                                    ? Colors.grey
                                    : Colors.red.shade500,
                                size: 20,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ): Container(

                  height: 40,
                  color: Colors.white,
                  child: OutlinedButton(
                    onPressed: () {
// ...somewhere in your Flutter app...
                      launchWhatsApp(model);

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Buy Now".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/whatsapp.png',
                          height: 20,
                          width: 20,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
launchWhatsApp(model) async {
  final link = WhatsAppUnilink(
    phoneNumber: '+201024124157',
    text: "${model.description        } ???? ?????? ???????????? ?????????? ?"
        ,
  );
  // Convert the WhatsAppUnilink instance to a string.
  // Use either Dart's string interpolation or the toString() method.
  // The "launch" method is part of "url_launcher".
  await launch('$link');
}