import 'package:ecommerceapplication/auth/login_screen.dart';
import 'package:ecommerceapplication/auth/signup/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin  {
  late AnimationController _animationController;
  late Animation _animation;
  List<String>images=[
    'https://img.freepik.com/free-photo/shocked-two-women-friends-holding-shopping-bags-using-mobile-phone_171337-5718.jpg?t=st=1649062945~exp=1649063545~hmac=7b74447af1bb14dc46884d676298d55690bd23b22f1cb16ae2c8305c7eedbd7c&w=740',
    'https://media.istockphoto.com/photos/man-at-the-shopping-picture-id868718238?k=6&m=868718238&s=612x612&w=0&h=ZUPCx8Us3fGhnSOlecWIZ68y3H4rCiTnANtnjHk0bvo=',
    'https://e-shopy.org/wp-content/uploads/2020/08/shop.jpeg',
    'https://img.freepik.com/free-photo/e-commerce-sales-online-shopping-annual-discount-digital-marketingr-all-live-futuristic-atmosphere-3d-render_172660-10.jpg?w=826'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images.shuffle();
    _animationController=AnimationController(vsync: this,duration: Duration(seconds: 25));
    _animation=CurvedAnimation(parent: _animationController, curve: Curves.linear
    )..addListener(() {
      setState(() {

      });})..addStatusListener((animationStatus) {
      if(animationStatus==AnimationStatus.completed)
        _animationController.reset();
      _animationController.forward();
    });
    _animationController.forward();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
            images[1],
            // placeholder: (context, url) => Image.network(
            //     'https://img.freepik.com/free-vector/flat-coming-soon-background_23-2148877229.jpg?t=st=1648989498~exp=1648990098~hmac=94e253902e2018bda5f6da2a44ed72d7c224ff14578e88c34b8d4ceda90eee9c&w=740'),

            errorWidget: (context, url, error) => Icon(
              FontAwesomeIcons.facebook,
            ),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value,0),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Wel",
                      style: TextStyle(
                        shadows: [Shadow(color: Colors.black,offset: Offset(1,3))],
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "come",
                      style: TextStyle(
                        shadows: [Shadow(color: Colors.black,offset: Offset(1,2))],
                        color: Colors.orange,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(

                    "Welcome to  market\n Yasseen Souq",
                    style: TextStyle(
                        shadows: [Shadow(color: Colors.black12,offset: Offset(1,3))],

                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color:Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
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
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.pink),
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
                            Navigator.pushNamed(context, SignupScreen.routeName);
                          },
                          child: Text(
                            "Signup",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "or continue with",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Divider(
                        thickness: 2,
                        color: Colors.white,
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
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: Colors.deepOrange,
                    highlightedBorderColor: Colors.deepOrange.shade200,
                    borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                    child:  Row(
                      children: [
                        Icon(FontAwesomeIcons.googlePlusG,size: 18,color: Colors.deepOrange,),
                        SizedBox(width: 10,),
                        Text(
                          "Google",
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 16),
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  OutlineButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: Colors.indigoAccent,
                    highlightedBorderColor: Colors.indigo.shade200,
                    borderSide:
                    BorderSide(color: Colors.indigoAccent, width: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.facebook,
                          color: Colors.indigoAccent,
                        ),
                        Text(
                          " facebook",
                          style: TextStyle(
                              color: Colors.indigoAccent, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: Colors.deepOrange, width: 2)),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.deepOrange.shade400),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20))))),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Continue as a guest",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
