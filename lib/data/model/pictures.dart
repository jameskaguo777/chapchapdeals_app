class PicturesModel {
  int? id;
  String? postID, filename, position, active, createdAt, updatedAt;

  PicturesModel(
      {this.id,
      this.postID,
      this.filename,
      this.position,
      this.active,
      this.createdAt,
      this.updatedAt});

  factory PicturesModel.fromJson(Map<String, dynamic> json) {
    return PicturesModel(
      id : json['id'],
    postID : json['postID'],
    filename : json['filename'],
    position : json['position'],
    active : json['active'],
    createdAt : json['createdAt'],
    updatedAt : json['updatedAt'],
    );
  }
}
