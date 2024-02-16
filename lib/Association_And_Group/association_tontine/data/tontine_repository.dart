import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class TontineRepository {
  final dio = Dio();

  Future<List<dynamic>> DetailTontine(codeTournoi, codeTontine) async {
    try {
      log("response DetailTontineDetailTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/tontine/$codeTontine/all?membre_code=${AppCubitStorage().state.membreCode}',
      );
      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailTontineDetailTontine rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailTontineDetailTontine rep');
      return [];
    }
  }

  Future<Map<dynamic, dynamic>> DetailContributionTontine(codeContribution) async {
    try {
      log("response DetailContributionTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/contribution/$codeContribution/show',
      );
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
