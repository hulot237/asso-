import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class CotisationRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> DetailCotisation(codeCotisation) async {
    try {
      log("response DetailCotisation");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/cotisation/$codeCotisation/show',
      );
      final Map<String, dynamic> dataJson = response.data["data"];
      log('Okay DetailCotisation rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailCotisation rep');
      return {};
    }
  }

  Future<List<dynamic>> AllCotisationOfAssTournoi(codeTournoi, codeMembre) async {
    try {
      log("response AllCotisationOfAssAllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeTournoi/membre/$codeMembre/get-cotisation-of-membre',
      );
      final List<dynamic> dataJson = response.data["data"]["cotisations"];
      log('Okay AllCotisationOfAssAllCotisationOfAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllCotisationOfAssAllCotisationOfAss rep');

      return [];
    }
  }
}
