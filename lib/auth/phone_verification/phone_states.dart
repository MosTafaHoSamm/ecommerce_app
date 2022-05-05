abstract class PhoneStates{}
 class PhoneInitialState extends PhoneStates{}
 class ChangeFieldCodeState extends PhoneStates{}
 class LoginWithCredintialLoadingState extends PhoneStates{}
 class LoginWithCredintialSuccessState extends PhoneStates{
 final String tokencerd;
 LoginWithCredintialSuccessState(this.tokencerd);
 }
 class LoginWithCredintialErrorState extends PhoneStates{}

