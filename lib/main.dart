import 'package:ecommerceapplication/auth/login_screen.dart';
import 'package:ecommerceapplication/models/product_model.dart';
import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/cart_user/cart_user.dart';
import 'package:ecommerceapplication/screens/cart_user/feeds_user.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/feeds_dialog.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/screens/inner_screen/brand_rail.dart';
import 'package:ecommerceapplication/screens/inner_screen/catrgory_screen.dart';
import 'package:ecommerceapplication/screens/landing_screen.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/screens/trail_screen.dart';
import 'package:ecommerceapplication/screens/training.dart';
import 'package:ecommerceapplication/screens/trial.dart';
import 'package:ecommerceapplication/screens/user_info.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'auth/phone_verification/phone_verification_screen.dart';
import 'auth/signup/signup_cubit.dart';
import 'auth/signup/signup_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Mesaging ......................');
  Fluttertoast.showToast(msg: message.notification!.title.toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseMessaging.instance.deleteToken();
  var fcmToken = await FirebaseMessaging.instance.getToken();
  print('device id : ${fcmToken}');
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data);
    print('onMessage');
    Fluttertoast.showToast(

      toastLength: Toast.LENGTH_LONG,
      fontSize: 20,
      backgroundColor: Colors.deepOrange.withOpacity(.7),
        msg: event.notification!.body.toString());


    Fluttertoast.showToast(
        msg: '${event.notification?.title}',
        backgroundColor: Colors.green,
        gravity: ToastGravity.BOTTOM);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    Fluttertoast.showToast(msg: 'onMessageOpenedApp');
    print('onMessageOpenedApp');
  });

  Widget widget;
  // print('is...............${FirebaseAuth.instance.currentUser!.emailVerified}');

  await CacheHelper.init();
  uId = CacheHelper.getSavedData(key: 'uId');
  if (uId != null) {
    widget = BottomNavigationBarScreen();
  } else
    widget = LandingScreen();
  bool? isDark = CacheHelper.getSavedData(key: 'isDark');
  print(isDark);
  print('token = $uId');

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
        starWidget: widget,
      ));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final isDark;
  final starWidget;

  const MyApp({Key? key, this.isDark, this.starWidget}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return DarkCubit()..changeMode(fromShared: isDark);
          },
        ),
        BlocProvider(
          create: (context) {
            return SignupCubit()
              ..getUserData()
              ..printName();
          },
        ),
        BlocProvider(
          create: (context) {
            return HomeCubit()..getProducts();
          },
        ),
        BlocProvider(create: (context) => CartCubit()..getCartItems()),
        BlocProvider(
          create: (context) => WishListCubit()..getWishListItems(),
        ),
      ],
      child: BlocConsumer<DarkCubit, DarkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DarkCubit.get(context);
          return MaterialApp(
            routes: {
              '/feeds': (context) => FeedsScreen(),
              '/categoryscreen': (context) => CategoryScreen(),
              '/brandRailScreen': (context) => BrandRailScreen(),
              "/productScreen": (context) => ProductsDetails(),
              "/wishlistScreen": (context) => WishListScreen(),
              "/cartScreen": (context) => CartScreen(),
              '/HomeScreen': (context) => HomeScreen(),
              "/LoginScreen": (context) => LoginScreen(),
              "/CartUserScreen": (context) => CartUserScreen(),
              "/FeedsUserScreen": (context) => FeedsUserScreen(),
              TrialScreen.routeName: (context) => TrialScreen(),
              LandingScreen.routeName: (context) => LandingScreen(),
              PhoneScreen.routeName: (context) => PhoneScreen(),
              UserInfoScreen.routeName: (context) => UserInfoScreen(),
              SignupScreen.routeName: (context) => SignupScreen(),
              BottomNavigationBarScreen.routeName: (context) =>
                  BottomNavigationBarScreen(),
              "/feedsDialog": (context) => FeedsDialog(
                    productId: '',
                  ),
            },
            title: 'أسواق ياسين',
            theme: DarkTheme.themeData(context: context, isDark: cubit.isDark),
            home: starWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
