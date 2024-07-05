import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/user_model.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/network/localisation_phone/data/localisation_phone_model.dart';

class LocalisationPhoneRepository {
  final dio = Dio();

  Future<LocalisationPhoneModel> fetchData() async {
    try {
      // URL de l'API à appeler
      String apiUrl = 'https://ipapi.co/json';

      // Effectuer la requête GET avec Dio
      Response response = await dio.get(apiUrl);

      // Vérifier si la requête a réussi (code de statut 200)
      if (response.statusCode == 200) {
        // Parser la réponse JSON en un objet LocalisationPhoneModel
        Map<String, dynamic> dataJson = response.data;
        LocalisationPhoneModel localisationPhone =
            LocalisationPhoneModel.fromJson(dataJson);
        return localisationPhone;
      } else {
        // Si la requête échoue, afficher l'erreur
        throw Exception('Failed to load location data');
      }
    } catch (e) {
      print('Error fetching location data: $e');
      // Gérer l'erreur ici
      throw e; // Propager l'erreur pour le gestionnaire de l'avenir
    }
  }

  // Future<List<UserModel>> showMembersAss(codeAssociation) async {
  //   try {
  //     log("response showMembersAssRepository");
  //     final response =
  //         await dio.get('${Variables.LienAIP}/api/v1/membre/$codeAssociation/all');

  //     // final List<dynamic> dataJson = response.data["data"];
  //     // final List<CompteModel> dataCompteModel = dataJson.map<CompteModel>((json)=> CompteModel.fromJson(json)).toList();

  //     final List<dynamic> dataJson = response.data["membres"];
  //     final List<UserModel> dataUserModel = dataJson.map<UserModel>((json)=> UserModel.fromJson(json)).toList();

  //     log('Okay showMembersAssRepository rep');
  //     print("Okay Okay Okay Okay Okay Okay Okay Okay Okay ${dataUserModel}");
  //     return dataUserModel;
  //   } catch (e) {
  //     log('erreur showMembersAssRepository rep');
  //     return [];
  //   }
  // }
}
