class HomeModel{
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData{
  late List<HomeBanners> banners = [];
  late List<HomeProducts> products = [];
  HomeData.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element){
      banners.add(HomeBanners.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(HomeProducts.fromJson(element));
    });
  }
}

class HomeBanners{
  int? id;
  String? image;

  HomeBanners.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

class HomeProducts{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  String? image;

  HomeProducts.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    image = json['image'];
  }
}