import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/DioHelper/DioHelper.dart';
import 'package:shop_app/HomeCubit/HomeStates.dart';
import 'package:shop_app/cacheHelper/CacheHelper.dart';
import 'package:shop_app/constant/constant.dart';
import 'package:shop_app/models/CategoriesModel/CategoriesModel.dart';
import 'package:shop_app/models/HomeModel/HomeModel.dart';
import 'package:shop_app/models/LoginModel/LoginModel.dart';
import 'package:shop_app/modules/Home/BottomNavScreens/CategoriesScreen.dart';
import 'package:shop_app/modules/Home/BottomNavScreens/ProductsScreen.dart';
import 'package:shop_app/modules/Home/BottomNavScreens/SettingScreen.dart';

import '../models/FavoritesModel/FavoritesModel.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitialHomeStates());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = const [
    ProductsScreen(),
    CategoriesScreen(),
    SettingsScreen(),
  ];

  void onChangeNavBar({
    required int index,
  }) {
    currentIndex = index;
    emit(OnChangeBottomNav());
  }

  HomeModel? homeModel;
  Map<int ,bool> favorites = {};

  void getHomeData() {
    emit(HomeLoadingState());

    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      print(token);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });

      print(favorites.toString());
      print(homeModel?.status);
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {

    DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value?.data);
      print(categoriesModel!.data!.data![0].image);
      emit(CategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CategoriesErrorState());
    });
  }


  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavoritesItem(int? id) {

    favorites[id!] = !favorites[id]!;
    emit(AddedToFavState());

    DioHelper.postData(url: 'favorites', data: {
      'product_id': id,
    },token: token).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value?.data);
      print(value?.data);

      if(!changeFavoritesModel!.status!){
        favorites[id] = !favorites[id]!;
      }
      emit(ChangeFavoritesSuccessState(changeFavoritesModel));
    }).catchError((error){
      print(error.toString());
      favorites[id] = !favorites[id]!;
      emit(ChangeFavoritesErrorState());
    });
  }


  LoginModel? userData;
  void getUserData(){
    emit(GetProfileLoadingState());

    DioHelper.getData(url: 'profile',token: token).then((value) {
      userData = LoginModel.fromJson(value?.data);
      emit(GetProfileSuccessState());
}).catchError((error){
  print(error.toString());
  emit(GetProfileErrorState());
    });
  }

  bool? enabled = false;
  void changeEnabled(){
    enabled = !enabled!;
    emit(ChangeEnabled());
  }

}
