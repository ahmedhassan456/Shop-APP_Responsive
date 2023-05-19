class SearchModel{
  bool? status;
  SearchData? data;

  SearchModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = SearchData.fromJson(json['data']);
  }
}

class SearchData{
  int? currentPage;
  List<ItemSearchData>? data = [];
  SearchData.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data?.add(ItemSearchData.fromJson(element));
    });
  }
}

class ItemSearchData{
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  ItemSearchData.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}