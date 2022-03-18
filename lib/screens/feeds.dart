import 'package:badges/badges.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/components/components.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
  import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../shared/cubit/home_cubit/dark_cubit.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);
  static const routeName='/feeds';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(crossAxisCount: 2,
                childAspectRatio: 190/290,
                mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                children: List.generate(10, (index) => productItem(context)),),
              ),
            ),
            SizedBox(height: 10,)
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
  }
}

Widget productItem(context) {
  var cubit=DarkCubit.get(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: InkWell(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      onTap: (){
        navigateAndFinish(context, ProductsDetails());
      },
      child: Container(
        width: 250,
        height: 290,
        decoration: BoxDecoration(
            color:cubit.isDark? Colors.grey.shade700:Colors.white,
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
                            image: NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU'),
                            fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                   child: Badge(animationType: BadgeAnimationType.fade,
                    toAnimate: true,
                    shape: BadgeShape.square,
                    badgeColor: Colors.red,
                    borderRadius: BorderRadius.circular(30),
                    badgeContent: Text('New', style: TextStyle(color: Colors.white)),
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
                    "Description",
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
                    "\$ 1235.99",
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
                        Text("Quantity : 12",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 14,fontWeight: FontWeight.w500)),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              radius: 20,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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
