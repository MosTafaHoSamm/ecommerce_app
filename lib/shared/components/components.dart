import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateAndFinish(context,widget){

  Navigator.push(context, MaterialPageRoute(builder: (context){return widget;}));
}
  showAlertDialog({
    required Function() ok,
    required Function() cancel,

    context,
    required String title,
    required String subtitle,
    }){
   showDialog(
       context: context,
       builder: (context){
         return AlertDialog(
           title:Row(
             children: [
               Image.network('https://cdn-icons-png.flaticon.com/512/564/564619.png',width: 20,height: 20,),
                SizedBox(width: 10,),
                Text(title),
             ],
           ) ,
           content: Text(subtitle),
           actions: [
             TextButton(onPressed: ok, child: Text("Ok")),
             TextButton(onPressed: cancel, child: Text("Cancel")),
           ],
           
         );
       }
   );

  // return AlertDialog(
  //
  //   title: Text(title),
  //   content:Text(subtitle)
  //
  // ) ;
}