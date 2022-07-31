class CategoriesModel{
  int? id;
  String? name;
  String? description;
  String? picture;
  

  CategoriesModel({
    this.id,
    this.name,
    this.description,
    this.picture,
    
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    picture = json['picture'];
    
  }
}