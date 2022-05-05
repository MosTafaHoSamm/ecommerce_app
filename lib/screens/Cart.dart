import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/models/cart_model.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth/signup/signup_screen.dart';
import 'empty_cart.dart';
import 'full_cart.dart';
import 'home.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);
  static String routeName = "/cartScreen";

  @override
  Widget build(BuildContext context) {
    var cubit = CartCubit.get(context);

    Map<String, CartItemModel> cartItems = cubit.cartItems;
    print(cartItems.length);
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            return showExitPopup(context);
          },
          child: uId!=null?Scaffold(
            body: CartCubit.get(context).cartItems.isNotEmpty
                ? FullCart()
                : ConditionalBuilder(
                    condition: state is GetCartItemsLoadingState,
                    builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                    fallback: (context) => EmptyCart()),
          ):Scaffold(
            body: Center(
              child: Card(
                child :Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Register to use All Features 😊'),
                      SizedBox(height: 15,),
                      OutlinedButton(autofocus: false,

                          style: ButtonStyle(

                              shape: MaterialStateProperty.all<OutlinedBorder> (RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20),
                                  )))),
                          onPressed: (){
                            Navigator.pushNamed(context, SignupScreen.routeName);
                          }, child: Text('Register Now' ))
                    ],
                  ),
                ),
              ),
            ),
          )
        );
      },
    );
  }
}
