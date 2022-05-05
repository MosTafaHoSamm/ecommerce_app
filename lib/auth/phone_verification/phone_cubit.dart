import 'dart:io';
import 'package:ecommerceapplication/models/signupModel.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'phone_states.dart';

class PhoneCubit extends Cubit<PhoneStates> {
  PhoneCubit() : super(PhoneInitialState());

  static PhoneCubit get(context) => BlocProvider.of(context);
  bool codeVisible=false;

  changeVisibility(){
    codeVisible=!codeVisible;
    emit (ChangeFieldCodeState());
  }
  String receivedCodeId='';

  verifyPhone({
    required String phoneNumber,

})async{
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential){
          FirebaseAuth.instance.signInWithCredential(credential)
              .then((value) {
                FirebaseAuth.instance.signInWithCredential(credential);
          })
              .catchError((error){
            Fluttertoast.showToast(
                msg: '${error.toString()}',
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.white,
                gravity: ToastGravity.SNACKBAR,
                fontSize: 14);
            print(error.toString());
          });

        },
        verificationFailed: (FirebaseAuthException exception){
          print(exception.message);
        },
        codeSent: (String codeNum,int?code){
          receivedCodeId=codeNum;
          changeVisibility();
        },
        codeAutoRetrievalTimeout: (String timeOut){});
  }
var tokenCred='';
verifyCode(String code){
  emit(LoginWithCredintialLoadingState());

  PhoneAuthCredential credential=PhoneAuthProvider.credential(
        verificationId: receivedCodeId,
        smsCode: code);
    FirebaseAuth.instance.signInWithCredential(credential)
        .then((value) {
      tokenCred=value.user!.uid;
      emit(LoginWithCredintialSuccessState(tokenCred));


    })
        .catchError((error){
          // Fluttertoast.showToast(
          //     msg: '${error.toString()}',
          // backgroundColor: Colors.red,
          // toastLength: Toast.LENGTH_LONG,
          // textColor: Colors.white,
          // gravity: ToastGravity.SNACKBAR,
          // fontSize: 14);
          print(error.toString());
      emit(LoginWithCredintialErrorState());

    });

}

}

