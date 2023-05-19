class ChangeFavoritesModel{
  bool? status;
  String? massage;
  ChangeFavData? changeFavData;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    massage = json['message'];
    changeFavData = ChangeFavData.fromJson(json['data']);
  }
}

class ChangeFavData{
  int? id;
  Product? product;
  ChangeFavData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  Product.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }
}