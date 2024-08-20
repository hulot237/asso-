import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/association_help_centre/data/help_center_model.dart';

class HelpCenterRepository {
  final dio = Dio();

  Future<List<CategoriesHelpModel>> AllHelpCategorie() async {
    final response = await dio.get(
      'https://admin.main.core.faroty.com/api/v1/support/categories',
    );
    final List<dynamic> dataJson = response.data["categories"];

    final List<CategoriesHelpModel> dataCompteModel = dataJson
        .map<CategoriesHelpModel>((json) => CategoriesHelpModel.fromJson(json))
        .toList();

    return dataCompteModel;
  }

  Future<CategoriesTopicsHelpModel> DetailHelpCategorie(categorieId) async {
    final response = await dio.get(
      'https://admin.main.core.faroty.com/api/v1/support/categories/$categorieId',
    );
    final dataJson = response.data;

    final CategoriesTopicsHelpModel dataCompteModel =
        CategoriesTopicsHelpModel.fromJson(response.data);

    return dataCompteModel;
  }

  Future<List<TopicsHelpModel>> AllHelpTopic(categorieId) async {
    final response = await dio.get(
      'https://admin.main.core.faroty.com/api/v1/support/categories/$categorieId',
    );
    final List<dynamic> dataJson = response.data["topics"];
    print("currentTopicHelp 1 $dataJson" );

    final List<TopicsHelpModel> dataCompteModel = dataJson
        .map<TopicsHelpModel>((json) => TopicsHelpModel.fromJson(json))
        .toList();

    return dataCompteModel;
  }
}
