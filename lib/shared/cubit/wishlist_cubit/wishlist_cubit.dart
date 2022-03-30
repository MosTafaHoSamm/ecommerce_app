 import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

      Fluttertoast.showToast(
          msg: "This Item In your Wishlist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
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
}