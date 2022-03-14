import 'package:ecommerceapplication/shared/cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/dark_states.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/cubit/home_cubit/dark_cubit.dart';

class FullCart extends StatelessWidget {
  const FullCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarkCubit, DarkStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DarkCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart Item Count"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(MyIcon.trash),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 65),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return itemBuild(context);
                }),
          ),
          bottomSheet: checkOutElement(context),
        );
      },
    );
  }

  Widget checkOutElement(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(colors: [
                    ColorsConsts.gradiendLEnd,
                    ColorsConsts.gradiendLStart,
                  ],
                  stops: [0,0.5])
                ),
                 child: Material(
                   color: Colors.transparent,
                  child: InkWell(

                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "CheckOut".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorsConsts.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '\$ 54821.36 ',
              style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
 }
Widget itemBuild(context){
  var cubit=DarkCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(

      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(20),
          ),
          color: Theme.of(context).backgroundColor),
      width: double.infinity,
      height: 130,
      child: Row(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4PdHtXka2-bDDww6Nuect3Mt9IwpE4v4HNw&usqp=CAU"),
                    fit: BoxFit.fill)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Shooes',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                            radius: 10,
                            splashColor:
                            Theme.of(context).splashColor,
                            onTap: () {},
                            child: Icon(
                              MyIcon.close,
                              color: Colors.red,
                              size: 20,
                            )),
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'price',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '450 \$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: cubit.isDark
                                ? Colors.brown
                                : Colors.blueAccent),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'sub Total :',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '54821.36 \$',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            color: cubit.isDark
                                ? Colors.brown
                                : Colors.blueAccent),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'ships free',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Spacer(),
                      Material(
                        borderRadius: BorderRadius.all(
                            Radius.circular(100)),
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.all(
                                Radius.circular(40)),
                            radius: 100,
                            splashColor:
                            Theme.of(context).splashColor,
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.minus,
                              color: Colors.redAccent,
                              size: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40)),
                              gradient: LinearGradient(colors: [
                                ColorsConsts.gradiendLStart,
                                ColorsConsts.gradiendLEnd,
                              ], stops: [
                                0.0,
                                .5
                              ])),
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              .12,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "1",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.all(
                            Radius.circular(40)),
                        color: Colors.transparent,
                        child: InkWell(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20)),
                            radius: 50,
                            splashColor:
                            Theme.of(context).splashColor,
                            onTap: () {},
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.green.shade700,
                              size: 16,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}


