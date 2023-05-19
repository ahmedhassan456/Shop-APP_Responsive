import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/DioHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/models/SearchModel/SearchModel.dart';

import 'SearchStates.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void search({
    required String? text,
}) {
    emit(SearchLoadingState());
    DioHelper.postData(url: 'products/search', data: {
      'text' : text,
    },token: token,).then((value) {
      model = SearchModel.fromJson(value?.data);
      print(value?.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}