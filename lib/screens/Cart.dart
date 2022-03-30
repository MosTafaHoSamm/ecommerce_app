import 'package:ecommerceapplication/models/cart_model.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'empty_cart.dart';
import 'full_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName="/cartScreen";

  @override
  Widget build(BuildContext context) {
var cubit =CartCubit.get(context);

  Map<String,CartItemModel> cartItems=cubit.getCartItems() ;
     print(cartItems.length);
    return BlocConsumer<CartCubit,CartStates>(
 listener: (context,state){},
 builder: (context,state){
   return Scaffold(
     body: cartItems.length>0?FullCart(cartItems: cartItems,):EmptyCart() ,

   );
 },
     );
  }
}
