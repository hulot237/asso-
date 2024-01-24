import 'dart:convert';
import 'dart:developer';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';

class DetailTournoiCourantRepository {
  final dio = Dio();

  Future<Map<String, dynamic>> DetailTournoiCourant(codeTournoiDefaul) async {
    try {
      log("response7");

      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/${codeTournoiDefaul}/show',
      );

      final Map<String, dynamic> dataJson = response.data["data"];

      print(
          "dataJsozzzzzzzzzzzzzT      ${response.data["data"]["tournois"]["seance"]}");

      log('Okay DetailTournoiCourant rep');
      return dataJson;
    } catch (e) {
      log('erreur DetailTournoiCourant rep');
      print(e);
      return {};
    }
  }

  Future<List<dynamic>> AllTournoiAss(codeAss) async {
    try {
      log("response9");

      final response = await dio.get(
        '${Variables.LienAIP}/api/v1/tournois/$codeAss',
        // data: {
        //   // "urlcodes": Variables().urlcodes,
        // },
      );

      final List<dynamic> dataJson = response.data["data"];

      print("AllTournoiAsseeeeeeeee      ${response.data["data"]}");

      log('Okay AllTournoiAss rep');
      return dataJson;
    } catch (e) {
      log('erreur AllTournoiAss rep');
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> ChangeTournoi(codeTournoi, codeAss) async {
    try {
      log("response4");

      final response = await dio.patch(
        '${Variables.LienAIP}/api/v1/$codeAss/tournois/$codeTournoi/default',
      );

      final Map<String, dynamic> dataJson = response.data["data"];

      print("ChangeTournoiiiiiiiiiiiiiiiiiiiii      ${response.data["data"]}");

      log('Okay ChangeTournoi rep');
      return dataJson;
    } catch (e) {
      log('erreur ChangeTournoi rep');
      print(e);
      return {};
    }
  }

}
