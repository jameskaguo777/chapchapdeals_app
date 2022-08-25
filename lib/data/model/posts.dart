import 'package:chapchapdeals_app/data/model/pictures.dart';

class PostsModel {
  int? postID;
  String? cid;
  String? title;
  String? price;
  String? description;
  String? createdAt;
  String? address;
  String? latitude;
  String? longitude;
  String? phone;
  List<PicturesModel>? images;

  PostsModel(
      {this.address,
      this.cid,
      this.createdAt,
      this.description,
      this.images,
      this.postID,
      this.price,
      this.title,
      this.phone,
      this.latitude,
      this.longitude});

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      postID: json['postid'],
      cid: json['cid'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      createdAt: json['created_at'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      phone: json['phone'],
      images: json['picture'] != null
          ? (json['picture'] as List)
              .map((e) => PicturesModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}
// (if (json['picture'] != null) {
//       images = <PicturesModel>[];
//       json['picture'].forEach((v) {
//         images?.add(PicturesModel.fromJson(v));
//       });
//     })