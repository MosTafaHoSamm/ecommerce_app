import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/cart_model.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);
  Map<String, CartItemModel> cartItems = {};

  double getTotal() {
    double total = 0;

    cartItems.forEach((key, value) {
      total += value.quantity * value.price;
    });

    return total;
  }
List<String>docs=[];
 Future getCartItems() async{
    emit(GetCartItemsLoadingState());
// مهم جدا تصفير الماب عند بداية جلب البيانات حتي تغير في الاسكرين
    cartItems = {};
    docs=[];
     FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('Cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        docs.add(element.id);

        model = CartItemModel.fromJson(element.data());
        cartItems.addAll({model.docId: model});
      });
      print('Docs Length : ${docs.length}');
      // for (var value1 in value.docs) {
      //   cartItems.addAll({value1.id: CartItemModel.fromJson(value1.data())});
      emit(GetCartItemsSuccessState());
    }).catchError((error) {
      emit(GetCartItemsErrorState());
    });
  }

  late CartItemModel model;

  addItemToCart(

      {required String id,
      required   context ,
      required String title,
      required String productId,
      required String userId,
      required String imageUrl,
      required double price}) {
    model = CartItemModel(
        docId: productId,
        title: title,
        price: price,
        imageUrl: imageUrl,
        quantity: 1,
        id: id);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('Cart')
        .doc(productId)
        .set(model.toMap())
        .then((value) {
       getCartItems();
      emit(ItemAddedSuccessState());
    }).catchError((error) {
      print(error);
      emit(ItemAddedErrorState());
    });
  }

  //   addNewItemToCart(
  //     {
  //       String option='plus',
  //       required String id,
  //     required String title,
  //     required String imageUrl,
  //     required double price}) {
  //
  //
  //   if (cartItems.containsKey(id)) {
  //       cartItems.update(
  //          id,
  //          (value) => CartItemModel(
  //              title: value.title,
  //             price: value.price,
  //             imageUrl: value.imageUrl,
  //              quantity: option=='plus'?value.quantity + 1:value.quantity - 1,
  //              id: value.id));
  //     } else
  //     {
  //     cartItems.putIfAbsent(id, () =>
  //         CartItemModel(
  //         title: title,
  //         price: price,
  //         imageUrl: imageUrl,
  //         quantity: 1,
  //         id:id));
  //   }
  //   emit(ItemAddedSuccessState());
  //
  //   // print(cartItems.values.toList()[3].quantity);
  // }
  void plusButton(productId) {
    cartItems[productId]?.quantity += 1;
    emit(ChangePlusState());
  }

  void minusButton(productId) {
    (cartItems[productId]?.quantity) != 0
        ? cartItems[productId]?.quantity -= 1
        : print("Logic Error");

    emit(ChangePlusState());
  }

  emptyCart() {
for(var i in docs){
  removeItem(docId: i);
}

     emit(EmptyCartSuccessState());
  }

  removeItem({
    required String docId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('Cart')
        .doc(docId)
        .delete()
        .then((value) {
      emit(RemoveItemSuccessState());
      getCartItems();

      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('Cart')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          model = CartItemModel.fromJson(element.data());
          cartItems.addAll({model.docId: model});
          print('Cart length After Delete ${cartItems.length}');
        });
      });
    }).catchError((error) {
      emit(RemoveItemErrorState());
    });
  }
}
