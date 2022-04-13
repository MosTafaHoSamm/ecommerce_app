import 'dart:io';
import 'package:ecommerceapplication/models/signupModel.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);

  bool isSecure = true;
  IconData suffixIcon = Icons.visibility;

  void changeVisibility() {
    isSecure = !isSecure;
    isSecure ? Icons.visibility : Icons.visibility_off;
    emit(ChangeVisibilityState());
  }

  File? pickedImage;
  final imagePicker = ImagePicker();

  Future<void> getImageGallery() async {
    final PickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (PickedFile != null)
      pickedImage = File(PickedFile.path);
    else
      return null;
    print(pickedImage!.path.toString());
    emit(ChangePhotoState());
  }

  getImageCamera() async {
    final pickedFile =
        await imagePicker.getImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        pickedImage = File(value.path);
      }
    }).catchError((error) {});
    emit(ChangePhotoState());
  }

  remove() async {
    pickedImage = null;
    emit(ChangePhotoState());
  }

    late  UserModel userModel;

  register({
    required String email,
    required String password,
    required String name,

     required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

      createUser(
          phone: phone,
        email: value.user!.email!,
        uId: value.user!.uid,
        name: name


      );

      emit(RegisterSuccessState());
    }).catchError((error) {
      print('error register :${error.toString()}');
      emit(RegisterErrorState());
    });
  }
  createUser({
    required String email,
     required String name,

     required String phone,
    required String uId,
}){
    emit(SignUpLoadingState());
    userModel=  UserModel(
        email: email ,
        uId: uId,
        image:'https://img.freepik.com/free-vector/icon-mans-face-with-light-skin_238404-886.jpg?w=740',

        name: name,
        phone: phone);
    print('reached......................');
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel .uId)
        .set(


        userModel.toMap()

     )

    .then((value) {

      emit(SignUpSuccessState());

    })
        .catchError((error){
          debugPrint('error create :${error.toString()}');
      emit(SignUpErrorState());

    });
  }

  logOut() {
    CacheHelper.removeData(key: 'token');
    emit(LogoutState());
  }
}
