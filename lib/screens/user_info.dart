import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/auth/login_screen.dart';
import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/auth/signup/signup_screen.dart';
import 'package:ecommerceapplication/auth/signup/signup_states.dart';
import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/trail_screen.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/themes/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/signupModel.dart';
import '../shared/components/components.dart';
import '../shared/cubit/dark_cubit/dark_states.dart';
import '../shared/cubit/home_cubit.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';
import '../shared/cubit/home_states.dart';
import '../shared/network/local/cache.dart';
import '../shared/themes/colors.dart';
import 'cart_user/cart_user.dart';
import 'home.dart';

class UserInfoScreen extends StatefulWidget {
  static String routeName = '/UserInfoScreen';

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController shipController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = DarkCubit.get(context);
        var cubitS = SignupCubit.get(context);
        var model = cubitS.model;

        return WillPopScope(
          onWillPop: () {
            return showExitPopup(context);
          },
          child: uId!=null?Scaffold(
            body: Stack(
              children: [
                ConditionalBuilder(
                  condition: model != null,
                  builder: (context) {
                    return Stack(
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
                                builder: (BuildContext context,
                                    BoxConstraints constraints) {
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
                                      stretchModes: [
                                        StretchMode.zoomBackground
                                      ],
                                      background: Container(
                                        child: SignupCubit.get(context)
                                                    .pickedImage !=
                                                null
                                            ? Image(
                                                image: FileImage(
                                                    SignupCubit.get(context)
                                                        .pickedImage!),
                                                fit: BoxFit.cover,
                                              )
                                            :  CachedNetworkImage(
                                          fit: BoxFit.cover,
                                            imageUrl:
                                            '${model.image}')
                                      ),
                                      //parallax means photo go with scroll at the same time
                                      //pin means go as a unit
                                      //none don't move
                                      collapseMode: CollapseMode.parallax,
                                      centerTitle: true,
                                      title: Row(
                                        children: [
                                          AnimatedOpacity(
                                              //   0:200 opened so disappera 1
                                              //    0 appear 0
                                              opacity: top <= 150 ? 1 : 0,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    height:
                                                        kToolbarHeight / 1.8,
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
                                                          fit: BoxFit.fill,
                                                          image: SignupCubit.get(
                                                                          context)
                                                                      .pickedImage !=
                                                                  null
                                                              ? FileImage(
                                                                  SignupCubit.get(
                                                                          context)
                                                                      .pickedImage!,
                                                                )
                                                              : Image.network(
                                                                  '${model.image}',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ).image,
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .40,
                                                    child: Text(
                                                      "${model.name}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textScaleFactor: .8,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22),
                                                    ),
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
                            BlocConsumer<SignupCubit, SignupStates>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  shipController.text = SignupCubit.get(context)
                                      .model
                                      .shipAddress!;
                                  phoneController.text =
                                      SignupCubit.get(context).model.phone!;
                                  nameController.text =
                                      SignupCubit.get(context).model.name!;
                                  return SliverToBoxAdapter(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 10),
                                            child: titleitem(text: "User Bag")),
                                        Divider(
                                          thickness: 2,
                                          color: Colors.grey[300],
                                        ),
                                        itemChevreon(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  WishListScreen().routeName);
                                            },
                                            color: Colors.redAccent,
                                            fontAwesome: MyIcon.wishList,
                                            text: "Wishlist",
                                            icons: icons,
                                            index: 6,
                                            onPressed: () {
                                              navigateAndFinish(
                                                  context, WishListScreen());
                                            }),
                                        itemChevreon(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  CartUserScreen.routeName);
                                            },
                                            color: Colors.amber.shade900,
                                            fontAwesome: MyIcon.shopping,
                                            text: "Cart",
                                            icons: icons,
                                            index: 6,
                                            onPressed: () {
                                              Navigator.pushNamed(context, CartUserScreen.routeName);
                                              // Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context){return CartUserScreen();}),(route)=>false);
                                            }),
                                        Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 10),
                                            child: titleitem(
                                                text: "User Information")),
                                        Divider(
                                          thickness: 2,
                                          color: Colors.grey[300],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                child: listTile(
                                                    context,
                                                    "Email",
                                                    "${model.email}",
                                                    icons,
                                                    0),
                                                onTap: () {
                                                  print(model.uId);
                                                },
                                              ),
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20))),
                                                        title: Text(
                                                          "Update Profile",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.purple,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        content:
                                                            SingleChildScrollView(
                                                          child: Form(
                                                            key: formKey,
                                                            child: ListBody(
                                                              children: [
                                                                defaultTextForm(
                                                                    height: 60,
                                                                    val: 0,
                                                                    text: SignupCubit.get(
                                                                            context)
                                                                        .model
                                                                        .name!,
                                                                    controller:
                                                                        nameController,
                                                                    key: 'name',
                                                                    icon: Icons
                                                                        .person,
                                                                    validate:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Enter your name";
                                                                      }
                                                                    }),
                                                                defaultTextForm(
                                                                    val: 0,
                                                                    height: 60,
                                                                    text: SignupCubit.get(
                                                                            context)
                                                                        .model
                                                                        .shipAddress!,
                                                                    controller:
                                                                        shipController,
                                                                    key:
                                                                        'shipping',
                                                                    icon: Icons
                                                                        .local_shipping,
                                                                    validate:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Enter valid Email";
                                                                      }
                                                                    }),
                                                                defaultTextForm(
                                                                    height: 60,
                                                                    val: 0,
                                                                    text: SignupCubit.get(
                                                                            context)
                                                                        .model
                                                                        .phone!,
                                                                    controller:
                                                                        phoneController,
                                                                    key:
                                                                        'phone',
                                                                    icon: Icons
                                                                        .phone,
                                                                    validate:
                                                                        (value) {
                                                                      if (value!
                                                                              .length <
                                                                          11) {
                                                                        return "Enter valid Phone Number";
                                                                      }
                                                                    }),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: Text('Cancel')),
                                                                      ),
                                                                      Expanded(
                                                                        child: TextButton(
                                                                            onPressed: () {
                                                                              if (formKey.currentState!.validate()) {
                                                                                SignupCubit.get(context).updateUser(
                                                                                  name: nameController.text,
                                                                                  phone: phoneController.text,
                                                                                  shipAddress: shipController.text,
                                                                                );
                                                                                Navigator.pop(context);
                                                                              }
                                                                            },
                                                                            child: Text('Update')),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                            ),
                                          ],
                                        ),
                                        listTile(context, "Phone",
                                            "${model.phone}", icons, 1),
                                        listTile(context, "Shipping Address",
                                            "${model.shipAddress}", icons, 2),
                                        listTile(context, "Joined data",
                                            "${model.dateJoined}", icons, 3),
                                        Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                start: 10),
                                            child: titleitem(
                                                text: "User Settings")),
                                        Divider(
                                          thickness: 2,
                                          color: Colors.grey[300],
                                        ),
                                        SwitchListTile(
                                            visualDensity:
                                                VisualDensity.comfortable,
                                            secondary:
                                                Icon(FontAwesomeIcons.moon),
                                            title: Text("Dark Mode"),
                                            value: cubit.isDark,
                                            onChanged: (value) {
                                              cubit.changeMode();
                                            }),
                                        listTile(
                                            context, 'SignOut', '', icons, 5,
                                            onPressed: () {
                                          // Navigator.canPop(context)
                                          //     ? Navigator.pop(context)
                                          //     : null;
                                          SignupCubit.get(context)
                                              .logOut(context);
                                        }),
                                        SizedBox(
                                          height: 60,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        fabBuild(),
                      ],
                    );
                  },
                  fallback: (context) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                ),
                state is UploadProfilePhotoLoadingState
                    ? Center(
                        child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(.3)),
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 1,
                            )))
                    : Container()
              ],
            ),
          ):Scaffold(
            body: Center(
              child: Card(
                child :Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Register to use All Features 😊'),
                      SizedBox(height: 15,),
                      OutlinedButton(autofocus: true,
                        
                          style: ButtonStyle(

                               shape: MaterialStateProperty.all<OutlinedBorder> (RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20),
                          )))),
                          onPressed: (){
                        Navigator.pushNamed(context, SignupScreen.routeName);
                      }, child: Text('Register Now' ))
                    ],
                  ),
                ),
              ),
            ),
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
        child: Row(
          children: [
            SignupCubit.get(context).pickedImage != null
                ? CircleAvatar(

                    // backgroundColor: Colors.transparent,

                    child: IconButton(
                        onPressed: () {
                          SignupCubit.get(context).uploadPhoto();
                        },
                        icon: Icon(
                          Icons.cloud_upload_outlined,
                          color: Colors.green,
                        )))
                : Container(),
            SizedBox(width: 10),
            FloatingActionButton(
                heroTag: 'Hero1',
                backgroundColor:
                    cubit.isDark ? Colors.lightBlueAccent : Colors.blue,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Choose Option",
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.w500),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                InkWell(
                                  onTap: () {
                                    SignupCubit.get(context).getImageCamera();

                                    Navigator.pop(context);
                                  },
                                  splashColor: Colors.purple,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.camera,
                                          color: ColorsConsts.gradiendFStart,
                                        ),
                                      ),
                                      Text(
                                        "Camera",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    SignupCubit.get(context).getImageGallery();

                                    Navigator.pop(context);

                                    // print(SignupCubit.get(context).userModel.name);
                                    // print(SignupCubit.get(context).userModel.uId);
                                    // print(SignupCubit.get(context).userModel.image);
                                    // print(SignupCubit.get(context).userModel.phone);
                                    // print(SignupCubit.get(context).userModel.email);
                                    print('error');
                                  },
                                  //

                                  splashColor: Colors.purple,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.image,
                                          color: ColorsConsts.gradiendFStart,
                                        ),
                                      ),
                                      Text(
                                        "gallery",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  print('ok');
                  // Navigator.pushNamed(context, TrialScreen.routeName);
                },
                child: Icon(Icons.photo_camera_outlined)),
          ],
        ),
      ),
    );
  }
}

Widget listTile(BuildContext context, title, subtitle, List icons, index,
    {Function()? onPressed}) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Theme.of(context).splashColor,
      onTap: onPressed,
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

Widget itemChevreon(
    {fontAwesome, index, icons, text, onPressed, color, onTap}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
        leading: Icon(
          fontAwesome,
          color: color,
        ),
        trailing: IconButton(onPressed: onPressed, icon: Icon(icons[index])),
        title: Text(text)),
  );
}
