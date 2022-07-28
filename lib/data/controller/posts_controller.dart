import 'package:chapchapdeals_app/data/requests/fetch_request/all_posts.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/posts.dart';

class PostsController extends GetxController {
  var posts = <PostsModel>[].obs;

  void getPosts() async {
    posts.value = await PostRequests.getAllPosts();
    if (kDebugMode) {
      print(posts.elementAt(1).description);
    }
  }
}
