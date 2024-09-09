import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/app_storage_model_tracking.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
// Formatage de l'heure en français
String formatTimeToFrench(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedTime = DateFormat.Hm('fr_FR').format(dateTime);
  return formattedTime;
}

// Formatage de l'heure en anglais
String formatTimeToEnglish(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedTime = DateFormat.Hm().format(dateTime);
  return formattedTime;
}

// Formatage de la date en anglais
String formatDateToEnglish(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
  return formattedDate;
}

// Formatage de la date en français
String formatDateToFrench(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  return formattedDate;
}

// Formatage de la date avec une chaîne littérale
String formatDateLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("dd MMM yyyy 'à' HH:mm").format(dateTime);
  return formattedDate;
}

// Formatage de la date avec une chaîne littérale unique
String formatDateUnikLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
  return formattedDate;
}

// Formatage de l'heure avec une chaîne littérale unique
String formatHeurUnikLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("HH:mm").format(dateTime);
  return formattedDate;
}

// Comparaison de dates avec des valeurs bien définies
String formatCompareDateReturnWellValue(String endDate) {
  final dateTime = DateTime.parse(endDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return "À l'instant";
  }

  if (endDateApi.compareTo(dt2) < 0) {
    if (diff.inMinutes * -1 < 1) {
      return "À l'instant";
    } else if (diff.inMinutes * -1 > 1 && diff.inHours * -1 < 1) {
      return "Retard de ${diff.inMinutes * -1} minutes";
    } else if (diff.inHours * -1 > 1 && diff.inDays * -1 < 1) {
      return "Retard de ${diff.inHours * -1} heures";
    } else if (diff.inDays * -1 >= 1 && diff.inDays * -1 <= 6) {
      return "Retard de ${diff.inDays * -1} jours";
    } else if (diff.inDays * -1 == 7) {
      return "Retard de 1 semaine";
    } else if (diff.inDays * -1 > 7) {
      return "Retard depuis ${formatDateLiteral(endDate)}";
    }
  }

  if (endDateApi.compareTo(dt2) > 0) {
    if (diff.inMinutes < 1) {
      return "Il vous reste moins d'une minute";
    } else if (diff.inMinutes > 1 && diff.inHours < 1) {
      return "Il vous reste ${diff.inMinutes} minutes";
    } else if (diff.inHours > 1 && diff.inDays < 1) {
      return "Il vous reste ${diff.inHours} heures";
    } else if (diff.inDays >= 1 && diff.inDays <= 6) {
      return "Il vous reste ${diff.inDays} jours";
    } else if (diff.inDays == 7) {
      return "Il vous reste 1 semaine";
    } else if (diff.inDays > 7) {
      return "Vous avez jusqu'au ${formatDateLiteral(endDate)}";
    }
  }

  return formattedDate;
}

// Comparaison de dates avec des valeurs bien définies (format unique)
String formatCompareDateUnikReturnWellValue(String endDate) {
  final dateTime = DateTime.parse(endDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return "À l'instant";
  }

  if (endDateApi.compareTo(dt2) < 0) {
    if (diff.inMinutes * -1 < 1) {
      return "À l'instant";
    } else if (diff.inMinutes * -1 > 1 && diff.inHours * -1 < 1) {
      return "Retard de ${diff.inMinutes * -1} minutes";
    } else if (diff.inHours * -1 > 1 && diff.inDays * -1 < 1) {
      return "Retard de ${diff.inHours * -1} heures";
    } else if (diff.inDays * -1 >= 1 && diff.inDays * -1 <= 6) {
      return "Retard de ${diff.inDays * -1} jours";
    } else if (diff.inDays * -1 == 7) {
      return "Retard de 1 semaine";
    } else if (diff.inDays * -1 > 7) {
      return "Retard depuis ${formatDateUnikLiteral(endDate)}";
    }
  }

  if (endDateApi.compareTo(dt2) > 0) {
    if (diff.inMinutes < 1) {
      return "Il vous reste moins d'une minute";
    } else if (diff.inMinutes > 1 && diff.inHours < 1) {
      return "Il vous reste ${diff.inMinutes} minutes";
    } else if (diff.inHours > 1 && diff.inDays < 1) {
      return "Il vous reste ${diff.inHours} heures";
    } else if (diff.inDays >= 1 && diff.inDays <= 6) {
      return "Il vous reste ${diff.inDays} jours";
    } else if (diff.inDays == 7) {
      return "Il vous reste 1 semaine";
    } else if (diff.inDays > 7) {
      return "Vous avez jusqu'au ${formatDateUnikLiteral(endDate)}";
    }
  }

  return formattedDate;
}

// Comparaison de dates avec des valeurs bien définies (pour sanctions récentes)
String formatCompareDateReturnWellValueSanctionRecent(String endDate) {
  final dateTime = DateTime.parse(endDate).toLocal(); // Conversion en heure locale
  final formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return "À l'instant";
  }

  if (endDateApi.compareTo(dt2) < 0) {
    if (diff.inMinutes * -1 < 1) {
      return "À l'instant";
    } else if (diff.inMinutes * -1 > 1 && diff.inHours * -1 < 1) {
      return "Depuis ${diff.inMinutes * -1} minutes";
    } else if (diff.inHours * -1 > 1 && diff.inDays * -1 < 1) {
      return "Depuis ${diff.inHours * -1} heures";
    } else if (diff.inDays * -1 >= 1 && diff.inDays * -1 <= 6) {
      return "Depuis ${diff.inDays * -1} jours";
    } else if (diff.inDays * -1 == 7) {
      return "Depuis 1 semaine";
    } else if (diff.inDays * -1 > 7) {
      return "Depuis ${formatDateLiteral(endDate)}";
    }
  }

  return formattedDate;
}

checkTransparenceStatus(var ListConfigs, var UserIsMember) {
  // Recherche de l'objet dans le tableau avec name == "has_transparence"

  List<dynamic> transparenceObject =
      ListConfigs.where((objet) => objet["name"] == "has_transparence")
          .toList();
  // print("${transparenceObject}");
  if (transparenceObject.length > 0) {
    // Vérification si l'objet a été trouvé et si is_check est égal à true
    if (transparenceObject[0]["is_check"] == false && UserIsMember == true) {
      //on masque les details
      // print("checkTransparenceStatus false");
      return false;
    } else {
      //on affiche les details
      // print("checkTransparenceStatus true");
      return true;
    }
  } else if (transparenceObject.length == 0) {
    // print("checkTransparenceStatus true");
    return true;
  }
}

checkTransparenceLoans(var ListConfigs, var UserIsMember) {
  // Recherche de l'objet dans le tableau avec name == "has_transparence"

  List<dynamic> transparenceObject =
      ListConfigs.where((objet) => objet["name"] == "has_loans").toList();

  if (transparenceObject.length > 0) {
    // Vérification si l'objet a été trouvé et si is_check est égal à true
    if (transparenceObject[0]["is_check"] == false || UserIsMember == true) {
      //on masque les details
      print("checkTransparenceLoans false");
      return false;
    } else if (transparenceObject[0]["is_check"] == true &&
        UserIsMember == false) {
      //on affiche les details

      return true;
    } else {
      return false;
    }
  } else if (transparenceObject.length == 0) {
    print("checkTransparenceLoans true");
    return false;
  }
}

checkAdminStatus(bool isAdmin) {
  // Recherche de l'objet dans le tableau avec name == "has_transparence"

  // if (!context.read<AuthCubit>().state.detailUser!["isMember"]) {
  return isAdmin;
  // }
}

// isPasseDate(dateRencontreAPI) {
//   // Date récupérée de l'API (sous forme de String)
//   String apiDateString = dateRencontreAPI;

//   // Conversion de la chaîne en un objet DateTime
//   DateTime apiDate = DateTime.parse(apiDateString);

//   // Date actuelle
//   DateTime now = DateTime.now();

//   // Comparaison pour savoir si la date de l'API est passée par rapport à la date actuelle
//   if (apiDate.isBefore(now)) {
//     print('La date de l\'API est passée par rapport à la date actuelle.');
//     return true;
//   } else {
//     return false;
//   }
// }

String formatDateTimeintegral(String lang, String dateTimeStr) {
  // Conversion de la chaîne de date en objet DateTime et conversion en heure locale
  DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();

  // Récupération du nom du jour de la semaine et du mois en fonction de la langue
  String dayOfWeek;
  String month;

  if (lang.toLowerCase() == 'en') {
    dayOfWeek = DateFormat.E().format(dateTime);
    month = DateFormat.MMM().format(dateTime);
  } else if (lang.toLowerCase() == 'fr') {
    dayOfWeek = DateFormat.E('fr_FR').format(dateTime);
    month = DateFormat.MMM('fr_FR').format(dateTime);
  } else {
    return "Language not supported"; // Message en anglais pour les langues non supportées
  }

  // Formattage de la date dans le format demandé
  String formattedDate = '$dayOfWeek ${dateTime.day} $month ${dateTime.year}';

  return formattedDate;
}

String removeBBalise(String htmlString) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '');
}

trakingActivity(String code, String data, String date) {}

updateTrackingData(String code, String date, Map<String, dynamic> data) async {
  List<UserAction> updatedTrackingData = []; // Initialisation de la liste
  print("$date");
  UserAction oneAction = UserAction(code: code, date: date, data: data);
  updatedTrackingData.add(oneAction);
  print("$updatedTrackingData");
  // Envoi de la liste à l'API en utilisant Dio
  try {
    // Créer une instance de Dio
    Dio dio = Dio()
      ..interceptors.addAll([
        TokenInterceptor(),
      ]);

    // Envoi des données à l'API
    Response response = await dio.post(
      '${Variables.LienAIP}/api/v1/save-user-actions',
      data: {"events": updatedTrackingData},
    );

    // Vérifier si la requête a réussi
    if (response.statusCode == 200) {
      print('Données de suivi mises à jour avec succès.');
    } else {
      print('Échec de la mise à jour des données de suivi.');
    }
  } catch (e) {
    print('Erreur lors de la mise à jour des données de suivi: $e');
  }
}

Future<void> launchWeb(webUrl) async {
  final url = webUrl;
  var uri = Uri.parse(url);
  if (!await launchUrl(uri, webOnlyWindowName: "Votre espace ASSO+".tr())) {
    throw 'Could not launch';
  }
}

partagerCotisation({
  required String nomGroupe,
  required String source,
  required String nomBeneficiaire,
  required String montantCotisations,
  required String dateCotisation,
  required String lienDePaiement,
  required String type,
  required List<dynamic> listeOkayCotisation,
  required BuildContext context,
  // required BuildContext context,
}) {
  String message = "";

  print("Wsource $nomBeneficiaire");

  message +=
      "🟢🟢 ${"Nouvelle cotisation en cours dans le groupe".tr()} *${nomGroupe}* ${"concernant".tr()} ${source == '**' ? '${nomBeneficiaire}' : '${source}'}\n\n ";

  message +=
      "👉🏽 ${(source == '**' ? "${"MEMBRE CONCERNÉ".tr()}" : "${"SEANCE CONCERNÉE".tr()}")} : ${source == '**' ? '${nomBeneficiaire}' : '${source}'}\n";
  message +=
      "👉🏽 ${"montant".tr().toUpperCase()} : ${type == "1" ? "*${"volontaire".tr()}*" : "*${formatMontantFrancais(double.parse(montantCotisations))} FCFA*"}\n";
  message +=
      "👉🏽 ${"Date limite".tr().toUpperCase()}: *${(formatDateLiteral(dateCotisation))}*\n\n";

  // message += "Soyez le premier à contribuer ici :  https://$lienDePaiement\n\n";
  message += !context.read<AuthCubit>().state.detailUser!["isMember"]
      ? "${"Soyez le premier à contribuer ici".tr()} :  https://$lienDePaiement\n\n"
      : "${"Aide-moi à payer ma cotisation en suivant le lien".tr()} https://$lienDePaiement?code=${AppCubitStorage().state.membreCode}\n\n";

  message += "*${"Récapitulatif".tr()} :*\n";
  // Calcul du total et ajout des détails par membre
  double totalCotisations = 0;
  for (var element in listeOkayCotisation) {
    String firstName = element["membre"]["first_name"];
    String lastName = element["membre"]["last_name"] ?? "";
    double balance =
        double.parse(element["balance"]); // Conversion de la balance en nombre

    // Déterminer le message en fonction de la balance et du statut
    String statusIcon;
    String messagePart;

    if (balance == 0) {
      statusIcon = "❌";
      messagePart = "- ${firstName} ${lastName} ${statusIcon}";
    } else {
      // Formater la balance pour enlever les décimales et ajouter des séparateurs de milliers
      String formattedBalance = formatMontantFrancais(balance);

      if (element["statut"] == "2") {
        statusIcon = "✅";
      } else {
        statusIcon = "⏳";
      }

      messagePart =
          "- ${firstName} ${lastName} -> ${formattedBalance} F ${statusIcon}";
    }

    // Ajouter la ligne au message
    message += "$messagePart\n";

    // Ajouter à la somme totale des cotisations
    totalCotisations += balance;
  }

  // Formater le total des cotisations pour enlever les décimales et ajouter des séparateurs de milliers
  // String formattedTotal =
  //     NumberFormat.decimalPattern().format(totalCotisations.toInt());

  message += "\n*TOTAL -> ${formatMontantFrancais(totalCotisations)} F*\n\n";

  message += "*by ASSO+*";

  // Partager le message en utilisant Flutter Share
  Share.share(
    message,
  );
}

partagerContributionTontine({
  required String nomGroupe,
  required String nomBeneficiaire,
  required String montantCotisations,
  required String dateCotisation,
  required String lienDePaiement,
  required String nomTontine,
  required String motif,
  required List<dynamic> listeOkayCotisation,
  required BuildContext context,
}) {
  print("nomGroupe $nomGroupe");
  print("nomBeneficiaire $nomBeneficiaire");
  print("montantCotisations $montantCotisations");
  print("dateCotisation $dateCotisation");
  print("lienDePaiement $lienDePaiement");
  print("nomTontine $nomTontine");
  print("motif $motif");
  print("membreCode ${AppCubitStorage().state.membreCode}");

  String message = "";

  message +=
      "🟢🟢 ${"Nouvelle session de la tontine".tr()} *${nomTontine}* ${"en cours dans le groupe".tr()} *${nomGroupe}* ${"concernant".tr()} *${nomBeneficiaire}*\n\n";

  message += "👉🏽 ${"MEMBRE CONCERNÉ".tr()} : *${nomBeneficiaire}*\n";
  message += "👉🏽 MOTIF : *${motif}*\n";
  message +=
      "👉🏽 ${"montant".tr().toUpperCase()} : ${"*${formatMontantFrancais(double.parse(montantCotisations))} FCFA*"}\n";
  message +=
      "👉🏽 ${"Date limite".tr().toUpperCase()}: *${(formatDateLiteral(dateCotisation))}*\n\n";

  message += !context.read<AuthCubit>().state.detailUser!["isMember"]
      ? "${"Soyez le premier à contribuer ici".tr()} :  https://$lienDePaiement\n\n"
      : "${"Aide-moi à payer ma tontine en suivant le lien".tr()} https://$lienDePaiement?code=${AppCubitStorage().state.membreCode}\n\n";

  message += "*${"Récapitulatif".tr()} :*\n";
  double totalCotisations = 0;

  // for (var element in listeOkayCotisation) {
  //   String firstName = element["membre"]["first_name"];
  //   String lastName = element["membre"]["last_name"] ?? "";
  //   double balance =
  //       double.parse(element["balance"]);

  //   message +=
  //       "- ${firstName.trimRight()}  ${lastName.trimRight()} -> ${formatMontantFrancais(balance)} F ${element["statut"] == "2" ? "✅" : "❌"}\n";
  //   totalCotisations += balance;
  // }

  for (var element in listeOkayCotisation) {
    String firstName = element["membre"]["first_name"];
    String lastName = element["membre"]["last_name"] ?? "";
    double balance =
        double.parse(element["balance"]); // Conversion de la balance en nombre

    // Déterminer le message en fonction de la balance et du statut
    String statusIcon;
    String messagePart;

    if (balance == 0) {
      statusIcon = "❌";
      messagePart = "- ${firstName.trimRight()} ${lastName.trimRight()} ${statusIcon}";
    } else {
      // Formater la balance pour enlever les décimales et ajouter des séparateurs de milliers
      String formattedBalance = formatMontantFrancais(balance);

      if (element["statut"] == "2") {
        statusIcon = "✅";
      } else {
        statusIcon = "⏳";
      }

      messagePart =
          "- ${firstName} ${lastName} -> ${formattedBalance} F ${statusIcon}";
    }

    // Ajouter la ligne au message
    message += "$messagePart\n";

    // Ajouter à la somme totale des cotisations
    totalCotisations += balance;
  }

  message += "\n*TOTAL -> ${formatMontantFrancais(totalCotisations)} F*\n\n";

  message += "*by ASSO+*";

  Share.share(
    message,
  );
}

bool hasPassed48Hours(String dateString) {
  try {
    // Convertir la chaîne en objet DateTime et la convertir en heure locale
    DateTime givenDate = DateTime.parse(dateString).toLocal();

    // Date actuelle en heure locale
    DateTime now = DateTime.now();

    // Calculer la différence en heures entre maintenant et la date donnée
    Duration difference = now.difference(givenDate);

    // Nombre d'heures dans 48 heures
    Duration fortyEightHours = Duration(hours: 48);

    // Vérifier si la différence est d'au moins 48 heures
    return difference >= fortyEightHours;
  } catch (e) {
    // Gérer les erreurs de parsing de date
    print('Erreur lors de la conversion de la date : $e');
    return false;
  }
}

bool isPasseDate(String dateRencontreAPI) {
  try {
    // Conversion de la chaîne en un objet DateTime et la convertir en heure locale
    DateTime apiDate = DateTime.parse(dateRencontreAPI).toLocal();

    // Date actuelle en heure locale
    DateTime now = DateTime.now();

    // Comparaison pour savoir si la date de l'API est passée par rapport à la date actuelle
    return apiDate.isBefore(now);
  } catch (e) {
    // Gérer les erreurs de parsing de date
    print('Erreur lors de la conversion de la date : $e');
    return false;
  }
}

bool isPasseDateOneDay(String dateRencontreAPI) {
  try {
    // Conversion de la chaîne en un objet DateTime et la convertir en heure locale
    DateTime apiDate = DateTime.parse(dateRencontreAPI).toLocal();

    // Date actuelle en heure locale
    DateTime now = DateTime.now();

    // Durée maximale de 24 heures
    Duration seuil = Duration(hours: 24);

    // Calcul de la différence entre maintenant et la date de l'API
    Duration difference = now.difference(apiDate);

    // Comparaison pour vérifier si la différence est supérieure à 24 heures
    return difference > seuil;
  } catch (e) {
    // Gérer les erreurs de parsing de date
    print('Erreur lors de la conversion de la date : $e');
    return false;
  }
}
