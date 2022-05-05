import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/models/cart_model.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../empty_cart.dart';
import '../full_cart.dart';
import '../home.dart';


class CartUserScreen extends StatelessWidget {
  const CartUserScreen({Key? key}) : super(key: key);
  static String routeName = "/CartUserScreen";

  @override
  Widget build(BuildContext context) {
    var cubit = CartCubit.get(context);

    Map<String, CartItemModel> cartItems = cubit.cartItems;
    print(cartItems.length);
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CartCubit.get(context).cartItems.isNotEmpty
              ? FullCart()
              : ConditionalBuilder(
                  condition: state is GetCartItemsLoadingState,
                  builder: (context) => Center(
                        child: CircularProgressIndicator(),
                      ),
                  fallback: (context) => EmptyCart()),
        );
      },
    );
  }
}
