import 'package:ecommerceapplication/screens/empty_wishlist.dart';
import 'package:ecommerceapplication/screens/full_wishlist.dart';
import 'package:flutter/material.dart';

import 'empty_cart.dart';
import 'full_cart.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List products=[];
    print(products.length);
    return Scaffold(
      body: products.length==0? FullWishlist():EmptyWishlist(),

    );
  }
}
