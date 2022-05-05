import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/auth/signup/signup_states.dart';
 import 'package:ecommerceapplication/screens/user_info.dart';
import 'package:ecommerceapplication/screens/wishlist.dart';
import 'package:ecommerceapplication/shared/cubit/dark_cubit/dark_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../auth/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/themes/icons.dart';
import 'Cart.dart';
import 'back_layer/back_layer.dart';

class TrialScreen extends StatelessWidget {
  static var routeName='/TrailScreen';
  const TrialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SignupCubit,SignupStates>(
      listener: (context,state){},
      builder: (context,state){

        SignupCubit cubit=SignupCubit.get(context);
        DarkCubit cubitD=DarkCubit.get(context);

        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: titleitem(text: "User Bag")),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),

              Padding(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: titleitem(text: "User Information")),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              InkWell(

                child: listTile(context, "Email", "${SignupCubit.get(context).model.email}", icons, 0),
                onTap:(){
                  print(SignupCubit.get(context).model.uId);
                },),
              listTile(context, "Phone", "${SignupCubit.get(context).model.phone}", icons, 1),
              listTile(context, "Shipping Address",
                  "${SignupCubit.get(context).model.shipAddress}", icons, 2),
              listTile(context, "Joined data",
                  "${SignupCubit.get(context).model.dateJoined}", icons, 3),
              Padding(
                  padding: EdgeInsetsDirectional.only(start: 10),
                  child: titleitem(text: "User Settings")),
              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              SwitchListTile(
                  visualDensity: VisualDensity.comfortable,
                  secondary: Icon(FontAwesomeIcons.moon),
                  title: Text("Dark Mode"),
                  value: cubitD.isDark,
                  onChanged: (value) {
                    cubitD.changeMode();
                  }),

              SizedBox(
                height: 60,
              ),
            ],
          ),
        );
      },);


  }
}
