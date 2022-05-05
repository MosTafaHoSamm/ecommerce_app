import 'package:badges/badges.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import '../cubit/wishlist_cubit/wishlist_cubit.dart';
import '../cubit/wishlist_cubit/wishlist_states.dart';

void navigateAndFinish(context,widget){

  Navigator.push(context, MaterialPageRoute(builder: (context){return widget;}));
}
showAlertDialog({
  required Function() ok,
  required Function() cancel,

  required context,
  required String title,
  required String subtitle,
}){
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title:Row(
            children: [
              Image.network('https://cdn-icons-png.flaticon.com/512/564/564619.png',width: 20,height: 20,),
              SizedBox(width: 10,),
              Text(title),
            ],
          ) ,
          content: Text(subtitle),
          actions: [
            TextButton(onPressed: ok, child: Text("Ok")),
            TextButton(onPressed: cancel, child: Text("Cancel")),
          ],

        );
      }
  );

  // return AlertDialog(
  //
  //   title: Text(title),
  //   content:Text(subtitle)
  //
  // ) ;
}
Widget cartListener(
    {
      required context,
      required Widget widget,

    }
    ){
  return IconButton(
    onPressed: () {
      navigateAndFinish(context, widget);
    },
    icon: BlocConsumer<CartCubit,CartStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubitCart=CartCubit.get(context);
          return  Badge(
              animationDuration: Duration(seconds: 3),
              animationType: BadgeAnimationType.slide,
              position: BadgePosition.topEnd(top: -15,end: -13),
              toAnimate: true,
              badgeColor: Colors.redAccent,
              badgeContent: Text("${cubitCart.cartItems.length}",style: TextStyle(color: Theme.of(context).textSelectionColor),),
              child: Icon(
                FontAwesomeIcons.shoppingCart,
                color: Theme.of(context).textSelectionColor,
              ));}),);
}
Widget wishListListener(
    {
      required context,required Widget widget
    }
    ){
  return IconButton(
    onPressed: () {
      navigateAndFinish(context, widget);
    },
    icon: BlocConsumer<WishListCubit,WishListStateS>(
      listener: (context,state){},
      builder: (context,state){
        var wishListCubit=WishListCubit.get(context);
        return  Badge(
          animationDuration: Duration(seconds: 3),
          animationType: BadgeAnimationType.slide,
          position: BadgePosition.topEnd(top: -15,end: -13),
          toAnimate: true,
          badgeColor: Colors.redAccent,
          badgeContent: Text("${wishListCubit.wishlistItems.length}",style: TextStyle(color: Theme.of(context).textSelectionColor),),
          child: Icon(
            FontAwesomeIcons.solidHeart,
            color: Colors.red,
          ),
        );
      },),);
}
Widget defaultTextForm({

  TextInputAction? action,
FocusNode? focusNode,
  TextInputType? type,
  required String text,
  required TextEditingController controller,
  required String key,
  required IconData icon,
    IconData? suffix,
    bool isSecure=false,
      required  String ? Function ( String? value) validate,
  Function()?suffixPressed,
    Function()?onEditingComplete,
    Function(String value)?onSubmit,
  Function(String? value)?onSaved,
  double val =20.0,
  double height =50.0,

}){
  return Padding(
    padding:   EdgeInsets.symmetric(vertical: 5.0,horizontal:val),
    child: Container(
      
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [BoxShadow(color: Colors.grey,offset: Offset(2,2),blurRadius: 3,spreadRadius: 1)]),
      height: height,
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmit,
        textInputAction: action,
        focusNode: focusNode,
        onSaved: onSaved,
        onEditingComplete : onEditingComplete,
        key: Key(key),
        keyboardType: type,
        validator: validate ,
        obscureText: isSecure,
        maxLines: 1,
        style: TextStyle(color: Colors.black),

        decoration: InputDecoration(

            border: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.all(Radius.circular(20)) ),
            prefixIcon: Icon(
              icon,color: Colors.grey,size: 12,),
            // label: Text("email"),
            filled: true,
            fillColor: Colors.white,
            hintText: text,
          hintStyle: TextStyle(fontSize: 12),
          suffixIcon: suffix!=null?IconButton(onPressed:suffixPressed,icon: Icon(suffix,color: Colors.grey,)):null,

        ),
      ),
    ),
  );
}

