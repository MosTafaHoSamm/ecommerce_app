import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/inner_screen/brand_rail.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/material.dart';

import '../add_product.dart';

class BackLayerScreen extends StatelessWidget {
  const BackLayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return uId!=null?Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsConsts.gradiendLStart,
                ColorsConsts.gradiendLEnd,
              ],
              stops: [0, 1],
              tileMode: TileMode.clamp,
              end: FractionalOffset(1, 1),
              begin: FractionalOffset(0, 1),
            ),
          ),
        ),
        Positioned(
          top: -100,
          left: 140,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white.withOpacity(0.3)),
            ),
          ),
        ),
        Positioned(
          top: -100,
          left: 50,
          child: Transform.rotate(
            angle: -0.5,
            child: Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white.withOpacity(0.3)),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 100,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white.withOpacity(0.3)),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 20,
          child: Transform.rotate(
            angle: -0.8,
            child: Container(
              height: 250,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white.withOpacity(0.3)),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(50),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  SignupCubit.get(context).model!=null? SignupCubit.get(context).model.image!:'https://firebasestorage.googleapis.com/v0/b/yassen-souq.appspot.com/o/users%2Fimage_picker1604009454.jpg?alt=media&token=1b4c7649-110f-442b-b0a6-4ae7b7004c42') )),
                    ),
                  ),
                ),
                content(
                    text: "Feeds",
                    context: context,
                    widget: FeedsScreen(),
                    index: 0),
                SizedBox(height: 20,),
                content(
                     text: "Cart",
                    context: context,
                    widget: CartScreen(),
                    index: 1),
                SizedBox(height: 20,),

                content(
                    text: "WishList",
                    context: context,
                    widget: WishListScreen(

                    ),
                    index: 3),
                SizedBox(height: 20,),

                (adminTkens.contains(uId))? content(
                    text: "Upload Product",
                    context: context,
                    widget: AddProductScreen(),
                    index: 2):Container(),
                SizedBox(height: 100,),



              ],
            ),
          ),
        ),
      ],
    ):Scaffold(
      body: Center(
        child:Card(
          child: Text(' Register to use All Features ????'),
        ),
      ),
    );
  }
}

void navigateTo(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

List<IconData> icons = [
  MyIcon.feeds,
  MyIcon.shopping,
  MyIcon.upload,
  MyIcon.wishList,
];
Widget content(
    {required Widget widget,
    required String text,
    required context,
     index}) {
  return InkWell(
    onTap: () {
      navigateTo(context, widget);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(text,style: TextStyle(fontWeight: FontWeight.w600),),
        ),
        Icon(icons[index],color: index==3?Colors.redAccent:Colors.black,)
      ],
    ),
  );
}
