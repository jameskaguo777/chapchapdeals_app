class MetaModel {
  int? totalPosts;
  int? lastPage;
  int? currentPage;
  int? perPage;
  String? nextPageUrl;
  String? prevousPageUrl;

  MetaModel(
      {this.currentPage,
      this.lastPage,
      this.nextPageUrl,
      this.perPage,
      this.prevousPageUrl,
      this.totalPosts});

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      nextPageUrl: json['next_page_url'],
      perPage: json['per_page'],
      prevousPageUrl: json['prev_page_url'],
      totalPosts: json['total']
    );
  }
}
