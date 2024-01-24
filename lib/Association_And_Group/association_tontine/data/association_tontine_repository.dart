import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class TontineRepository {
  final dio = Dio();

  Future<List<dynamic>> DetailTontine(codeTournoi, codeTontine) async {
    try {
      print("zzzeeezzzzz $codeTournoi");
      log("response DetailTontineDetailTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/tontine/$codeTontine/all',
      );
      print("DetailTontineDetailTontine      ${response.data["data"]}");

      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailTontineDetailTontine rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailTontineDetailTontine rep');
      print(e);
      return [];
    }
  }

  Future<Map<dynamic, dynamic>> DetailContributionTontine(codeContribution) async {
    try {
      print("DetailContributionTontine $codeContribution");
      log("response DetailContributionTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/contribution/$codeContribution/show',
      );
      print("DetailContributionTontine      ${response.data["data"]}");

      final Map<dynamic, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailContributionTontine rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailContributionTontine rep');
      print(e);
      return {};
    }
  }

}
