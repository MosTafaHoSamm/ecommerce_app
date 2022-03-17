import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(context,widget){

  Navigator.push(context, MaterialPageRoute(builder: (context){return widget;}));
}