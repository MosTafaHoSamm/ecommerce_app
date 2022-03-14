import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/inner_screen/brand_rail.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/material.dart';

class BackLayerScreen extends StatelessWidget {
  const BackLayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                                  "https://cdn.vectorstock.com/i/1000x1000/44/42/person-gray-photo-placeholder-man-vector-25134442.webp"))),
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
                    widget: FeedsScreen(),
                    index: 3),
                SizedBox(height: 20,),

                content(
                     text: "Upload Product",
                    context: context,
                    widget: FeedsScreen(),
                    index: 2),
                SizedBox(height: 20,),



              ],
            ),
          ),
        ),
      ],
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

//
// class BackLayerMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//
//         SingleChildScrollView(
//           child: Container(
//             margin: EdgeInsets.all(50),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         color: Theme.of(context).backgroundColor,
//                         borderRadius: BorderRadius.circular(10.0)),
//                     child: Container(
//                       //   clipBehavior: Clip.antiAlias,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           image: DecorationImage(
//                             image: NetworkImage(
//                                 'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
//                             fit: BoxFit.fill,
//                           )),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10.0),
//                 content(context, () {
//                   navigateTo(context, Feeds.routeName);
//                 }, 'Feeds', 0),
//                 const SizedBox(height: 10.0),
//                 content(context, () {
//                   navigateTo(context, CartScreen.routeName);
//                 }, 'Cart', 1),
//                 const SizedBox(height: 10.0),
//                 content(context, () {
//                   navigateTo(context, Feeds.routeName);
//                 }, 'Wishlist', 2),
//                 const SizedBox(height: 10.0),
//                 content(context, () {
//                   navigateTo(context, Feeds.routeName);
//                 }, 'Upload a new product', 3),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   List _contentIcons = [
//     MyAppIcons.rss,
//     MyAppIcons.bag,
//     MyAppIcons.wishlist,
//     MyAppIcons.upload
//   ];
//   void navigateTo(BuildContext ctx, String routeName) {
//     Navigator.of(ctx).pushNamed(
//       routeName,
//     );
//   }
//
//   Widget content(BuildContext ctx, Function fct, String text, int index) {
//     return InkWell(
//       onTap: fct,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               text,
//               style: TextStyle(fontWeight: FontWeight.w700),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Icon(_contentIcons[index])
//         ],
//       ),
//     );
//   }
// }
