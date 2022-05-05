import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cart_user/feeds_user.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/emptycart.png'),
                    fit: BoxFit.fill)),
          ),
          Text(
            'Your Cart is Empty',
            style: TextStyle(
                color: Theme.of(context).textSelectionColor,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Look Likes You Didn\'t \n Add any Product To your Cart',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption?.copyWith(
                fontWeight: FontWeight.w600, fontSize: 24, height: 1.4),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .9,
            child: RaisedButton(
                child: Text(
                  'Shop NOw'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, FeedsUserScreen.routeName);
                },
                color: Colors.redAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    side: BorderSide(
                      color: Colors.red,
                    ))),
          )
        ],
      ),
    );
  }
}
