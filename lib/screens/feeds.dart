import 'package:badges/badges.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
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

import '../models/product_model.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';

class FeedsScreen extends StatelessWidget {
  FeedsScreen({
    Key? key,
    argument
  }) : super(key: key);
  static const routeName = '/feeds';
  @override
  Widget build(BuildContext context) {

    // LayoutProvider provider=Provider.of<LayoutProvider>(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        String? popular = ModalRoute.of(context)?.settings.arguments.toString()  ;

        HomeCubit cubit = HomeCubit.get(context);
        var model = cubit.getProducts();

         if (popular == 'popular') {
          model = cubit.getPopular();
         }

        return Scaffold(
            body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      child: Container(
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
                  ),
                  child: Text(
                    "${model.description}",
                    maxLines: 2,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8,
                  ),
                  child: Text(
                    "\$ ${model.price}",
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
                              onTap: () {},
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
    ),
  );
}
