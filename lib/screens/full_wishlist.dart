import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/models/wishlist_model.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/cubit/dark_cubit/dark_cubit.dart';
import '../shared/cubit/dark_cubit/dark_states.dart';

class FullWishlist extends StatelessWidget {
  const FullWishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarkCubit, DarkStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DarkCubit.get(context);
        var cubitWishList = WishListCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: Text("WishList"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(MyIcon.trash),
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: cubitWishList.wishlistItems.length > 0,
              builder: (context) {
                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => wishItem(
                        context,
                        cubitWishList.wishlistItems.values.toList()[index],
                        index),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: cubitWishList.wishlistItems.length);
              },
              fallback: (context) {
                return Center(
                  child: CupertinoActivityIndicator(
                      color: Colors.lightBlueAccent, radius: 30),
                );
              },
            ));
      },
    );
  }
}

Widget wishItem(context, WishListItemModel wishlistModel, index) {
  return Stack(
    children: [
      Container(
        margin: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        // height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            onTap: () {},
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.network(

                    wishlistModel.imageUrl,
                    height: 80,
                    ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Text(
                        wishlistModel.title,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "\$ ${wishlistModel.price}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      positionedRemove()
    ],
  );
}

Widget positionedRemove() {
  return Positioned(
    right: 10,
    top: 20,
    child: Container(
      height: 30,
      width: 30,
      child: MaterialButton(
          color: Colors.red,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Icon(Icons.close)),
    ),
  );
}
