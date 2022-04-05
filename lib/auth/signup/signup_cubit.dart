import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates>{

  SignupCubit():super(SignupInitialState());
  static SignupCubit get(context)=>BlocProvider.of(context);

  bool isSecure=true;
  IconData suffixIcon=Icons.visibility;
  void changeVisibility(){

    isSecure=!isSecure;
    isSecure?Icons.visibility:Icons.visibility_off;
    emit(ChangeVisibilityState());

  }
    File?  pickedImage;
  final imagePicker=ImagePicker();
  Future<void>getImageGallery( )async{
    final PickedFile= await imagePicker.getImage(source: ImageSource.gallery);
    if(PickedFile!=null)
      pickedImage=File(PickedFile .path);
    else return null;
    print(pickedImage!.path.toString());
    emit(ChangePhotoState());

  }

     getImageCamera(  )async{
  final pickedFile=await imagePicker.getImage(source: ImageSource.camera).then((value) {
    if(value!=null)
      {
        pickedImage=File(value.path);
      }
  }).catchError((error){});
emit(ChangePhotoState());
  }
  remove()async{
    pickedImage=null;
    emit(ChangePhotoState());
  }
}