import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/screens/cart_widget.dart';
import 'package:ecommerceapplication/screens/product_details.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

import '../../auth/signup/signup_screen.dart';
import '../../models/product_model.dart';
import '../../shared/components/constatnts.dart';

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
    _selectedIndex=int.parse(routeArgs!);
    print(_selectedIndex);
     // print("route ${routeArgs.toString()}");
     //  _selectedIndex = int.parse(routeArgs!.substring(1,2));
    // print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand =  'ايكيا';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'لازورد';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'بيريكس';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'تيفال';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'توشيبا';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'تروفال';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'طبروير';
      });
    }
    if (_selectedIndex == 7) {
      setState(() {
        brand = 'أخرى';
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return uId!=null?Scaffold(
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
                            brand = 'ايكيا';
                          });
                        }
                        if (_selectedIndex == 1) {
                          setState(() {
                            brand = 'لازورد';
                          });
                        }
                        if (_selectedIndex == 2) {
                          setState(() {
                            brand = 'بيريكس';
                          });
                        }
                        if (_selectedIndex == 3) {
                          setState(() {
                            brand = 'تيفال';
                          });
                        }
                        if (_selectedIndex == 4) {
                          setState(() {
                            brand = 'توشيبا';
                          });
                        }
                        if (_selectedIndex == 5) {
                          setState(() {
                            brand = 'تروفال';
                          });
                        }
                        if (_selectedIndex == 6) {
                          setState(() {
                            brand = 'طبروير';
                          });
                        }
                        if (_selectedIndex == 7) {
                          setState(() {
                            brand = 'أخرى';
                          });
                        }
                        // print(brand);

                      });
                    },
                    minWidth: 56,
                    leading: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 22,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                          '${SignupCubit.get(context).model.image}'  )                          ),
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
                          text: 'ايكيا', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'لازورد', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'بيريكس', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'تيفال', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'توشيبا', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'تروفال', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'طبروير', padding: padding),
                      buildRotatedTextNavigationRailDestination(
                          text: 'أخرى', padding: padding),
                    ],
                  )),
                ),
              );
            },
          ),
          ContentSpace(context, brand!)
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
                OutlinedButton(autofocus: false,

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
//                         buildRotatedTextRailDestination("لازورد", padding),
//                         buildRotatedTextRailDestination("Dell", padding),
//                         buildRotatedTextRailDestination("تيفال", padding),
//                         buildRotatedTextRailDestination("توشيبا", padding),
//                         buildRotatedTextRailDestination("تروفال", padding),
//                         buildRotatedTextRailDestination("طبروير", padding),
//                         buildRotatedTextRailDestination("أخرى", padding),
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
    ContentSpace(BuildContext context, this.brand,);

  @override
  Widget build(BuildContext context) {
      var cubit=HomeCubit.get(context);

    // print(cubit.getBrand(brand)[0].description);
        var model=cubit.getBrand(brand);
        var products=cubit.products;
        if(brand=='أخرى')
          {
            for(int i =0;i<products.length;i++)
              {
                 model.add(products[i]);

              }
          }

    print(brand);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            itemCount: model.length,
            itemBuilder: (BuildContext context, int index) =>
            RailWidget(  context,model[index] , index),
          ),
        ),
      ),
    );
  }
}


Widget RailWidget(context,ProductModel model,index){
  return Container(
    padding: EdgeInsets.only(left: 5, right: 5),
    margin: EdgeInsets.only(right: 20, bottom: 5, top: 18),
    constraints: BoxConstraints(
        minHeight: 150, maxHeight: 180, minWidth: double.infinity),
    child: Row(
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            onTap: (){
              Navigator.pushNamed(context, ProductsDetails.routeName,arguments:  model.id );            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "${model.imageUrl}"),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, blurRadius: 3, offset: Offset(2, 2))
                  ]),
            ),
          ),
        ),
        FittedBox(
          child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade700,
                      blurRadius: 10,
                      offset: Offset(5, 5))
                ],
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            width: 160,
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.title}",
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textSelectionColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      "US ${model.price} \$",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${model.categoryName}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textSelectionColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
