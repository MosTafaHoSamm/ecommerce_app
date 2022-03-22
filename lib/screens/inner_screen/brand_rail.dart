import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:flutter/material.dart';

import 'brand_rail_widget.dart';

class BrandRailScreen extends StatefulWidget {
  BrandRailScreen({Key? key}) : super(key: key);
  static const routeName='/brandRailScreen';

  @override
  State<BrandRailScreen> createState() => _BrandRailScreenState();
}

class _BrandRailScreenState extends State<BrandRailScreen> {
  final padding = 8.0;
  int _selectedIndex = 0;

      String ? routeArgs;

    String? brand;

  @override
  didChangeDependencies() {
    routeArgs=ModalRoute.of(context)!.settings.arguments.toString();
    _selectedIndex=int.parse(routeArgs!.substring(1,2));
    print(_selectedIndex);
     // print("route ${routeArgs.toString()}");
    // _selectedIndex = int.parse(routeArgs.substring(1,2));
    // print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand =  'Adidas';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Apple';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'DELL';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'H&M';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Nike';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Samsung';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Huawei';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'All';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                      child: NavigationRail(
                    groupAlignment: 1.0,
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (int index) {
                      setState(() {
                        _selectedIndex = index;
                        if (_selectedIndex == 0) {
                          setState(() {
                            brand = 'Adidas';
                          });
                        }
                        if (_selectedIndex == 1) {
                          setState(() {
                            brand = 'Apple';
                          });
                        }
                        if (_selectedIndex == 2) {
                          setState(() {
                            brand = 'DELL';
                          });
                        }
                        if (_selectedIndex == 3) {
                          setState(() {
                            brand = 'H&M';
                          });
                        }
                        if (_selectedIndex == 4) {
                          setState(() {
                            brand = 'Nike';
                          });
                        }
                        if (_selectedIndex == 5) {
                          setState(() {
                            brand = 'Samsung';
                          });
                        }
                        if (_selectedIndex == 6) {
                          setState(() {
                            brand = 'Huawei';
                          });
                        }
                        if (_selectedIndex == 7) {
                          setState(() {
                            brand = 'All';
                          });
                        }
                        print(brand);

                      });
                    },
                    minWidth: 56,
                    leading: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          radius: 16,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                                "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
              selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: .8,
                      ),
                    selectedIndex: _selectedIndex,
                    destinations: [
                      buildRotatedTextNavigationRailDestination(
                          text: 'Adidas', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'Apple', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'H&M', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'Nike', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'Samsung', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'Huawei', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'All', padding: padding),
                    ],
                  )),
                ),
              );
            },
          ),
          ContentSpace(context, brand!)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextNavigationRailDestination({
  required String text,
  required double padding,
}) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),

      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

//   static const routeName = '/brands_navigation_rail';
//
//    Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: <Widget>[
//           LayoutBuilder(
//             builder: (context, constraint) {
//               return SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(minHeight: constraint.maxHeight),
//                   child: IntrinsicHeight(
//                     child: NavigationRail(
//                       minWidth: 56.0,
//                       groupAlignment: 1.0,
//                       selectedIndex: _selectedIndex,
//                       onDestinationSelected: (int index) {
//
//
//                           print(brand);
//                         });
//                       },
//                       labelType: NavigationRailLabelType.all,
//                       leading: Column(
//                         children: <Widget>[
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Center(
//                             child: CircleAvatar(
//                               radius: 16,
//                               backgroundImage: NetworkImage(
//                                   "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 80,
//                           ),
//                         ],
//                       ),
//                       selectedLabelTextStyle: TextStyle(
//                         color: Color(0xffffe6bc97),
//                         fontSize: 20,
//                         letterSpacing: 1,
//                         decoration: TextDecoration.underline,
//                         decorationThickness: 2.5,
//                       ),
//                       unselectedLabelTextStyle: TextStyle(
//                         fontSize: 15,
//                         letterSpacing: 0.8,
//                       ),
//                       destinations: [
//                         buildRotatedTextRailDestination('Addidas', padding),
//                         buildRotatedTextRailDestination("Apple", padding),
//                         buildRotatedTextRailDestination("Dell", padding),
//                         buildRotatedTextRailDestination("H&M", padding),
//                         buildRotatedTextRailDestination("Nike", padding),
//                         buildRotatedTextRailDestination("Samsung", padding),
//                         buildRotatedTextRailDestination("Huawei", padding),
//                         buildRotatedTextRailDestination("All", padding),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           // This is the main content.
//
//           ContentSpace(context, brand)
//         ],
//       ),
//     );
//   }
// }
//
// NavigationRailDestination buildRotatedTextRailDestination(
//     String text, double padding) {
//   return NavigationRailDestination(
//     icon: SizedBox.shrink(),
//     label: Padding(
//       padding: EdgeInsets.symmetric(vertical: padding),
//       child: RotatedBox(
//         quarterTurns: -1,
//         child: Text(text),
//       ),
//     ),
//   );
// }
//
class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) =>
            RailWidget(),
          ),
        ),
      ),
    );
  }
}
