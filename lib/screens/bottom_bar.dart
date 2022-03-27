import 'package:ecommerceapplication/screens/Cart.dart';
import 'package:ecommerceapplication/screens/feeds.dart';
import 'package:ecommerceapplication/screens/search.dart';
import 'package:ecommerceapplication/screens/user_info.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


 import '../shared/cubit/dark_cubit/dark_cubit.dart';
import '../shared/themes/icons.dart';
import 'home.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() {
    return _BottomNavigationBarScreenState();
  }
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  late List<Map<String, Widget>> screens;
  @override
  void initState() {
    // TODO: implement initState
    screens = [
      {
        'page': HomeScreen(),
      },
      {
        'page': FeedsScreen(  ),
      },
      {
        'page': SearchScreen(),
      },
      {
        'page':CartScreen (),
      },
      {
        'page':UserInfoScreen (),
      },
    ];
    super.initState();
  }


  void selectScreen(index) {
    setState(() {
      currentIndex = index;
    });
  }
  int currentIndex =0;

  @override
  Widget build(BuildContext context) {
    var cubit=DarkCubit.get(context);
    return Scaffold(
        floatingActionButton:  FloatingActionButton(
          backgroundColor: cubit.isDark?Colors.lightBlueAccent:Colors.blue,
          hoverElevation: 100,
          elevation: 4,
          splashColor: Colors.grey,
          tooltip: "Search",
          child: Icon(MyIcon.search),
          onPressed: (){
            setState(() {
              currentIndex=2;
              print(currentIndex.toString());
            });
          }
          ,

        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 0.98*kBottomNavigationBarHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey,width: .7))),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index){
                selectScreen(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(icon: Icon(MyIcon.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(MyIcon.feeds),label: "Feeds"),
                BottomNavigationBarItem(icon: Icon(null),label: 'search',activeIcon:  Icon(null),),
                BottomNavigationBarItem(icon: Icon(MyIcon.shopping),label: 'Shopping'),
                BottomNavigationBarItem(icon: Icon(MyIcon.user),label: 'Person'),
              ],
            ),
          ),

        ),
         floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

         body: screens[currentIndex]['page']);
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
