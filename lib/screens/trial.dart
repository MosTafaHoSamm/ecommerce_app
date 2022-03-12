import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared/themes/colors.dart';

class UseroInfoScreen extends StatefulWidget {
  @override
  State<UseroInfoScreen> createState() => _UseroInfoScreenState();
}

class _UseroInfoScreenState extends State<UseroInfoScreen> {
  // bool _value = false;
  //
  // List<IconData> icons = [
  //   Icons.email,
  //   Icons.phone,
  //   Icons.local_shipping_rounded,
  //   Icons.watch_later,
  //   Icons.brightness_4_outlined,
  //   FontAwesomeIcons.signOutAlt
  // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//               padding: EdgeInsetsDirectional.only(start: 10),
//               child: titleitem(text: "User Information")),
//           Divider(
//             thickness: 2,
//             color: Colors.grey[300],
//           ),
//           listTile(context, "Email", "There is No Email", icons, 0),
//           listTile(context, "Phone", "There is No phone", icons, 1),
//           listTile(context, "Shipping Address", "There is No Shipping Address",
//               icons, 2),
//           listTile(context, "Joined data", "There is No Joined data", icons, 3),
//           Padding(
//               padding: EdgeInsetsDirectional.only(start: 10),
//               child: titleitem(text: "User Settings")),
//           Divider(
//             thickness: 2,
//             color: Colors.grey[300],
//           ),
//
//           SwitchListTile(
//             visualDensity: VisualDensity.comfortable,
//
//           secondary: Icon(FontAwesomeIcons.moon),
//
//               title:Text("Dark Mode") ,
//
//               value: _value,
//               onChanged: (value) {
//                 setState(() {
//                   _value = value;
//                 });
//               }),
//           listTile(context, 'SignOut','', icons, 5)
//         ],
//       ),
//     );
//   }
// }
//
// Widget listTile(BuildContext context, title, subtitle, List icons, index) {
//   return Material(
//     color: Colors.transparent,
//     child: InkWell(
//       splashColor: Theme.of(context).splashColor,
//       onTap: () {},
//       child: ListTile(
//         title: Text(title),
//         subtitle: Text(subtitle),
//         leading: Icon(icons[index]),
//       ),
//     ),
//   );
// }
//
// Widget titleitem({required String text}) {
//   return Text(
//     text,
//     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//   );
// }




bool _value = false;
late ScrollController _scrollController;
var top = 0.0;
@override
void initState() {
  // TODO: implement initState
  super.initState();
  _scrollController =ScrollController();
  _scrollController.addListener(() {setState(() {

  });});
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 4,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              ColorsConsts.starterColor,
                              ColorsConsts.endColor,
                            ],
                            begin: const FractionalOffset(0.0, 0.0),
                            end: const FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: true,
                        title: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 300),
                              opacity: top <= 110.0 ? 1.0 : 0,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Container(
                                    height: kToolbarHeight / 1.8,
                                    width: kToolbarHeight / 1.8,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    // 'top.toString()',
                                    'Guest',
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        background: Image(
                          image: NetworkImage(
                              'https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: userTitle('User Information')),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  userListTile('Email', 'Email sub', 0, context),
                  userListTile('Email', 'Email sub', 0, context),
                  userListTile('Email', 'Email sub', 0, context),
                  userListTile('Email', 'Email sub', 0, context),
                  userListTile('Email', 'Email sub', 0, context),
                  userListTile('Phone number', '4555', 0, context),
                  userListTile('Shipping address', '', 0, context),
                  userListTile('joined date', 'date', 0, context),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle('User settings'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  SwitchListTile(
                    value: _value,
                    secondary: Icon(Icons.brightness_2_outlined),
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                     selectedTileColor: Colors.indigo,
                    title: Text('Dark theme'),
                  ),
                  userListTile('Logout', '', 4, context),
                ],
              ),
            )
          ],
        ),
        _buildFab()
      ],
    ),
  );
}


Widget _buildFab() {
  //starting fab position
  final double defaultTopMargin = 200.0 - 4.0;
  //pixels from top where scaling should start
  final double scaleStart = 160.0;
  //pixels from top where scaling should end
  final double scaleEnd = scaleStart / 2;

  double top = defaultTopMargin;
  double scale = 1.0;
  if (_scrollController.hasClients) {
    double offset = _scrollController.offset;
    top -= offset;
    if (offset < defaultTopMargin - scaleStart) {
      //offset small => don't scale down
      scale = 1.0;
    } else if (offset < defaultTopMargin - scaleEnd) {
      //offset between scaleStart and scaleEnd => scale down
      scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
    } else {
      //offset passed scaleEnd => hide fab
      scale = 0.0;
    }
  }

  return  Positioned(
    top: top,
    right: 16.0,
    child:  Transform(
      transform:  Matrix4.identity()..scale(scale),
      alignment: Alignment.center,
      child:  FloatingActionButton(
        heroTag: "btn1",
        onPressed: (){},
        child:  Icon(Icons.camera_alt_outlined),
      ),
    ),
  );
}

List<IconData> _userTileIcons = [
  Icons.email,
  Icons.phone,
  Icons.local_shipping,
  Icons.watch_later,
  Icons.exit_to_app_rounded
];

Widget userListTile(
    String title, String subTitle, int index, BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: InkWell(
      splashColor: Theme.of(context).splashColor,
      child: ListTile(
        onTap: () {},
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(_userTileIcons[index]),
      ),
    ),
  );
}

Widget userTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(14.0),
    child: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
    ),
  );
}
}

