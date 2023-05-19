class CategoriesModel{
  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesData.fromJson(json['data']);
  }
}

class CategoriesData{
  int? currentPage;
  List<ListDataCategories>? data = [];
  CategoriesData.fromJson(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element){
      data?.add(ListDataCategories.fromJson(element));
    });
  }
}

class ListDataCategories{
  int? id;
  String? name;
  String? image;
  ListDataCategories.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}