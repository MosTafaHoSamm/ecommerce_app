import 'package:bloc/bloc.dart';
import 'package:ecommerceapplication/models/cart_item_model/cart_item_model.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/cart_model.dart';
import 'cart_states.dart';

class CartCubit extends Cubit<CartStates>{
  CartCubit():super(CartInitialState());

  static CartCubit get(context)=>BlocProvider.of(context);
  Map<String,CartItemModel>cartItems={};
  double getTotal(){
    double total=0;
    cartItems.forEach((key, value) {total+=value.price*value.quantity;});
    return total;
  }
}