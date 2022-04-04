import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../models/cart_model.dart';
import '../../../models/wishlist_model.dart';
import 'wishlist_states.dart';

class WishListCubit extends Cubit<WishListStateS> {
  WishListCubit() : super(WishListInitialState());

  static WishListCubit get(context) => BlocProvider.of(context);
  Map<String, WishListItemModel> wishlistItems = {};

  // double getTotal() {
  //   double total = 0;
  //
  // wishlistItems.forEach((key, value) {total+=value.quantity*value.price;});
  //
  //   return total;
  // }
  Map<String, WishListItemModel> getWishListItems() {
    return wishlistItems;
  }

  addNewItemToWishList({
    required String id,
    required String title,
    required String imageUrl,
    required double price}) {
    if (wishlistItems.containsKey(id)) {
      //   wishlistItems.update(
      //        id,
      //        (value) => WishListItemModel(
      //            title: value.title,
      //           price: value.price,
      //           imageUrl: value.imageUrl,
      //
      //
      //
      //            id: value.id));
      removeItem(id);


      Fluttertoast.showToast(
          msg: "This Item Removed In your Wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red.withOpacity(.6),
          textColor: Colors.white,
          fontSize: 16.0
      );
    } else {
      wishlistItems.putIfAbsent(id, () =>
          WishListItemModel(
              title: title,
              price: price,
              imageUrl: imageUrl,
              id: id));
      Fluttertoast.showToast(
          msg: "This Item Added In your Wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green.withOpacity(.6),
          textColor: Colors.white,
          fontSize: 16.0
      );
      // }
      emit(ItemAddedSuccessState());

      // print(cartItems.values.toList()[3].quantity);
    }
    // void plusButton(productId){
    //   wishlistItems[productId]?.quantity+=  1    ;
    //   emit(ChangePlusState());
    // }

    // void minusButton(productId){
    //   (wishlistItems[productId]?.quantity) !=0?
    //
    //
    //   wishlistItems[productId]?.quantity-= 1:
    //
    //     print("Logic Error");
    //
    //   emit(ChangePlusState());
    //
    //
    //
    // }

  }
  emptyWishList(){
    wishlistItems.clear();
    emit(EmptyWishListChangeState());

  }
  removeItem(String productId){
    wishlistItems.remove(productId);
    emit(RemoveItemSuccessState());
  }
  Color colorGet({index, productId, context}){
    List <Color>colors=[
      wishlistItems.containsKey(productId)?(Colors.red):Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
    ];
    return colors[index];

  }
  IconData iconGet({productId, index, context}){
    List icons =[
      wishlistItems.containsKey(productId)?(FontAwesomeIcons.solidHeart):FontAwesomeIcons.heart,
      FontAwesomeIcons.eye,
      CartCubit.get(context).cartItems.containsKey(productId)?(FontAwesomeIcons.shoppingCart):FontAwesomeIcons.cartPlus,

    ];
    // emit(ChangeIconState());
    return icons[index];


    // wishlistItems.containsKey(productId)?Colors.red:Colors.grey,
  }

  String titleGet({index,productId,context}){
    List<String>titles=[
      wishlistItems.containsKey(productId)?"In WishList":"Add To Wish",
      "View Product",
      CartCubit.get(context).cartItems.containsKey(productId)?"In Cart":"Add To Cart",
    ];
    return titles[index];
  }
// List<Color>constColor=[
//
//   changeIcon({productId}){
//
//
//   ];
//   List<IconData>dialogIcons=[
//     ,
//
//
//   ];
//
//   emit(ChangeIconState());
//
// }
}