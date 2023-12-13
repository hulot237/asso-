import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';

String formatMontantFrancais(double montant) {
  // Utilise la fonction 'toStringAsFixed' pour formater le montant avec deux décimales
  String montantString = montant.toStringAsFixed(2);

  // Supprime les zéros inutiles à la fin de la partie décimale
  montantString = montantString.replaceAll(RegExp(r"([.]*0)(?!.*\d)"), '');

  // Divise le montant en parties entières et décimales
  List<String> parties = montantString.split('.');

  // Formate la partie entière avec des séparateurs de milliers (espaces)
  String partieEntiere = parties[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]} ');

  // Reconstitue le montant en joignant la partie entière
  String montantFormate = partieEntiere;

  return montantFormate;
}

String formatDate(String dateString) {
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  final outputFormat = DateFormat("dd/MM/yyyy");
  final date = inputFormat.parse(dateString);
  return outputFormat.format(date);
}

String formatTimeToFrench(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedTime = DateFormat.Hm('fr_FR').format(dateTime);
  return formattedTime;
}

String formatTimeToEnglish(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedTime = DateFormat.Hm().format(dateTime);
  return formattedTime;
}

String formatDateToEnglish(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
  return formattedDate;
}

String formatDateToFrench(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  return formattedDate;
}

String formatDateString(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr); // Analyser la date initiale
  String formattedDate = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
  return formattedDate;
}

String formatTime(String dateTimeString) {
  final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  final outputFormat = DateFormat("HH:mm");
  final dateTime = inputFormat.parse(dateTimeString);
  return outputFormat.format(dateTime);
}

checkTransparenceStatus(var ListConfigs, var UserIsMember) {
  // Recherche de l'objet dans le tableau avec name == "has_transparence"

  List<dynamic> transparenceObject =
      ListConfigs.where((objet) => objet["name"] == "has_transparence")
          .toList();
  if (transparenceObject.length > 0) {
    // Vérification si l'objet a été trouvé et si is_check est égal à true
    if (transparenceObject[0]["is_check"] == false && UserIsMember == true) {
      //on masque les details
      print("+++++++++++++++++++++++++++++++++ ${transparenceObject[0]}");
      print("+++++++++++++++++++++++++++++++++ ${UserIsMember}");

      return false;
    } else {
      //on affiche les details
      print("-------------=================------------ ${transparenceObject[0]}");
      print("-------------=================------------  ${UserIsMember}");


      return true;
    }
  } else if (transparenceObject.length == 0){
      print("--------------------------------- 0");
      print("+++++++++++++++++++++++++++++++++ ${UserIsMember}");


    return true;
  }
}
