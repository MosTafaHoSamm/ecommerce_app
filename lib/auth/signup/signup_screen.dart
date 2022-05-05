import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/auth/login_screen.dart';
import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/auth/signup/signup_states.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../shared/components/components.dart';
import '../cubit/lgin_states.dart';
import '../cubit/login_cubit.dart';
import '../phone_verification/phone_verification_screen.dart';

class SignupScreen extends StatelessWidget {
  static String routeName = "/SignupScreen";

  SignupScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool isSecure = true;
  String _password = '';
  String _emailAddress = '';
  String _fullName = '';
  int? _phoneNumber;
  FocusNode passwordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) => {
              if (state is RegisterSuccessState)
                {
                  CacheHelper.saveString(
                      key: 'uId',
                      value: state.uId).then((value){
                    uId=CacheHelper.getSavedData(key: 'uId');

                    SignupCubit.get(context).getUserData();

                    Navigator.pushNamed(
                            context, BottomNavigationBarScreen.routeName);
                  }),

                }
            },
        builder: (context, state) {
          var cubit = SignupCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .95,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: WaveWidget(
                        config: CustomConfig(
                          gradients: [
                            [Colors.pink.shade500, Colors.purple.shade800],
                            [
                              ColorsConsts.gradiendFEnd,
                              ColorsConsts.gradiendFStart
                            ]
                          ],
                          durations: [19440, 10800],
                          heightPercentages: [0.20, 0.250],
                          blur: MaskFilter.blur(BlurStyle.solid, 10),
                          gradientBegin: Alignment.bottomLeft,
                          gradientEnd: Alignment.topRight,
                        ),
                        waveAmplitude: 0,
                        size: Size(
                          double.infinity,
                          double.infinity,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 50),
                            margin: EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: ColorsConsts.gradiendFStart,
                              child: CircleAvatar(
                                radius: 57,
                                backgroundColor: ColorsConsts.gradiendFEnd,
                                backgroundImage: cubit.pickedImage == null
                                    ? null
                                    : FileImage(cubit.pickedImage!),
                              ),
                            ),
                          ),

                           Positioned(
                            top: 100,
                            left: 100,
                            child: Container(
                              child: RawMaterialButton(
                                fillColor: ColorsConsts.gradiendFStart,
                                padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                            "Choose Option",
                                            style: TextStyle(
                                                color: Colors.purple,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cubit.getImageCamera();
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.camera,
                                                          color: ColorsConsts
                                                              .gradiendFStart,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Camera",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap:
                                                      // SignupCubit.get(context).getImageGallery
                                                      () {
                                                    cubit.getImageGallery().then((value) {
                                                      cubit.uploadPhoto();

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.image,
                                                          color: ColorsConsts
                                                              .gradiendFStart,
                                                        ),
                                                      ),
                                                      Text(
                                                        "gallery",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    cubit.remove();
                                                    Navigator.pop(context);
                                                  },
                                                  splashColor: Colors.purple,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      Text(
                                                        "remove",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Icon(Icons.camera_alt_outlined),
                              ),

                              // ) ,
                            ),
                          )
                        ],
                      )

                      // child:Stack(
                      //   children: [
                      //     CircleAvatar(
                      //       radius: 70,
                      //       backgroundColor: ColorsConsts.gradiendFStart,
                      //       child: CircleAvatar(
                      //         radius: 67,
                      //         backgroundColor: ColorsConsts.gradiendFEnd,
                      //
                      //       ),
                      //     ),

                      // Container(
                      //   margin: EdgeInsets.only(top: 95),
                      //   height: 120,
                      //   width: 120,
                      //   decoration: BoxDecoration(
                      //       boxShadow: [
                      //         BoxShadow(
                      //             blurRadius: 2,
                      //             color: Colors.green,
                      //             offset: Offset(1, 1))
                      //       ],
                      //       color: Colors.white,
                      //       shape: BoxShape.circle,
                      //       image: DecorationImage(
                      //           image: NetworkImage(
                      //               "https://cdn-icons-png.flaticon.com/512/3643/3643166.png"))),
                      // ),
                      ,
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            defaultTextForm(
                                controller: _nameController,
                                action: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                },
                                key: "fullName",
                                onSaved: (value) {
                                  _fullName = value!;
                                  print('fullName ${_fullName}');
                                },
                                type: TextInputType.name,
                                text: "FullName",
                                icon: Icons.person,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "name musn\'t be empty";
                                  } else {
                                    return null;
                                  }
                                }),
                            defaultTextForm(
                                controller: _emailController,
                                focusNode: emailFocusNode,
                                action: TextInputAction.next,
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(passwordFocusNode);
                                },
                                key: "email",
                                onSaved: (value) {
                                  _emailAddress = value!;
                                  print('email ${_emailAddress}');
                                },
                                type: TextInputType.emailAddress,
                                text: "Email Address",
                                icon: Icons.email_outlined,
                                validate: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return "Enter a valid Email Address";
                                  } else {
                                    return null;
                                  }
                                }),
                            defaultTextForm(
                                controller: _passwordController,
                                onSubmit: (value) {
                                  if (formKey.currentState!.validate()) {}
                                },
                                onEditingComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(phoneFocusNode);
                                },
                                key: "password",
                                focusNode: passwordFocusNode,
                                type: TextInputType.visiblePassword,
                                onSaved: (value) {
                                  _password = value!;
                                },
                                isSecure: SignupCubit.get(context).isSecure,
                                suffix: Icons.visibility,
                                suffixPressed: () {
                                  SignupCubit.get(context).changeVisibility();
                                  print("Done");
                                },
                                text: "password",
                                icon: Icons.lock,
                                validate: (value) {
                                  if (value!.isEmpty || value.length < 6) {
                                    return "Enter a valid Password ";
                                  } else {
                                    return null;
                                  }
                                }),
                            defaultTextForm(
                                controller: _phoneController,
                                focusNode: phoneFocusNode,
                                key: "phoneNumber",
                                onSaved: (value) {
                                  _phoneNumber = int.parse(value!);
                                },
                                type: TextInputType.phone,
                                text: "Phone Number",
                                icon: Icons.phone_android,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Phone Musn\'t be empty";
                                  } else {
                                    return null;
                                  }
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  SignupCubit.get(context).register(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      name: _nameController.text,
                                      phone: _phoneController.text);
                                }
                              },
                              child: ConditionalBuilder(
                                condition: state is! RegisterLoadingState ,
                                 builder: (context) => Row(
                                  children: [
                                    Text(
                                      "SignUp",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(Icons.login_rounded)
                                  ],
                                ),
                                fallback: (context) => Center(
                                  child: Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
                                ),
                              )),
                          SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            "Or continue with",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlineButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            color: Colors.deepOrange,
                            highlightedBorderColor: Colors.deepOrange.shade200,
                            borderSide:
                                BorderSide(color: Colors.deepOrange, width: 2),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.googlePlusG,
                                      size: 13,
                                      color: Colors.deepOrange,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Google",
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          OutlineButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            color: Colors.indigoAccent,
                            highlightedBorderColor: Colors.indigo.shade200,
                            borderSide: BorderSide(
                                color: Colors.indigoAccent, width: 2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.facebook,
                                  color: Colors.indigoAccent,
                                ),
                                Text(
                                  " facebook",
                                  style: TextStyle(
                                      color: Colors.indigoAccent, fontSize: 13),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          OutlineButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, PhoneScreen.routeName);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            color: Colors.green.shade500,
                            highlightedBorderColor: Colors.indigo.shade200,
                            borderSide: BorderSide(
                                color: Colors.green.shade500, width: 2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.green.shade500,
                                ),
                                Text(
                                  " mobile",
                                  style: TextStyle(
                                      color: Colors.green.shade500,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "have an account ?",
                            style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500),
                          ),
                          TextButton(onPressed: () {
                            Navigator.pushNamed(
                                    context, LoginScreen.routeName);
                          }, child: Text("login".toUpperCase()))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
