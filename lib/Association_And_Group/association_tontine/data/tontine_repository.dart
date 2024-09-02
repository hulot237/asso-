import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';

class TontineRepository {
   final dio = Dio()
    ..interceptors.addAll([
      TokenInterceptor(),
    ]);

  Future<List<dynamic>> DetailTontine(codeTournoi, codeTontine) async {

      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/tontine/$codeTontine/all?membre_code=${AppCubitStorage().state.membreCode}',
      );
      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailTontineDetailTontine rep');
      return dataJson;

  }

  Future<Map<dynamic, dynamic>> DetailContributionTontine(codeContribution) async {
      log("response DetailContributionTontine $codeContribution");

    try {
      log("response DetailContributionTontine");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/contribution/$codeContribution/show-new',
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
