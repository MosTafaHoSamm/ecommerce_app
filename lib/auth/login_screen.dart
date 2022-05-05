import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerceapplication/auth/signup/signup_cubit.dart';
import 'package:ecommerceapplication/auth/signup/signup_screen.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/shared/cubit/cart_cubit/cart_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/home_cubit.dart';
import 'package:ecommerceapplication/shared/cubit/wishlist_cubit/wishlist_cubit.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:ecommerceapplication/shared/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../shared/components/components.dart';
import '../shared/components/constatnts.dart';
import 'cubit/lgin_states.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "/LoginScreen";
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  bool isSecure = true;
  String _password = '';
  String _emailAddress = '';
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) => {
                if (state is LoginSuccessState)
                  {
                    CacheHelper.saveString(key: 'uId', value: state.uId)
                        .then((value) {
                      uId = CacheHelper.getSavedData(key: 'uId');
                      SignupCubit.get(context).getUserData();
                      WishListCubit.get(context).getWishListItems();
                      CartCubit.get(context).getCartItems();
                      HomeCubit.get(context).getProducts();
                      // Navigator.pushNamed(context, BottomNavigationBarScreen.routeName);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return BottomNavigationBarScreen();
                      }), (route) => false);
                    }),
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
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 2,
                                    color: Colors.green,
                                    offset: Offset(1, 1))
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn-icons-png.flaticon.com/512/3643/3643166.png"))),
                        ),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              defaultTextForm(
                                  controller: _emailController,
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
                                    if (value!.isEmpty ||
                                        !value.contains('@')) {
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
                                  key: "password",
                                  focusNode: passwordFocusNode,
                                  type: TextInputType.visiblePassword,
                                  onSaved: (value) {
                                    _password = value!;
                                  },
                                  isSecure: LoginCubit.get(context).isSecure,
                                  suffix: Icons.visibility,
                                  suffixPressed: () {
                                    LoginCubit.get(context).changeVisibility();
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
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
                                    print('Logged In');
                                    LoginCubit.get(context)
                                        .login(_emailController.text,
                                            _passwordController.text)
                                        .then((value) {});
                                  }
                                  // Navigator.pushNamed(context, LoginScreen.routeName);
                                },
                                child: ConditionalBuilder(
                                  condition: state is! LoginLoadingState,
                                  builder: (context) => Row(
                                    children: [
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(Icons.login_outlined)
                                    ],
                                  ),
                                  fallback: (context) => Container(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
                                )),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                              highlightedBorderColor:
                                  Colors.deepOrange.shade200,
                              borderSide: BorderSide(
                                  color: Colors.deepOrange, width: 2),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.googlePlusG,
                                        size: 18,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Google",
                                        style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontSize: 16),
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
                                        color: Colors.indigoAccent,
                                        fontSize: 16),
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
                              "Don\'t have an account ?",
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, SignupScreen.routeName);
                                },
                                child: Text("Signup"))
                          ],
                        )
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
