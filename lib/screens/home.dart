import 'package:backdrop/backdrop.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_states.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/product_model.dart';
import '../shared/cubit/home_cubit.dart';
import '../shared/cubit/dark_cubit/dark_states.dart';
import '../shared/cubit/home_states.dart';
import 'back_layer/back_layer.dart';
import 'cart_widget.dart';
import 'inner_screen/brand_rail.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  static String routeName='/HomeScreen';
  var controller = PageController();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  List images = [
    'assets/images/addidas.jpg',
    'assets/images/apple.jpg',
    'assets/images/Dell.jpg',
    'assets/images/h&m.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
    'assets/images/hh.jpg',
  ];
  List<Widget> imageSliders = [
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('assets/images/carousel4.png'))),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('assets/images/carousel1.png'))),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ExactAssetImage('assets/images/carousel2.jpeg'))),
    ),
    Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/carousel3.jpg"))),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var model = cubit.getPopular();
        return Scaffold(
            body: Center(
                child: BackdropScaffold(
                  headerHeight: MediaQuery.of(context).size.height * .25,
                  backgroundColor: Colors.blue,
                  appBar: BackdropAppBar(
                    flexibleSpace: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            ColorsConsts.gradiendLStart,
                            ColorsConsts.gradiendLEnd,
                          ])),
                    ),
                    backgroundColor: Colors.grey.shade300,
                    leading: BackdropToggleButton(
                      icon: AnimatedIcons.home_menu,
                    ),
                    title: Text(
                      "Yassen SouQ",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 15,
                          child: CircleAvatar(
                            radius: 13,
                            backgroundImage: NetworkImage(
                              'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg',
                            ),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  backLayerBackgroundColor: Colors.lightBlueAccent,
                  backLayer: BackLayerScreen(),
                  frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  frontLayer: BlocProvider(
                    create: (BuildContext context) {
                      return HomeCubit();
                    },
                    child: BlocConsumer<HomeCubit, HomeStates>(
                      listener: (context, state) => {},
                      builder: (context, state) {
                        return Container(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CarouselSlider(
                                      items: imageSliders,
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                          initialPage: 0,
                                          autoPlayAnimationDuration:
                                          Duration(milliseconds: 750),
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          viewportFraction: 1,
                                          height: 200,
                                          autoPlay: true,
                                          enlargeCenterPage: true,
                                          aspectRatio: 2.0,
                                          onPageChanged: (index, reason) {
                                            HomeCubit.get(context).dotSlide(index);
                                            _current = HomeCubit.get(context).current;
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:
                                      imageSliders.asMap().entries.map((entry) {
                                        return GestureDetector(
                                          onTap: () => controller.animateToPage(
                                              entry.key,
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.fastLinearToSlowEaseIn),
                                          child: Container(
                                            width: 12.0,
                                            height: 12.0,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 4.0),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                    ? Colors.white
                                                    : Colors.lightBlueAccent)
                                                    .withOpacity(_current == entry.key
                                                    ? 0.9
                                                    : 0.4)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                            fontSize: 15, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: double.infinity,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return CartItem(
                                              index: index,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              width: 5,
                                            );
                                          },
                                          itemCount: CartItem.cartItem.length.toInt()),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Popular Brands',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, BrandRailScreen.routeName,
                                                  arguments: 7);
                                            },
                                            child: Text(
                                              'View all ...',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.redAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * .95,
                                      height: 210,
                                      child: Swiper(
                                        onTap: (index) {
                                          Navigator.pushNamed(
                                              context, BrandRailScreen.routeName,
                                              arguments: index);
                                          // Navigator.of(context).pushNamed(BrandRailScreen.routeName,arguments: {index});
                                        },
                                        itemBuilder: (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                              child: Container(
                                                color: Colors.blueGrey,
                                                child: Image.asset(
                                                  images[index],
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        viewportFraction: 0.9,
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        autoplay: true,
                                        itemCount: images.length,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Popular Products',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, FeedsScreen.routeName,
                                                  arguments: 'popular');
                                            },
                                            child: Text(
                                              'View all ...',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.redAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 300,
                                      width: double.infinity,
                                      child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (context, index) => SizedBox(
                                          width: 0,
                                        ),
                                        itemBuilder: (context, index) => popularProduct(
                                            context, cubit.getPopular()[index]),
                                        itemCount: cubit.getPopular().length,
                                      ),
                                    ),
                                  ]),
                            ));
                      },
                    ),
                  ),
                )));
      },
    );
  }
}

Widget popularProduct(context, ProductModel model) {
  return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        CartCubit cartCubit = CartCubit.get(context);
        WishListCubit wishListCubit = WishListCubit.get(context);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  10.0,
                ),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    10.0,
                  ),
                  bottomRight: Radius.circular(10.0),
                ),
                onTap: () {
                  Navigator.pushNamed(context, ProductsDetails.routeName,
                      arguments: model.id);

                  // Navigator.pushAndRemoveUntil(
                  //     context,MaterialPageRoute(
                  //   builder: (context)
                  //   {
                  //     return ProductsDetails(
                  //       title: model.title,
                  //       brand: model.brand,
                  //       categoryName: model.categoryName,
                  //       description: model.description,
                  //       imageUrl: model.imageUrl,
                  //       price: model.price,
                  //       quantity: model.quantity,
                  //       inFavorite: model.inFavorite,
                  //       id: model.id,
                  //       inPupolar: model.inPopular,);},),(route)=>true );
                },
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 170,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('${model.imageUrl}'),
                                  fit: BoxFit.fill)),
                        ),
                        Positioned(
                          right: 12,
                          top: 10,
                          child: Icon(
                            FontAwesomeIcons.star,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 7,
                          child: InkWell(
                            onTap: (){
                              wishListCubit.addNewItemToWishList(
                                  id: model.id,
                                  title: model.title,
                                  imageUrl: model.imageUrl,
                                  price: model.price);
                            },
                            child: Icon(
                              FontAwesomeIcons.star,
                              color: wishListCubit.wishlistItems.containsKey(model.id)?Colors.red:Colors.white,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          bottom: 32.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            color: Theme.of(context).backgroundColor,
                            child: Text(
                              '\$ ${model.price}',
                              style: TextStyle(
                                color: Theme.of(context).textSelectionColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${model.title}',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Text(
                                  '${model.description}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap:
                                  cartCubit.cartItems.containsKey(model.id)
                                      ? () {}
                                      : () {
                                    cartCubit.addNewItemToCart(
                                        id: model.id,
                                        title: model.title,
                                        imageUrl: model.imageUrl,
                                        price: model.price);
                                  },
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: cartCubit.cartItems
                                        .containsKey(model.id)
                                        ? Icon(
                                      Icons.check_circle_rounded,
                                      color: Colors.lightBlueAccent,
                                    )
                                        : Icon(
                                      FontAwesomeIcons.cartPlus,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
