import 'package:ecommerceapplication/auth/login_screen.dart';
import 'package:ecommerceapplication/models/product_model.dart';
import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/feeds_dialog.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/screens/inner_screen/brand_rail.dart';
import 'package:ecommerceapplication/screens/inner_screen/catrgory_screen.dart';
import 'package:ecommerceapplication/screens/landing_screen.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/screens/training.dart';
import 'package:ecommerceapplication/screens/trial.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/bloc_observer.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit/dark_states.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/provider/darkProvider.dart';
import 'package:ecommerceapplication/shared/provider/layout_provider.dart';
import 'package:ecommerceapplication/shared/themes/dark_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'auth/signup/signup_cubit.dart';
import 'auth/signup/signup_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Widget widget;

  await CacheHelper.init();
  token=await CacheHelper.getSavedData(key: 'token');
  if(token!=null){
    widget=BottomNavigationBarScreen();
    print('token = $token');
  }
  else widget=LoginScreen();
  bool? isDark=CacheHelper.getSavedData(key: 'isDark');
  print(isDark);
  BlocOverrides.runZoned(
        () {
      runApp( MyApp(isDark: isDark,

      starWidget:widget ,));

    },
    blocObserver: SimpleBlocObserver(),
  );

}

class MyApp extends StatelessWidget {
  final isDark;
  final starWidget;

  const MyApp({Key? key, this.isDark,
    this.starWidget

  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)
          {

            return DarkCubit()..changeMode(fromShared: isDark);
          },),
        BlocProvider(
          create: (context)
          {

            return HomeCubit();
          },),
        BlocProvider(
          create: (context)
          {

            return CartCubit()..getCartItems();
          },),
        BlocProvider(
          create: (context)
          {

            return WishListCubit()..getWishListItems();
          },),
          BlocProvider(
          create: (context) => SignupCubit(),)
      ],
      child: BlocConsumer<DarkCubit,DarkStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=DarkCubit.get(context);
          return MaterialApp(
            routes: {
              '/feeds':(context)=>FeedsScreen(),
              '/categoryscreen':(context)=>CategoryScreen(),
              '/brandRailScreen':(context)=>BrandRailScreen(),
              "/productScreen":(context)=>ProductsDetails(),
              "/wishlistScreen":(context)=>  WishListScreen(),
              "/cartScreen":(context)=>  CartScreen(),
              '/HomeScreen':(context)=>  HomeScreen(),
              "/LoginScreen":(context)=>  LoginScreen(),
              SignupScreen.routeName:(context)=>  SignupScreen(),
              BottomNavigationBarScreen.routeName:(context)=>  BottomNavigationBarScreen(),
              "/feedsDialog":(context)=>  FeedsDialog(productId: '', ),

            },
            title: 'أسواق ياسين',
            theme: DarkTheme.themeData(context: context, isDark:cubit.isDark  ),
            home: starWidget ,


            debugShowCheckedModeBanner: false,


          );},
      ),

    );




  }
}
