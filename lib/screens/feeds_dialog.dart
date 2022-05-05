import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/product_model.dart';
import '../shared/cubit/cart_cubit/cart_cubit.dart';
import '../shared/cubit/wishlist_cubit/wishlist_states.dart';

class FeedsDialog extends StatelessWidget {
  static String routeName = "/feedsDialog";
  final String productId;
  final model;

  const FeedsDialog({
    Key? key,
    required this.productId,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              side: BorderSide(),
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                          minHeight: 100,
                          maxHeight: MediaQuery.of(context).size.height * .5),
                      child: Image.network(
                        "${model.imageUrl}",
                        fit: BoxFit.fill,
                      )),
                  Container(
                    color: Theme.of(context).cardColor,
                    child: Row(
                      children: [
                        contentDialog(
                            func: () {
                              (WishListCubit.get(context)
                                  .wishlistItems
                                  .containsKey(model.docId) !=
                                  true)?
                               WishListCubit.get(context).addToWish(context,
                                  title: model.title,
                                  imageUrl: model.imageUrl,
                                  price: model.price,
                                  productId: model.docId,
                                  docId: model.docId,
                                  id: model.id):WishListCubit.get(context).removeItem(model.docId);
                              (Navigator.canPop(context))
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            context: context,
                            productId: model.docId,
                            index: 0),
                        contentDialog(
                            func: () {
                              // Navigator.pushNamed(
                              //     context,
                              //     ProductsDetails.routeName);
                              Navigator.pushNamed(
                                  context, ProductsDetails.routeName,
                                  arguments: productId);
                            },
                            context: context,
                            productId: productId,
                            index: 1),
                        contentDialog(
                            func: () {
                              if (CartCubit.get(context)
                                      .cartItems
                                      .containsKey(model.docId) !=
                                  true) {
                                CartCubit.get(context).addItemToCart(

                                    productId: model.docId,
                                    id: model.id,
                                    title: model.title,
                                    imageUrl: model.imageUrl,
                                    price: model.price,
                                    userId: uId!, context: context);
                                Fluttertoast.showToast(
                                    msg: 'Item Added To Cart',
                                    backgroundColor: Colors.green.shade700.withOpacity(.7));
                              } else {
                                CartCubit.get(context).removeItem(
                                  docId: model.docId,
                                );
                                Fluttertoast.showToast(
                                    msg: 'Item Removed from Cart',
                                    backgroundColor: Colors.red.withOpacity(.7));
                              }
                              (Navigator.canPop(context))
                                  ? Navigator.pop(context)
                                  : null;
                            },
                            context: context,
                            productId: productId,
                            index: 2),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ],
    );
  }

  Widget contentDialog({
    context,
    productId,
    required int index,
    required Function() func,
  }) {
    var wishCubit = WishListCubit.get(context);
    var cartCubit = CartCubit.get(context);
    // List<IconData> icons = [
    //   WishListCubit.get(context).wishlistItems.containsKey(model.docId)
    //       ? FontAwesomeIcons.solidHeart
    //       : FontAwesomeIcons.heart,
    // ];
    return Flexible(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: func,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .25,
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              offset: Offset(1, 1),
                              color: Colors.grey)
                        ]),
                    child: ClipOval(
                      child: SizedBox(
                          height: 50,
                          width: 50,
                          child: BlocConsumer<WishListCubit, WishListStateS>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              print('Product Id : ${productId}');
                              return Icon(
                                wishCubit.iconGet(
                                    context: context,
                                    productId: productId,
                                    index: index),
                                size: 25,
                                color: wishCubit.colorGet(
                                    index: index,
                                    productId: productId,
                                    context: context),
                              );
                            },
                          )),
                    ),
                  ),
                  FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${wishCubit.titleGet(productId: productId, index: index, context: context)}',
                      maxLines: 1,
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
