import 'dart:io';

import 'package:ecommerceapplication/auth/signup/signup_screen.dart';
import 'package:ecommerceapplication/auth/signup/signup_states.dart';
import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/search.dart';
import 'package:ecommerceapplication/screens/user_info.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/signup/signup_cubit.dart';
import '../shared/components/components.dart';
import '../shared/components/constatnts.dart';
import '../shared/cubit/dark_cubit/dark_cubit.dart';
import '../shared/themes/icons.dart';
import 'home.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  static String routeName = '/BottomNavigationBarScreen';

  @override
  _BottomNavigationBarScreenState createState() {
    return _BottomNavigationBarScreenState();
  }
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late List<Map<String, Widget>> screens;
  var otpController = TextEditingController();
  bool otpVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    screens = [
      {
        'page': HomeScreen(),
      },
      {
        'page': FeedsScreen(),
      },
      {
        'page': Search(),
      },
      {
        'page': CartScreen(),
      },
      {
        'page': UserInfoScreen(),
      },
    ];
    super.initState();
  }

  void selectScreen(index) {
    setState(() {
      if (index == 4) {


        print('uid Saved ${uId}');
       }

      currentIndex = index;
    });
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = DarkCubit.get(context);
    return BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor:
                    cubit.isDark ? Colors.lightBlueAccent : Colors.blue,
                hoverElevation: 100,
                elevation: 4,
                splashColor: Colors.grey,
                tooltip: "Search",
                child: Icon(MyIcon.search),
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                    print(currentIndex.toString());
                  });
                },
              ),
              bottomNavigationBar: BottomAppBar(

                elevation: 10,
                notchMargin: 6,
                clipBehavior: Clip.antiAlias,
                shape: CircularNotchedRectangle(),
                child: Container(
                  height:1 * kBottomNavigationBarHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.grey, width: .7))),
                  child: BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      // if(index==0){SignupCubit.get(context).getUser();}
                      selectScreen(index);
                    },

                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(MyIcon.home), label: "Home"),
                      BottomNavigationBarItem(
                          icon: Icon(MyIcon.feeds), label: "Feeds"),
                      BottomNavigationBarItem(
                        icon: Icon(null),
                        label: 'search',
                        activeIcon: Icon(null),
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(MyIcon.shopping), label: 'Shopping'),
                      BottomNavigationBarItem(
                          icon: Icon(MyIcon.user), label: 'Person'),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniCenterDocked,
              body: Stack(
                children: [
                  screens[currentIndex]['page']!,
                  // FirebaseAuth.instance.currentUser!.emailVerified
                  //    ? Container()
                  //    : Column(
                  //        children: [
                  //          Container(
                  //            margin: EdgeInsets.only(top: 79),
                  //            decoration: BoxDecoration(
                  //                color: Colors.grey.withOpacity(.6),
                  //                borderRadius:
                  //                    BorderRadius.all(Radius.circular(20))),
                  //            height: 40,
                  //            width: double.infinity,
                  //            child: Padding(
                  //              padding: const EdgeInsets.only(left: 20.0),
                  //              child: Row(
                  //                children: [
                  //                  Text(
                  //                    "Your Email is not Verified",
                  //                    style: TextStyle(
                  //                        color: Colors.black,
                  //                        fontWeight: FontWeight.w600,
                  //                        fontSize: 15),
                  //                  ),
                  //                  Spacer(),
                  //                  TextButton(
                  //                      style: ButtonStyle(
                  //                          shape: MaterialStateProperty.all(
                  //                              RoundedRectangleBorder(
                  //                                  borderRadius: BorderRadius.all(
                  //                                      Radius.circular(20)))),
                  //                          backgroundColor:
                  //                              MaterialStateProperty.all<Color>(
                  //                                  Colors.amber)),
                  //                      onPressed: () {
                  //                        SignupCubit.get(context).verifyEmail();
                  //                        SignupCubit.get(context).getUser();
                  //                      },
                  //                      child: Text(
                  //                        'send verification',
                  //                        style: TextStyle(
                  //                            color: Colors.red, fontSize: 15),
                  //                      ))
                  //                ],
                  //              ),
                  //            ),
                  //          ),
                  //          Visibility(
                  //            visible: SignupCubit.get(context).otpVisible,
                  //            child: Padding(
                  //              padding: const EdgeInsets.all(20.0),
                  //              child: Container(
                  //                color: Colors.grey,
                  //                height: 50,
                  //                child: TextFormField(
                  //                  controller: otpController,
                  //                ),
                  //              ),
                  //            ),
                  //          ),
                  //         ! SignupCubit.get(context).otpVisible
                  //              ? TextButton(onPressed: () {
                  //                SignupCubit.get(context).verifyPhone();
                  //          }, child: Text("verify"))
                  //              : TextButton(onPressed: () {
                  //            SignupCubit.get(context).verifyCode(code:otpController.text );
                  //          }, child: Text("code send"))
                  //        ],
                  //      ),
                ],
              ));
        });
  }
  Future <bool>showExitPopup(context)async{
    return await showDialog(
        context: context,
        builder: (context){
          return Center(
            child: Container(
                height:  MediaQuery.of(context).size.height*.2,
                width: MediaQuery.of(context).size.width*.78,
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),

                child:Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning_amber_rounded,color: Colors.red,),
                          SizedBox(width: 10,),
                          Text('???????????? ?????????? ?????????? ?',style: TextStyle(fontSize: 16,color: Theme.of(context).textSelectionColor),)
                        ],
                      ),Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextButton(
                              child: Text('close'.toUpperCase(),style: TextStyle(fontSize: 16),),
                              onPressed: (){
                                exit(0);
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text('cancel'.toUpperCase(),style: TextStyle(fontSize: 16),),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],)
                    ],),
                )),
          );
        });
  }
}

// code to apply .......

// import 'package:ECommerceApp/screens/search.dart';
// import 'package:ECommerceApp/screens/user_info.dart';
// import 'package:flutter/material.dart';
//
// import 'cart.dart';
// import 'feeds.dart';
// import 'home.dart';
//
// class BottomBarScreen extends StatefulWidget {
//   @override
//   _BottomBarScreenState createState() => _BottomBarScreenState();
// }
//
// class _BottomBarScreenState extends State<BottomBarScreen> {
//   List<Map<String, Object>> _pages;
//   int _selectedPageIndex = 0;
//
//   @override
//   void initState() {
//     _pages = [
//       {
//         'page': Home(),
//       },
//       {
//         'page': Feeds(),
//       },
//       {
//         'page': Search(),
//       },
//       {
//         'page': Cart(),
//       },
//       {
//         'page': UserInfo(),
//       },
//     ];
//     super.initState();
//   }
//
//   void _selectPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedPageIndex]['page'],
//       bottomNavigationBar: BottomAppBar(
//         // color: Colors.white,
//         shape: CircularNotchedRectangle(),
//         notchMargin: 0.01,
//         clipBehavior: Clip.antiAlias,
//         child: Container(
//           height: kBottomNavigationBarHeight * 0.98,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border(
//                 top: BorderSide(
//                   color: Colors.grey,
//                   width: 0.5,
//                 ),
//               ),
//             ),
//             child: BottomNavigationBar(
//               onTap: _selectPage,
//               backgroundColor: Theme.of(context).primaryColor,
//               unselectedItemColor: Theme.of(context).textSelectionColor,
//               selectedItemColor: Colors.purple,
//               currentIndex: _selectedPageIndex,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   title: Text('Home'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.rss_feed),
//                   title: Text('Feeds'),
//                 ),
//                 BottomNavigationBarItem(
//                   activeIcon: null,
//                   icon: Icon(null),
//                   title: Text('Search'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.shopping_bag,
//                   ),
//                   title: Text('Cart'),
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   title: Text('User'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation:
//       FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           hoverElevation: 10,
//           splashColor: Colors.grey,
//           tooltip: 'Search',
//           elevation: 4,
//           child: Icon(Icons.search),
//           onPressed: () => setState(() {
//             _selectedPageIndex = 2;
//           }),
//         ),
//       ),
//     );
//   }
// }
