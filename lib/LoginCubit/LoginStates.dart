import 'package:shop_app/models/LoginModel/LoginModel.dart';

abstract class LoginState{}
class LoginInitialState extends LoginState{}


class LoginLoadingState extends LoginState{}
class LoginSuccessState extends LoginState{
  final LoginModel shopLoginModel;

  LoginSuccessState(this.shopLoginModel);
}
class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);

}

class LoginPasswordItems extends LoginState{}

class BooleanOnBoarding extends LoginState{
  final bool onBoarding;

  BooleanOnBoarding(this.onBoarding);
}