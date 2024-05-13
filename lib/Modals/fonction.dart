import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/business_logic/auth_cubit.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_cubit.dart';
import 'package:faroty_association_1/Modals/variable.dart';
import 'package:faroty_association_1/localStorage/app_storage_model_tracking.dart';
import 'package:faroty_association_1/network/token_interceptor.dart';

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

String formatDateLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedDate =
      DateFormat("dd MMM yyy '${'à'.tr()}' HH:mm").format(dateTime);
  return formattedDate;
}

String formatDateUnikLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedDate = DateFormat("dd MMM yyy").format(dateTime);
  return formattedDate;
}

String formatHeurUnikLiteral(String isoDate) {
  final dateTime = DateTime.parse(isoDate);
  final formattedDate = DateFormat("HH:mm").format(dateTime);
  return formattedDate;
}

String formatCompareDateReturnWellValue(
  String endDate,
) {
  final dateTime = DateTime.parse(endDate);
  final formattedDate = DateFormat("yyy-MM-dd HH:mm:ss").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return ("À l'instant".tr());
  }

  if (endDateApi.compareTo(dt2) < 0) {
    print("DT1 est avant DT2 ${endDateApi.compareTo(dt2)}");

    if (diff.inMinutes * -1 < 1) {
      return ("À l'instant".tr());
    } else if (diff.inMinutes * -1 > 1 && (diff.inHours * -1) < 1) {
      return ("${"Retard de".tr()} ${diff.inMinutes * -1} ${"minutes".tr()}");
    } else if (diff.inHours * -1 > 1 && (diff.inDays * -1) < 1) {
      return ("${"Retard de".tr()} ${diff.inHours * -1} ${"heures".tr()}");
    } else if ((diff.inDays * -1) >= 1 && (diff.inDays * -1) <= 6) {
      return ("${"Retard de".tr()} ${diff.inDays * -1} ${"jours".tr()}");
    } else if ((diff.inDays * -1) == 7) {
      return ("Retard de 1 semaine".tr());
    } else if ((diff.inDays * -1) > 7) {
      return ("${"Retard depuis".tr()} ${formatDateLiteral(endDate)}");
    }
  }

  if (endDateApi.compareTo(dt2) > 0) {
    if (diff.inMinutes < 1) {
      return ("Il vous reste moins d'une minute".tr());
    } else if (diff.inMinutes > 1 && diff.inHours < 1) {
      return ("${"Il vous reste".tr()} ${diff.inMinutes} ${"minutes".tr()}");
    } else if (diff.inHours > 1 && diff.inDays < 1) {
      return ("${"Il vous reste".tr()} ${diff.inHours} ${"heures".tr()}");
    } else if (diff.inDays >= 1 && diff.inDays <= 6) {
      return ("${"Il vous reste".tr()} ${diff.inDays} ${"jours".tr()}");
    } else if (diff.inDays == 7) {
      return ("Il vous reste 1 semaine".tr());
    } else if (diff.inDays > 7) {
      return ("${"Vous avez jusqu'au".tr()} ${formatDateLiteral(endDate)}");
    }
  }

  return formattedDate;
}

String formatCompareDateUnikReturnWellValue(
  String endDate,
) {
  final dateTime = DateTime.parse(endDate);
  final formattedDate = DateFormat("yyy-MM-dd").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return ("À l'instant".tr());
  }

  if (endDateApi.compareTo(dt2) < 0) {
    print("DT1 est avant DT2 ${endDateApi.compareTo(dt2)}");

    if (diff.inMinutes * -1 < 1) {
      return ("À l'instant".tr());
    } else if (diff.inMinutes * -1 > 1 && (diff.inHours * -1) < 1) {
      return ("${"Retard de".tr()} ${diff.inMinutes * -1} ${"minutes".tr()}");
    } else if (diff.inHours * -1 > 1 && (diff.inDays * -1) < 1) {
      return ("${"Retard de".tr()} ${diff.inHours * -1} ${"heures".tr()}");
    } else if ((diff.inDays * -1) >= 1 && (diff.inDays * -1) <= 6) {
      return ("${"Retard de".tr()} ${diff.inDays * -1} ${"jours".tr()}");
    } else if ((diff.inDays * -1) == 7) {
      return ("Retard de 1 semaine".tr());
    } else if ((diff.inDays * -1) > 7) {
      return ("${"Retard depuis".tr()} ${formatDateUnikLiteral(endDate)}");
    }
  }

  if (endDateApi.compareTo(dt2) > 0) {
    if (diff.inMinutes < 1) {
      return ("Il vous reste moins d'une minute".tr());
    } else if (diff.inMinutes > 1 && diff.inHours < 1) {
      return ("${"Il vous reste".tr()} ${diff.inMinutes} ${"minutes".tr()}");
    } else if (diff.inHours > 1 && diff.inDays < 1) {
      return ("${"Il vous reste".tr()} ${diff.inHours} ${"heures".tr()}");
    } else if (diff.inDays >= 1 && diff.inDays <= 6) {
      return ("${"Il vous reste".tr()} ${diff.inDays} ${"jours".tr()}");
    } else if (diff.inDays == 7) {
      return ("Il vous reste 1 semaine".tr());
    } else if (diff.inDays > 7) {
      return ("${"Vous avez jusqu'au".tr()} ${formatDateUnikLiteral(endDate)}");
    }
  }

  return formattedDate;
}

String formatCompareDateReturnWellValueSanctionRecent(String endDate) {
  final dateTime = DateTime.parse(endDate);
  final formattedDate = DateFormat("yyy-MM-dd HH:mm:ss").format(dateTime);

  DateTime endDateApi = DateTime.parse(formattedDate);
  DateTime dt2 = DateTime.now();

  Duration diff = endDateApi.difference(dt2);

  if (endDateApi.compareTo(dt2) == 0) {
    return ("À l'instant".tr());
  }

  if (endDateApi.compareTo(dt2) < 0) {
    print("DT1 est  DT2");

    if (diff.inMinutes * -1 < 1) {
      return ("À l'instant".tr());
    } else if (diff.inMinutes * -1 > 1 && (diff.inHours * -1) < 1) {
      return ("${"Depuis".tr()} ${diff.inMinutes * -1} ${"minutes".tr()}");
    } else if (diff.inHours * -1 > 1 && (diff.inDays * -1) < 1) {
      return ("${"Depuis".tr()} ${diff.inHours * -1} ${"heures".tr()}");
    } else if ((diff.inDays * -1) >= 1 && (diff.inDays * -1) <= 6) {
      return ("${"Depuis".tr()} ${diff.inDays * -1} ${"jours".tr()}");
    } else if ((diff.inDays * -1) == 7) {
      return ("Depuis 1 semaine".tr());
    } else if ((diff.inDays * -1) > 7) {
      return ("${"Depuis".tr()} ${formatDateLiteral(endDate)}");
    }
  }

  return formattedDate;
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

      return false;
    } else {
      //on affiche les details

      return true;
    }
  } else if (transparenceObject.length == 0) {
    return true;
  }
}

checkAdminStatus(bool isAdmin) {
  // Recherche de l'objet dans le tableau avec name == "has_transparence"

  // if (!context.read<AuthCubit>().state.detailUser!["isMember"]) {
  return isAdmin;
  // }
}

isPasseDate(dateRencontreAPI) {
  // Date récupérée de l'API (sous forme de String)
  String apiDateString = dateRencontreAPI;

  // Conversion de la chaîne en un objet DateTime
  DateTime apiDate = DateTime.parse(apiDateString);

  // Date actuelle
  DateTime now = DateTime.now();

  // Comparaison pour savoir si la date de l'API est passée par rapport à la date actuelle
  if (apiDate.isBefore(now)) {
    print('La date de l\'API est passée par rapport à la date actuelle.');
    return true;
  } else {
    return false;
  }
}

String formatDateTimeintegral(String lang, String dateTimeStr) {
  // Conversion de la chaîne de date en objet DateTime
  DateTime dateTime = DateTime.parse(dateTimeStr);

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
    return "Langue non prise en charge";
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
