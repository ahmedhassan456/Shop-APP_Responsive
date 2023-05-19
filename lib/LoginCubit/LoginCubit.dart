import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/DioHelper.dart';
import 'package:shop_app/models/LoginModel/LoginModel.dart';

import 'LoginStates.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginModel? shopLoginModel;

  void postData({
    required String email,
    required String password,
}){
    emit(LoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email':email,
      'password':password,
    }).then((value) {
      shopLoginModel = LoginModel.fromJson(value?.data);
      emit(LoginSuccessState(shopLoginModel!));
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
  var obscurePassword = true;
  IconData passwordIcon = Icons.remove_red_eye_outlined;
  void changeItemPasswordLoginScreen(){
    obscurePassword = !obscurePassword;
    passwordIcon = obscurePassword? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordItems());
  }




}