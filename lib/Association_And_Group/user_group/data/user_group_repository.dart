import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class UserGroupRepository {
  final dio = Dio();

  Future<List> AllGroupOfUser(token) async {
    try {
      // Récupérer le token du bloc hydraté
      // final token = AuthCubit().state.token;
      log("response6");

      final response = await dio.post(
        '${Variables.LienAIP}/api/v1/usergroupe/userpages',
        options: Options(
          headers: {
            "token": token,
          },
        ),
      );

      final List<dynamic> dataJson = response.data["data"]["user_groups"];

      final List<dynamic> groups = dataJson;

      log('Okay AllUserGroupOfUser rep');
      return groups;
    } catch (e) {
      log('erreur AllUserGroupOfUser rep');
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> UserGroupDefault(codeAssDefaul) async {
    try {
      log("response10");
      final response = await dio.post(
        '${Variables.LienAIP}/api/v1/usergroupe/default',
        data: {
          "urlcodes": ["$codeAssDefaul"],
        },
        options: Options(
          headers: {
            "token": AppCubitStorage().state.tokenUser,
          },
        ),
      );

      print(
          "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzeeeeeeeeeeeee ${response}");

      // print("dataJsozzzzzzzzzzzzz      ${response.data["data"]["partner_id"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay UserGroupDefaultUserGroupDefault rep');
      return dataJson;
    } catch (e) {
      log('erreur UserGroupDefaultUserGroupDefault rep');
      print(e);
      return {};
    }
  }

  Future<InfoAssModel> ChangerAss(codeAss) async {
    final response = await dio.get(
      '${Variables.LienAIP}/api/v1/usergroupe/$codeAss/show',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
    );

    var data = response.data;

    return InfoAssModel.fromJson(data['data']);
  }

  Future<void> ChangerLang(codeAss, langCode) async {
    final response = await dio.patch(
      '${Variables.LienAIP}/api/v1/usergroup/$codeAss/default-lang?lang=$langCode',
      options: Options(
        headers: {
          "token": AppCubitStorage().state.tokenUser,
        },
      ),
    );
  }

}
