import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/training.dart';
import 'package:ecommerceapplication/screens/trial.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/dark_states.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit/dark_cubit.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/provider/darkProvider.dart';
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
    return  BlocProvider(
      create: (context)
    {

      return DarkCubit()..changeMode(fromShared: isDark);
    },
      child: BlocConsumer<DarkCubit,DarkStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=DarkCubit.get(context);
          return MaterialApp(
          title: 'أسواق ياسين',
          theme: DarkTheme.themeData(context: context, isDark:cubit.isDark  ),
          home: BottomNavigationBarScreen(),
          debugShowCheckedModeBanner: false,


        );},
       ),
    );




  }
}
