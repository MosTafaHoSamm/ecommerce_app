import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
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
  Map<String, dynamic> wishlistItems = {};

  // double getTotal() {
  //   double total = 0;
  //
  // wishlistItems.forEach((key, value) {total+=value.quantity*value.price;});
  //
  //   return total;
  // }
  removeFromWishList(context, productId) {
    emit(RemoveItemLoadingsState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('WishedProducts')
        .doc(productId)
        .delete()
        .then((value) {
      emit(RemoveItemSuccessState());
      getWishListItems();

      print('Removed mostataf WishList');
    }).catchError((error) {
      print(error.toString());
      emit(RemoveItemErrorState());
    });
  }

  late WishListItemModel model;

  addToWish(
    context, {
    required String productId,
    required String title,
    required double price,
    required String imageUrl,
    required String id,
    required String docId,
  }) {
    model = WishListItemModel(
        title: title, price: price, imageUrl: imageUrl, docId: docId, id: id);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('WishedProducts')
        .doc(productId)
        .set(model.toMap())
        .then((value) {
      print('Added To WishList');
      getWishListItems();
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<String> docs = [];

  getWishListItems()async {
    wishlistItems = {};
    docs = [];
    emit(GetWishListItemLoadingState());
    await Future.delayed(Duration(seconds: 6));
     FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('WishedProducts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        docs.add(element.id);
        model = WishListItemModel.fromJson(element.data());
        wishlistItems.addAll({model.docId: model});

        // wishlistItems={element.id:model!};
      });
      emit(GetWishListItemSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWishListItemErrorState());
    });
  }

  // addNewItemToWishList(
  //     {required String id,
  //     required String title,
  //     required String imageUrl,
  //     required double price}) {
  //   if (wishlistItems.containsKey(id)) {
  //     //   wishlistItems.update(
  //     //        id,
  //     //        (value) => WishListItemModel(
  //     //            title: value.title,
  //     //           price: value.price,
  //     //           imageUrl: value.imageUrl,
  //     //
  //     //
  //     //
  //     //            id: value.id));
  //     removeItem(id);
  //
  //     Fluttertoast.showToast(
  //         msg: "This Item Removed In your Wishlist",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.SNACKBAR,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.red.withOpacity(.6),
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } else {
  //     wishlistItems.putIfAbsent(
  //         id,
  //         // () => WishListItemModel(
  //         //     title: title, price: price, imageUrl: imageUrl, id: id));
  //     // Fluttertoast.showToast(
  //     //     msg: "This Item Added In your Wishlist",
  //     //     toastLength: Toast.LENGTH_SHORT,
  //     //     gravity: ToastGravity.BOTTOM,
  //     //     timeInSecForIosWeb: 1,
  //     //     backgroundColor: Colors.green.withOpacity(.6),
  //     //     textColor: Colors.white,
  //     //     fontSize: 16.0);
  //     // }
  //     // emit(ItemAddedSuccessState());
  //
  //     // print(cartItems.values.toList()[3].quantity);
  //   }
  //   // void plusButton(productId){
  //   //   wishlistItems[productId]?.quantity+=  1    ;
  //   //   emit(ChangePlusState());
  //   // }
  //
  //   // void minusButton(productId){
  //   //   (wishlistItems[productId]?.quantity) !=0?
  //   //
  //   //
  //   //   wishlistItems[productId]?.quantity-= 1:
  //   //
  //   //     print("Logic Error");
  //   //
  //   //   emit(ChangePlusState());
  //   //
  //   //
  //   //
  //   // }
  // }
  clear(
    userId,
  ) {
    for (int i = 0; i < docs.length; i++) {
      emptyWishList(userId: userId, doc: docs[i]);
    }
  }

  emptyWishList({
    required String userId,
    required String doc,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('WishedProducts')
        .doc(doc)
        .delete()
        .then((value) {
      getWishListItems();
      emit(EmptyWishListSuccessState());
    }).catchError((error) {
      emit(EmptyWishListErrorState());
    });
  }

  removeItem(String productId) {
    wishlistItems.remove(productId);
    emit(RemoveItemSuccessState());
  }

  Color colorGet({index, productId, context}) {
    List<Color> colors = [
      wishlistItems.containsKey(productId)
          ? (Colors.red)
          : Theme.of(context).textSelectionColor,
      Theme.of(context).textSelectionColor,
      CartCubit.get(context).cartItems.containsKey(productId)
          ? (Colors.red)
          : Theme.of(context).textSelectionColor,
    ];
    return colors[index];
  }

  IconData iconGet({productId, index, context}) {
    List icons = [
      wishlistItems.containsValue(productId)
          ? (FontAwesomeIcons.solidHeart)
          : FontAwesomeIcons.heart,
      FontAwesomeIcons.eye,
      CartCubit.get(context).cartItems.containsKey(productId)
          ? (FontAwesomeIcons.shoppingCart)
          : Icons.shopping_cart,
    ];
    // emit(ChangeIconState());
    return icons[index];

    // wishlistItems.containsKey(productId)?Colors.red:Colors.grey,
  }

  String titleGet({index, productId, context}) {
    List<String> titles = [
      wishlistItems.containsKey(productId) ? "In WishList" : "Add To Wish",
      "View Product",
      CartCubit.get(context).cartItems.containsKey(productId)
          ? "In Cart"
          : "Add To Cart",
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
