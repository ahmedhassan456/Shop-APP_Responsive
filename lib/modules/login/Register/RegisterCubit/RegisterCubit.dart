import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/DioHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/models/RegisterModel/RegisterModel.dart';
import 'package:shop_app/modules/login/Register/RegisterCubit/RegisterStates.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? registerModel;

  void register({
    required String? name,
    required String? email,
    required String? phone,
    required String? password,
}){
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'name':name,
      'email': email,
      'password':password,
      'phone':phone,
} , token: token).then((value) {
      registerModel = RegisterModel.fromJson(value?.data);
      emit(RegisterSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(RegisterErrorState());
    });
  }
}