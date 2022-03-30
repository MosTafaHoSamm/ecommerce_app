import 'package:ecommerceapplication/models/wishlist_model.dart';
import 'package:ecommerceapplication/screens/empty_wishlist.dart';
import 'package:ecommerceapplication/screens/full_wishlist.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      listener: (context,state){},
      builder: (context,state){
        WishListCubit wishListCubit= WishListCubit.get(context);
        Map<String,WishListItemModel>wishlListItems= wishListCubit.wishlistItems;
        return Scaffold(
          body: wishlListItems.length==0? EmptyWishlist():FullWishlist(),

        );
      },

    );
  }
}
