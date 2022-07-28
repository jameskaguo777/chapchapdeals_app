import 'dart:collection';

import 'package:chapchapdeals_app/data/model/pictures.dart';

class PostsModel {
  int? postID;
  String? cid;
  String? title;
  String? price;
  String? description;
  String? createdAt;
  String? address;
  List<PicturesModel>? images;

  PostsModel(
      {this.address,
      this.cid,
      this.createdAt,
      this.description,
      this.images,
      this.postID,
      this.price,
      this.title});

  PostsModel.fromJson(Map<String, dynamic> json) {
    postID = json['postid'];
    cid = json['cid'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    address = json['address'];
    if (json['picture'] != null) {
      images = <PicturesModel>[];
      json['picture'].forEach((v) {
        images?.add(PicturesModel.fromJson(v));
      });
    }
  }
}
