import 'dart:io';
import 'package:ecommerceapplication/screens/landing_screen.dart';
import 'package:intl/intl.dart';
import 'package:ecommerceapplication/models/signupModel.dart';
import 'package:ecommerceapplication/screens/bottom_bar.dart';
import 'package:ecommerceapplication/screens/home.dart';
import 'package:ecommerceapplication/shared/components/constatnts.dart';
import 'package:ecommerceapplication/shared/network/local/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../login_screen.dart';
import 'signup_states.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit() : super(SignupInitialState());

  static SignupCubit get(context) => BlocProvider.of(context);
  bool isVerified = false;
  bool otpVisible = false;

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
    final PickedFile = await imagePicker.getImage(source: ImageSource.gallery)
        .then((value){
      if (value != null)
        pickedImage = File(value.path);
      else
        return null;
     } )
    .catchError((error){
print(error.toString());
    });


    print(pickedImage!.path.toString());
    emit(ChangePhotoState());
  }

  getImageCamera() async {
    await imagePicker.getImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        pickedImage = File(value.path);
       }
    }).catchError((error) {
      print('Error GetPhoto${error.toString()}');
    });
    emit(ChangePhotoState());
  }

  remove() async {
    pickedImage = null;
    emit(ChangePhotoState());
  }
   late UserModel userModel;

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
          name: name);

      emit(RegisterSuccessState(value.user!.uid));
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
  }) {
    emit(SignUpLoadingState());
    userModel = UserModel(
        isVerified: FirebaseAuth.instance.currentUser!.emailVerified,
        email: email,
        uId: uId,
        image:
            imageUrl??'https://img.freepik.com/free-vector/icon-mans-face-with-light-skin_238404-886.jpg?w=740',
        name: name,
        phone: phone,
        shipAddress: 'Egypt-Fayoum-Matrtares',
        dateJoined: DateFormat.yMMMd().format(DateTime.now()).toString());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uId)
        .set(userModel.toMap())
        .then((value) {
      emit(SignUpSuccessState());
    }).catchError((error) {
      debugPrint('error create :${error.toString()}');
      emit(SignUpErrorState());
    });
  }


  verifyEmail() {
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    print('Status :${FirebaseAuth.instance.currentUser!.emailVerified}');
    print('Sent Email');
  }

  logOut(context) {
    CacheHelper.removeData(key: 'uId').then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){return LandingScreen();}), (route) => false);
      FirebaseAuth.instance.signOut();
    });

    emit(LogoutState());
  }
  var imageUrl;
  Future uploadPhoto() async{
    emit(UploadProfilePhotoLoadingState());
   await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(pickedImage!.path).pathSegments.last}')
        .putFile(pickedImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
          imageUrl = value;
          updateUser();
        print(imageUrl);
        pickedImage=null;
        emit(UploadProfilePhotoSuccessState());
      }).catchError((error) {
        print('Error Uploading ${error}');
      });
    }).catchError((error) {
      emit(UploadProfilePhotoErrorState());
    });
  }

   var model;
  getUserData(){
    emit(GetDataLoadingState());
     // FirebaseFirestore.instance.collection('users').doc(token).update({'dateJoined':DateFormat.yMMMd().format(DateTime.now() ).toString()});
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      model=UserModel.fromJson(value.data()!);
       print(model.uId);
      print(model.name);
      print(model.phone);
      emit(GetDataSuccessState());

    })
        .catchError((error){
      emit(GetDataErrorState());
      print(error.toString());

    });
  }
  updateUser(
  {
      String? name,
      String? shipAddress,
      String? phone,
}
      )async{
  model=UserModel(
    email: model.email,
    uId: model.uId,
    image: imageUrl??model.image,
    name: name??model.name,
    phone: phone??model.phone,
    shipAddress:shipAddress?? model.shipAddress,
    dateJoined: model.dateJoined,
    isVerified: isVerified);
        FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .update(
          model.toMap()
        )
          .then((value) {
        emit(PhotoUpdatedSuccessState());
      }).catchError((error){
        emit(PhotoUpdatedErrorState());

      });


     }
     printName(){
    print('Mostafa Hosam ');
     }

}
