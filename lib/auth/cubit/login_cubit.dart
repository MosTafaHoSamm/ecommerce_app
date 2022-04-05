import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}