import 'package:shop_app/models/FavoritesModel/FavoritesModel.dart';

abstract class HomeStates{}
class InitialHomeStates extends HomeStates{}

class OnChangeBottomNav extends HomeStates{}

class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{}
class HomeErrorState extends HomeStates{}

class CategoriesSuccessState extends HomeStates{}
class CategoriesErrorState extends HomeStates{}

class ChangeFavoritesSuccessState extends HomeStates{
  final ChangeFavoritesModel? model;

  ChangeFavoritesSuccessState(this.model);
}
class ChangeFavoritesErrorState extends HomeStates{}

class AddedToFavState extends HomeStates{}

class GetProfileLoadingState extends HomeStates{}
class GetProfileSuccessState extends HomeStates{}
class GetProfileErrorState extends HomeStates{}

class ChangeEnabled extends HomeStates{}