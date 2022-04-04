import 'package:ecommerceapplication/models/cart_model.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cart_cubit/cart_states.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';
import '../shared/cubit/dark_cubit/dark_states.dart';

class FullCart extends StatelessWidget {
  final Map<String, dynamic>? cartItems;
  const FullCart({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DarkCubit.get(context);
        var cubitCart = CartCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text("cart ("),
                Text(
                  "${(cartItems?.length)}",
                  style: TextStyle(color: Colors.redAccent),
                ),
                Text(")"),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showAlertDialog(
                      context: context,
                      ok: () {
                        cubitCart.emptyCart();
                        Navigator.pop(context);
                      },
                      cancel: () {
                        Navigator.pop(context);
                      },
                      title: 'Clear Cart',
                      subtitle: 'Cart Will be empty !');
                },
                icon: Icon(MyIcon.trash),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 65),
            child: ListView.builder(
                itemCount: cartItems!.values.length,
                itemBuilder: (context, index) {
                  return itemBuild(
                      context, cartItems!.values.toList()[index], index);
                }),
          ),
          bottomSheet: checkOutElement(context, cubitCart.getTotal()),
        );
      },
    );
  }

  Widget checkOutElement(BuildContext context, double total) {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(colors: [
                      ColorsConsts.gradiendLEnd,
                      ColorsConsts.gradiendLStart,
                    ], stops: [
                      0,
                      0.5
                    ])),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CheckOut".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorsConsts.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '\$ ${total.toStringAsFixed(2)} ',
              style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}

Widget itemBuild(context, CartItemModel cartItem, index) {
  var cubit = DarkCubit.get(context);
  var cubitCart = CartCubit.get(context);

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: InkWell(
      onTap: () {
        print('ID : ${cartItem.id}');
        Navigator.pushNamed(context, ProductsDetails.routeName,
            arguments: cartItem.id);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(20),
            ),
            color: Theme.of(context).backgroundColor),
        width: double.infinity,
        height: 155,
        child: Row(
          children: [
            Container(
              height: 130,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("${cartItem.imageUrl}"),
                      fit: BoxFit.fill)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${cartItem.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              radius: 10,
                              splashColor: Theme.of(context).splashColor,
                              onTap: () {
                                showAlertDialog(
                                    cancel: () {
                                      Navigator.pop(context);
                                    },
                                    ok: () {
                                      cubitCart.removeItem(cartItem.id);
                                      Navigator.pop(context);
                                    },
                                    title: 'DELETE Item',
                                    subtitle: 'Are You Sure ?',
                                    context: context);
                                //
                              },
                              child: Icon(
                                MyIcon.close,
                                color: Colors.red,
                                size: 20,
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'price',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${cartItem.price} \$',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: cubit.isDark
                                  ? Colors.brown
                                  : Colors.blueAccent),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'sub Total :',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${(cartItem.price * cartItem.quantity).toStringAsFixed(2)} \$',
                          maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              color: cubit.isDark
                                  ? Colors.brown
                                  : Colors.blueAccent),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'ships free',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Spacer(),
                        Material(
                          color: Colors.transparent,
                           child: CircleAvatar(

                               radius: 15,

                               backgroundColor:Colors.transparent,
                              child: IconButton(

                                padding: EdgeInsets.all(0),

                                   icon: Icon(

                                       FontAwesomeIcons.minus,
                                  color:Colors.red),
                                  onPressed: cartItem.quantity > 1
                                      ? () {
                                          cubitCart.addNewItemToCart(
                                              option: 'minus',
                                              id: cartItem.id,
                                              title: cartItem.title,
                                              imageUrl: cartItem.imageUrl,
                                              price: cartItem.price);
                                        }
                                      : () {},iconSize:15,)),
                        ),
                        // another method to use minus button
                        // cubitCart.minusButton(cartItem.id);
                        // print(cartItem.quantity);

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                gradient: LinearGradient(colors: [
                                  ColorsConsts.gradiendLStart,
                                  ColorsConsts.gradiendLEnd,
                                ], stops: [
                                  0.0,
                                  .5
                                ])),
                            width: MediaQuery.of(context).size.width * .12,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "${cartItem.quantity}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                           child: CircleAvatar(
                             radius: 15,
                              backgroundColor:Colors.transparent,
                              child: IconButton(
                                iconSize: 15,
                                  padding: EdgeInsets.all(0),

                                  icon: Icon(FontAwesomeIcons.plus,
                                      color:Colors.red),
                                  onPressed:  () {

                                    cubitCart.plusButton(cartItem.id);
                                    //         print(cartItem.quantity);
                                    // cubitCart.addNewItemToCart(
                                    //     option: 'minus',
                                    //     id: cartItem.id,
                                    //     title: cartItem.title,
                                    //     imageUrl: cartItem.imageUrl,
                                    //     price: cartItem.price);
                                  }
                                       )),
                        ),
                        // Material(
                        //   borderRadius: BorderRadius.all(Radius.circular(40)),
                        //   color: Colors.red,
                        //   child: InkWell(
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(20)),
                        //       radius: 30,
                        //       splashColor: Theme.of(context).splashColor,
                        //       onTap: () {
                        //         cubitCart.plusButton(cartItem.id);
                        //         print(cartItem.quantity);
                        //       },
                        //       child: Icon(
                        //         FontAwesomeIcons.plus,
                        //         color: Colors.green.shade700,
                        //         size: 20,
                        //       )),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
