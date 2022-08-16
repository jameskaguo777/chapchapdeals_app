import 'package:chapchapdeals_app/data/api.dart';
import 'package:chapchapdeals_app/data/model/posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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
        postsByLocationAndCategoryUrl
            .replaceAll('country', country)
            .replaceAll('category', category),
      );
      if (response.data['success'] == true) {
        if (kDebugMode) {
          print(response.data['result']);
        }

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

  static Future<List<PostsModel>> getPostsByLocation(String country) async {
    try {
      Response response = await Dio().get(
        postsByLocationUrl.replaceAll('country', country),
      );
      if (response.data['success'] == true) {
        return (response.data['result'] as List)
            .map((e) => PostsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<PostsModel>> getPostsByLocationAndPagination(
      String country, {int page = 1}) async {
    try {
      Response response = await Dio().get(
        postsByLocationAndPaginationUrl
            .replaceAll('country', country)
            + page.toString(),
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
