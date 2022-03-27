import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/inner_screen/brand_rail.dart';
import 'package:ecommerceapplication/screens/inner_screen/catrgory_screen.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/screens/training.dart';
import 'package:ecommerceapplication/screens/trial.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit/dark_states.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_states.dart';
 import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/provider/darkProvider.dart';
import 'package:ecommerceapplication/shared/provider/layout_provider.dart';
import 'package:ecommerceapplication/shared/themes/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  bool? isDark=CacheHelper.getSavedData(key: 'isDark');
  print(isDark);
   runApp( MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
  final isDark;
  const MyApp({Key? key, this.isDark,}) : super(key: key);

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

              },
            title: 'أسواق ياسين',
            theme: DarkTheme.themeData(context: context, isDark:cubit.isDark  ),
            home: BottomNavigationBarScreen(),
            debugShowCheckedModeBanner: false,


          );},
         ),

    );




  }
}
