import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/models/wishlist_model.dart';
import 'package:ecommerceapplication/screens/empty_wishlist.dart';
import 'package:ecommerceapplication/screens/full_wishlist.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/constatnts.dart';
import 'empty_cart.dart';
import 'full_cart.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);
  final String routeName="/wishlistScreen";

  @override
  Widget build(BuildContext context) {

    // List products=[];
    // print(products.length);
    return BlocConsumer<WishListCubit,WishListStateS>(
      listener: (context,state){
       },
      builder: (context,state){
        WishListCubit wishListCubit= WishListCubit.get(context);
         var wishlListItems= wishListCubit.wishlistItems;
        return uId!=null?Scaffold(
          body:
          wishlListItems.isEmpty? ConditionalBuilder(
        condition: (state is GetWishListItemLoadingState),
          builder: (context)=>Center(child: CircularProgressIndicator(),),
          fallback: (context)=>EmptyWishlist(),):FullWishlist(),

        ):Scaffold(
          body: Center(
            child:Card(
              child: Text(' Register to use All Features 😊'),
            ),
          ),
        );
      },

    );
  }
}
