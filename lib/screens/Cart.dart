import 'package:flutter/material.dart';

import 'empty_cart.dart';
import 'full_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List products=[];
    print(products.length);
    return Scaffold(
      body: products.length>0? FullCart():EmptyCart(),

    );
  }
}
