import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class RecentEventRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> RecentEvent(codeMembre) async {
    try {
    print("zzzeeezzzzz $codeMembre");
      log("response RecentEventRepository");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$codeMembre/get-not-payed-events',
      );
      print("dataRecentEventRepository      ${response.data["data"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay RecentEventRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur RecentEventRepository rep');
      print("RecentEventRepositoryRecentEventRepository  ${e}");
      return {};
    }
  }
}
