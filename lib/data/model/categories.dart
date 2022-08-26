class CategoriesModel {
  int? id;
  String? name;
  String? description;
  String? picture;
  String? translationOf;

  CategoriesModel({
    this.id,
    this.name,
    this.description,
    this.picture,
    this.translationOf
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        translationOf: json['translation_of'],
        picture: json['picture']);
  }
}
