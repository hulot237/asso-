import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';

class CotisationRepository {
  final dio = Dio();
// http://192.168.1.110:3333/api/v1/cotisation/1hcul26gv/show
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
      print(e);
      return {};
    }
  }


  Future<List<dynamic>> AllCotisationOfAss(codeAssociation) async {
    try {
    print("zzzeeezzzzz $codeAssociation");
      log("response AllCotisationOfAss");
      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/cotisation/$codeAssociation',
      );
      print("dataJszzz~~~~~~~~~~zzzzzzzzzzzz      ${response.data["data"]}");

      final List<dynamic> dataJson = response.data["data"];
      // print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee      ${dataJson}");
      log('Okay AllCotisationOfAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllCotisationOfAss rep');
      print(e);
      return [];
    }
  }
}
