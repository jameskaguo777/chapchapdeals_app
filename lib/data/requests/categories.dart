import 'package:chapchapdeals_app/data/api.dart';
import 'package:chapchapdeals_app/data/model/categories.dart';
import 'package:dio/dio.dart';

class CategoriesRequests{

  static Future<List<CategoriesModel>> getCategories() async{
    try {
      Response response = await Dio().get(
        categoriesUrl,
      );
      if (response.data['success'] == true) {
        return (response.data['result'] as List)
            .map((e) => CategoriesModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      return [];
    }
  }
}