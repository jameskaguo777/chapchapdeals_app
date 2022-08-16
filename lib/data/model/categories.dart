class CategoriesModel {
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

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        picture: json['picture']);
  }
}
