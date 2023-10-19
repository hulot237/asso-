import 'package:easy_localization/easy_localization.dart';

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