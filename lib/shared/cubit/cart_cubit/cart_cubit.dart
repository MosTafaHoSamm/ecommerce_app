import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/cart_model.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());

  static CartCubit get(context) => BlocProvider.of(context);
  Map<String, CartItemModel> cartItems = {};

  double getTotal() {
    double total = 0;

  cartItems.forEach((key, value) {total+=value.quantity*value.price;});

    return total;
  }
  Map<String,  CartItemModel> getCartItems(){
    return   cartItems ;
  }

    addNewItemToCart(
      {
        String option='plus',
        required String id,
      required String title,
      required String imageUrl,
      required double price}) {


    if (cartItems.containsKey(id)) {
        cartItems.update(
           id,
           (value) => CartItemModel(
               title: value.title,
              price: value.price,
              imageUrl: value.imageUrl,
               quantity: option=='plus'?value.quantity + 1:value.quantity - 1,
               id: value.id));
      } else
      {
      cartItems.putIfAbsent(id, () =>
          CartItemModel(
          title: title,
          price: price,
          imageUrl: imageUrl,
          quantity: 1,
          id:id));
    }
    emit(ItemAddedSuccessState());

    // print(cartItems.values.toList()[3].quantity);
  }
  void plusButton(productId){
    cartItems[productId]?.quantity+=  1    ;
    emit(ChangePlusState());
  }

  void minusButton(productId){
    (cartItems[productId]?.quantity) !=0?


    cartItems[productId]?.quantity-= 1:

      print("Logic Error");

    emit(ChangePlusState());



  }
   emptyCart(){
       cartItems.clear();
      emit(EmptyCartChangeState());

  }
  removeItem(String productId){
    cartItems.remove(productId);
    emit(RemoveItemSuccessState());
  }
}
