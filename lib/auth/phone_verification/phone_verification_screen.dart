import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/auth/phone_verification/phone_cubit.dart';
import 'package:ecommerceapplication/auth/phone_verification/phone_states.dart';
import 'package:ecommerceapplication/auth/signup/signup_screen.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/user_info.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../shared/components/components.dart';
import '../cubit/lgin_states.dart';
import '../cubit/login_cubit.dart';

class PhoneScreen extends StatelessWidget {
  static String routeName = "/PhoneScreen";
  TextEditingController _otpCode=TextEditingController();
  TextEditingController _phoneNumber=TextEditingController();
  PhoneScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  bool isSecure = true;
  String _password = '';
  String _emailAddress = '';
  FocusNode passwordFocusNode=FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneCubit(),
      child: BlocConsumer<PhoneCubit, PhoneStates>(
          listener: (context, state) => {
            if(state is LoginWithCredintialSuccessState)
              {
                CacheHelper.saveString(key: 'token', value: PhoneCubit.get(context).tokenCred),
                Navigator.pushNamed(context, BottomNavigationBarScreen.routeName)

              }
          },
          builder: (context, state) {
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
                        Container(
                          margin: EdgeInsets.only(top: 95),
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.purpleAccent,
                                    offset: Offset(1, 1))
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage('assets/images/login.png')
                              )
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              defaultTextForm(
                                  controller: _phoneNumber,

                                  action: TextInputAction.next,
                                  onEditingComplete: (){  FocusScope.of(context).requestFocus(passwordFocusNode);},


                                  key: "phone",
                                  onSaved: (value) {
                                    _emailAddress = value!;
                                    print('email ${_emailAddress}');
                                  },
                                  type: TextInputType.phone,
                                  text: "Phone",
                                  icon: Icons.phone_android,
                                  validate: (value) {
                                    if (value!.isEmpty || value.length<11) {
                                      return "Enter a valid phone";
                                    } else {
                                      return null;
                                    }
                                  }),
                             PhoneCubit.get(context).codeVisible? defaultTextForm(
                                  controller: _otpCode,
                                  onSubmit: (value){
                                    if(formKey.currentState!.validate()){

                                    }
                                  },
                                  key: "otpCode",
                                  focusNode: passwordFocusNode,
                                  type: TextInputType.number,
                                  onSaved: (value) {
                                    _password = value!;
                                  },

                                  text: "code",
                                  icon: Icons.verified_user_outlined,
                                  validate: (value) {
                                    if (value!.isEmpty || value.length < 6) {
                                      return "Enter the valid otp Code ";
                                    } else {
                                      return null;
                                    }
                                  }):Container(),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        !PhoneCubit.get(context).codeVisible?Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  if (formKey.currentState!.validate()){
                                    PhoneCubit.get(context).verifyPhone(phoneNumber: _phoneNumber.text);
                                  }
                                  // Navigator.pushNamed(context, PhoneScreen.routeName);
                                },
                                child: ConditionalBuilder(
                                  condition: state is! LoginWithCredintialLoadingState,
                                  builder:(context)=>Row(
                                    children:   [


                                      Text(
                                        "Register" ,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )


                                    ],
                                  ) ,
                                  fallback: (context)=>const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white,)),
                                )),

                          ],
                        ):Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  if (formKey.currentState!.validate()){
                                     PhoneCubit.get(context).verifyCode(_otpCode.text);

                                  }
                                  // Navigator.pushNamed(context, PhoneScreen.routeName);
                                },
                                child: ConditionalBuilder(
                                  condition: state is! LoginWithCredintialLoadingState,
                                  builder:(context)=>Row(
                                    children:   [


                                      Text(
                                        "verify" ,
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      )


                                    ],
                                  ) ,
                                  fallback: (context)=>const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(color: Colors.white,)),
                                )),

                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),

                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
