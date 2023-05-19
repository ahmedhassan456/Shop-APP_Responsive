import 'dart:core';

class RegisterModel{
  bool? status;
  String? message;
  UserData? data;

  RegisterModel.fromJson( Map<String,dynamic> json ){
    status = json['status'];
    message = json['message'];
    data = json['status'] ? UserData.fromJson(json['data']): null;
  }
}

class UserData{
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;

  UserData.fromJson( Map<String,dynamic> json ){
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}