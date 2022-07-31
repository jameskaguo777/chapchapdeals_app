import 'package:chapchapdeals_app/data/api.dart';
import 'package:chapchapdeals_app/data/model/posts.dart';
import 'package:dio/dio.dart';

class PostRequests {
  static Future<List<PostsModel>> getAllPosts() async {
    try {
      Response response = await Dio().get(
        postsUrl,
      );
      if (response.data['success'] == true) {
        return (response.data['result'] as List)
            .map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<PostsModel>> getPostsByLocationAndCategory(
      String country, String category) async {
    try {
      Response response = await Dio().get(
        postsByLocationAndCategory
            .replaceAll('country', country)
            .replaceAll('category', category),
      );
      if (response.data['success'] == true) {
        return (response.data['result'] as List)
            .map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      return [];
    }
  }
}
