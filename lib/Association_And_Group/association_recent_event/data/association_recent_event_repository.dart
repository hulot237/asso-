import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class RecentEventRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> RecentEvent(codeMembre) async {
    try {
      log("response RecentEventRepository");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/membre/$codeMembre/get-not-payed-events',
      );

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay RecentEventRepository rep');
      return dataJson;
    } catch (e) {
      log('erreur RecentEventRepository rep');
      return {};
    }
  }
}
