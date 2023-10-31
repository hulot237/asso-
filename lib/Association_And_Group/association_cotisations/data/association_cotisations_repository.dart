import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class CotisationRepository {
  final dio = Dio();
  Future<Map<String, dynamic>> DetailCotisation(codeCotisation) async {
    try {
    print("zzzeeezzzzz $codeCotisation");
      log("response DetailCotisation");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/cotisation/$codeCotisation/show',
      );
      print("dataJszzzaaaaaaaaaaaaaazzzzzzzzzzzzz      ${response.data["data"]}");

      final Map<String, dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay DetailCotisation rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailCotisation rep');
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  ${e}");
      return {};
    }
  }


  Future<List<dynamic>> AllCotisationOfAssTournoi(codeTournoi) async {
    try {
    print("zzzeeezzzzz $codeTournoi");
      log("response AllCotisationOfAssAllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/cotisation/tournois/$codeTournoi',
      );
      print("AllCotisationOfAssAllCotisationOfAss      ${response.data["data"]}");

      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay AllCotisationOfAssAllCotisationOfAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllCotisationOfAssAllCotisationOfAss rep');
      print(e);
      return [];
    }
  }
}
