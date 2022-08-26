import 'package:chapchapdeals_app/data/model/meta.dart';
import 'package:chapchapdeals_app/data/requests/posts.dart';
import 'package:get/get.dart';
import '../model/posts.dart';

class PostsController extends GetxController {
  var posts = <PostsModel>[].obs;
  RxBool isLoading = false.obs;
  var meta = MetaModel().obs;
  RxBool isPaginationLoading = false.obs;

  void getPosts() async {
    posts.value = await PostRequests.getAllPosts();
  }

  void getPostsByLocation(String country) async {
    isLoading.toggle();
    posts.value = await PostRequests.getPostsByLocation(country);
    isLoading.toggle();
  }

  void getPostsByLocationP(String country) async {
    isLoading.toggle();
    await PostRequests.getPostsByLocationWithPagination(country).then((value) {
      posts.value = value.elementAt(0);
      meta.value = value.elementAt(1);
    });
    isLoading.toggle();
  }

  void getPostByLocationWithPagination(String country, {int page = 1}) async {
    isPaginationLoading.toggle();
    await PostRequests.getPostsByLocationWithPagination(country, page: page)
        .then((value) {
      posts.addAll(value.elementAt(0));
      meta.value = value.elementAt(1);
    });
    isPaginationLoading.toggle();
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
