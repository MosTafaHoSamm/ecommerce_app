abstract class SignupStates{}
 class SignupInitialState extends SignupStates{}
 class ChangeVisibilityState extends SignupStates{}
 class ChangePhotoState extends SignupStates{}
 class SignUpSuccessState extends SignupStates{}
 class SignUpErrorState extends SignupStates{}
 class SignUpLoadingState extends SignupStates{}
 class LogoutState extends SignupStates{}
 class RegisterLoadingState extends SignupStates{}
 class RegisterSuccessState extends SignupStates{
 final String uId;
 RegisterSuccessState(this.uId);
 }
 class RegisterErrorState extends SignupStates{}
 class GetUserDataLoadingState extends SignupStates{}
 class GetUserDataSuccessState extends SignupStates{}
 class GetUserDataErrorState extends SignupStates{}
 class UploadProfilePhotoSuccessState extends SignupStates{}
 class UploadProfilePhotoLoadingState extends SignupStates{}
 class UploadProfilePhotoErrorState extends SignupStates{}
 class PhotoUpdatedSuccessState extends SignupStates{}
 class PhotoUpdatedErrorState extends SignupStates{}
class GetDataLoadingState extends SignupStates{

}
class GetDataSuccessState extends SignupStates{

}
class GetDataErrorState extends SignupStates{

}
