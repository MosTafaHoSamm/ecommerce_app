import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/components/components.dart';
import '../shared/cubit/dark_cubit.dart';
import '../shared/cubit/dark_states.dart';
import '../shared/cubit/home_cubit/dark_cubit.dart';
import '../shared/network/local/cache.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late ScrollController scrollController;
  List<IconData> icons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping_rounded,
    Icons.watch_later,
    Icons.brightness_4_outlined,
    FontAwesomeIcons.signOutAlt,
    Icons.chevron_right,
    Icons.shopping_bag_rounded
  ];

  var top = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DarkCubit, DarkStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DarkCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                slivers: [
                  SliverAppBar(
                    stretch: true,

                    expandedHeight: 200,
                    elevation: 4,
                    // to specify app bar fixed or scroll and dis appear
                    pinned: true,
                    automaticallyImplyLeading: false,

                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        top = constraints.biggest.height;
                        print(top.toInt());
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlue.shade200,
                                Colors.blue.shade700,
                              ],
                              end: FractionalOffset(0, 0),
                              begin: FractionalOffset(1, 0),
                              tileMode: TileMode.clamp,
                              stops: [0, 1],
                            ),
                          ),
                          child: FlexibleSpaceBar(
                            stretchModes: [StretchMode.zoomBackground],
                            background: Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-vector/avatar-'
                                  'profile-icon_188544-4755.jpg?w=740'),
                              fit: BoxFit.fill,
                            ),
                            //parallax means photo go with scroll at the same time
                            //pin means go as a unit
                            //none don't move
                            collapseMode: CollapseMode.parallax,
                            centerTitle: true,
                            title: Row(
                              children: [
                                AnimatedOpacity(
                                    //0:200 opened so disappera 1
                                    //0 appear 0
                                    opacity: top <= 150 ? 1 : 0,
                                    duration: Duration(milliseconds: 300),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Container(
                                          height: kToolbarHeight / 1.8,
                                          width: kToolbarHeight / 1.8,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 2,
                                                )
                                              ],
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      'https://cdn-icons-png.flaticon.com/512/992/992490.png?w=740'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          "Guest",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: titleitem(text: "User Bag")),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        itemChevreon(
                          color: Colors.redAccent,
                            fontAwesome: MyIcon.wishList,
                            text: "Wishlist",
                            icons: icons,
                            index: 6,
                            onPressed: () {
                              navigateAndFinish(context,WishListScreen());
                            }),
                        itemChevreon(
                          color: Colors.amber.shade900,
                            fontAwesome: MyIcon.shopping,
                            text: "Cart"
                            ,
                            icons: icons,
                            index: 6,
                            onPressed: () {}),
                        Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: titleitem(text: "User Information")),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        listTile(
                            context, "Email", "There is No Email", icons, 0),
                        listTile(
                            context, "Phone", "There is No phone", icons, 1),
                        listTile(context, "Shipping Address",
                            "There is No Shipping Address", icons, 2),
                        listTile(context, "Joined data",
                            "There is No Joined data", icons, 3),
                        Padding(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            child: titleitem(text: "User Settings")),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        SwitchListTile(
                            visualDensity: VisualDensity.comfortable,
                            secondary: Icon(FontAwesomeIcons.moon),
                            title: Text("Dark Mode"),
                            value: cubit.isDark,
                            onChanged: (value) {
                              cubit.changeMode();
                            }),
                        listTile(context, 'SignOut', '', icons, 5),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              fabBuild(),
            ],
          ),
        );
      },
    );
  }

  Widget fabBuild() {
    var cubit = DarkCubit.get(context);
    final double defaultTopMargin = 200.0 - 4;
    final double scaleStart = 160;
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      top = top - offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - offset - scaleEnd) / scaleEnd;
      } else {
        scale = 0;
      }
    }

    return Positioned(
      // not defaultTop Because its variable to move fab when slide
      top: top,
      right: 16,
      child: Transform(
        alignment: Alignment.center,
        //to shrink fabButton
        transform: Matrix4.identity()..scale(scale),
        child: FloatingActionButton(
          heroTag: 'Hero1',
            backgroundColor:
                cubit.isDark ? Colors.lightBlueAccent : Colors.blue,
            onPressed: () {
              CacheHelper.removeData(key: 'isDark');
            },
            child: Icon(Icons.photo_camera_outlined)),
      ),
    );
  }
}

Widget listTile(
  BuildContext context,
  title,
  subtitle,
  List icons,
  index,
) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Theme.of(context).splashColor,
      onTap: () {},
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(icons[index]),
      ),
    ),
  );
}

Widget titleitem({required String text}) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Text(
      text,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    ),
  );
}

Widget itemChevreon({fontAwesome, index, icons, text, onPressed,color}) {
  return ListTile(
      leading: Icon(
        fontAwesome,
        color: color,
      ),
      trailing: IconButton(onPressed: onPressed, icon: Icon(icons[index])),
      title: Text(text));
}
