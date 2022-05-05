import 'package:badges/badges.dart';
import 'package:ecommerceapplication/screens/feeds_dialog.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:ecommerceapplication/shared/provider/layout_provider.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/product_model.dart';
import '../../shared/cubit/dark_cubit/dark_cubit.dart';
import '../Cart.dart';



class FeedsUserScreen extends StatelessWidget {
  FeedsUserScreen({Key? key, argument}) : super(key: key);
  static const routeName = '/FeedsUserScreen';

  @override
  Widget build(BuildContext context) {
    // LayoutProvider provider=Provider.of<LayoutProvider>(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        String? popular = ModalRoute.of(context)?.settings.arguments.toString();

        HomeCubit cubit = HomeCubit.get(context);
        var model = cubit.products;

        if (popular == 'popular') {
          model = cubit.getPopular();
        }

        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                "Feeds",
                style: TextStyle(color: Theme.of(context).textSelectionColor),
              ),
              actions: [
                wishListListener(widget: WishListScreen(), context: context),
                cartListener(
                  widget: CartScreen(),
                  context: context,
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8, top: 8),
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 190 / 330,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(model.length,
                          (index) => productItem(context, model[index], index)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            )

            // StaggeredGridView.countBuilder(
            //   crossAxisCount: 4,
            //   itemCount: 10,
            //    itemBuilder: (BuildContext context, int index) => productItem(context),
            //   staggeredTileBuilder: (int index) =>
            //    StaggeredTile.count(2, index.isEven ?3.3  : 4),
            //   mainAxisSpacing: 10.0,
            //   crossAxisSpacing: 10.0,
            // )

            );
      },
    );
  }
}

Widget productItem(context, ProductModel model, index) {
  var cubit = DarkCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      onTap: () {
        Navigator.pushNamed(context, ProductsDetails.routeName,
            arguments: model.id);
        // navigateAndFinish(
        //     context,
        //     ProductsDetails(
        //       title: model.title,
        //       id: model.id,
        //       categoryName: model.categoryName,
        //       description: model.description,
        //       brand: model.brand,
        //       price: model.price,
        //       quantity: model.quantity,
        //       imageUrl: model.imageUrl,
        //       inFavorite: model.inFavorite,
        //       inPupolar: model.inPopular,
        //       )
        //
        // );
      },
      child: Stack(
        children: [
          Container(
            width: 200,
            height: 290,
            decoration: BoxDecoration(
                color: cubit.isDark ? Colors.grey.shade700 : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                            minHeight: 100,
                            maxHeight: MediaQuery.of(context).size.height * .2),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage('${model.imageUrl}'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Positioned(
                      child: Badge(
                        animationType: BadgeAnimationType.fade,
                        toAnimate: true,
                        shape: BadgeShape.square,
                        badgeColor: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                        badgeContent:
                            Text('New', style: TextStyle(color: Colors.white)),
                      ),
                    ),

                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 8,
                        right: 8
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "${model.description}" ,
                              textAlign: TextAlign.end,
                              textScaleFactor: 1,
                              maxLines: 2,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 8,
                      ),
                      child: Text(
                        "LE ${model.price}",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Quantity : ${model.quantity}",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    ?.copyWith(
                                        fontSize: 14, fontWeight: FontWeight.w500)),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                  radius: 20,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => FeedsDialog(
                                              model: model,
                                              productId: model.docId,
                                            ));
                                  },
                                  child: Icon(
                                    Icons.more_horiz_rounded,
                                    color: Colors.grey,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              right: -5,
              top: -5,
              child:
              CircleAvatar(
                backgroundColor: Colors.amber,

                radius: 15,
                child: IconButton(
                    padding: EdgeInsets.all(0),onPressed: () {
                  HomeCubit.get(context).deleteProduct(context,productId: model.docId );
                  print(model.id);
                }, icon: Icon(Icons.close,color: Colors.red.shade700,)),
              ))

        ],
      ),
    ),
  );
}
