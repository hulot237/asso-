import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class MembersRepository {
  final dio = Dio();

  Future<List<dynamic>> showMembersAss(codeAssociation) async {
    try {
      print("zzzeeezzzzz $codeAssociation");
      log("response showMembersAssRepository");
      final response =
          await dio.get('${Variables.LienAIP}/api/v1/membre/$codeAssociation/all');
      print("showMembersAssRepository      ${response.data["membres"]}");

      final List<dynamic> dataJson = response.data["membres"];
      log('Okay showMembersAssRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur showMembersAssRepository rep');
      print(e);
      return [];
    }
  }
}
