import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/loginModel.dart';
import 'lgin_states.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit():super(LoginInitialState());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isSecure=true;
  IconData suffixIcon=Icons.visibility;
  void changeVisibility(){

    isSecure=!isSecure;
    isSecure?Icons.visibility:Icons.visibility_off;
    emit(ChangeVisibilityState());

  }
  late LoginModel loginModel;
  login(
      String email,
      String password,
      ){
    emit(LoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password)
        .then((value) {
      loginModel=LoginModel(value.user?.email, value.user?.uid);
          emit(LoginSuccessState());

    })
        .catchError((error){
          print(error.toString());
      emit(LoginErrorState());


    });
  }
}