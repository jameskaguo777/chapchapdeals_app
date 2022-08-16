import 'package:chapchapdeals_app/data/requests/posts.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../model/posts.dart';

class PostsController extends GetxController {
  var posts = <PostsModel>[].obs;
  RxBool isLoading = false.obs;

  void getPosts() async {
    posts.value = await PostRequests.getAllPosts();
    if (kDebugMode) {
      print(posts.elementAt(1).description);
    }
  }

  void getPostsByLocation(String country) async {
    isLoading.toggle();
    posts.value = await PostRequests.getPostsByLocation(country);
    
    isLoading.toggle();
  }

  void getPostsByCategoryLocation(String categoryID, String country) async {
    isLoading.toggle();
    posts.value =
        await PostRequests.getPostsByLocationAndCategory(country, categoryID);
    isLoading.toggle();
  }

  Future<List<PostsModel>> getRPostsByCatLoc(
      String catID, String country) async {
    return await PostRequests.getPostsByLocationAndCategory(country, catID);
  }
}
