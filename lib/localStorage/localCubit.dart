import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubitStorage extends HydratedCubit<AppStorageModel> {
  AppCubitStorage()
      : super(
          AppStorageModel(
            Language: "fr",
            codeTournois: null,
            codeTournoisHist: null,
            xSessionId: null,
            codeAssDefaul: null,
            membreCode: null,
            tokenUser: null,
            tokenNotification: null,
            userNameKey: null,
            passwordKey: null,
            isLoading: false,
            trakingData: null,
            dataCookies: null,
          ),
        );

  @override
  AppStorageModel? fromJson(Map<String, dynamic> json) {
    return AppStorageModel(
      Language: json['Language'],
      codeTournois: json["codeTournois"],
      codeTournoisHist: json['codeTournoisHist'],
      xSessionId: json['xSessionId'],
      codeAssDefaul: json['codeAssDefaul'],
      membreCode: json["membreCode"],
      tokenUser: json["tokenUser"],
      tokenNotification: json["tokenNotification"],
      userNameKey: json["userNameKey"],
      passwordKey: json["passwordKey"],
      isLoading: json["isLoading"],
      trakingData: json["trakingData"],
      dataCookies: json["dataCookies"],
    );
  }

  @override
  Map<String, dynamic> toJson(AppStorageModel state) {
    return {
      'Language': state.Language,
      'codeTournois': state.codeTournois,
      'xSessionId': state.xSessionId,
      'codeAssDefaul': state.codeAssDefaul,
      'membreCode': state.membreCode,
      'tokenUser': state.tokenUser,
      'tokenNotification': state.tokenNotification,
      'userNameKey': state.userNameKey,
      'passwordKey': state.passwordKey,
      'isLoading': state.isLoading,
      "trakingData": state.trakingData,
      'codeTournoisHist': state.codeTournoisHist,
      'dataCookies': state.dataCookies,
    };
  }

  Future<void> updateLanguage(String language) async {
    emit(state.copyWith(isLoading: true));

    emit(
      state.copyWith(
        Language: language,
        isLoading: false,
      ),
    );
  }

  Future<void> updatetokenNotification(String newNotification) async {
    emit(state.copyWith(isLoading: true));

    emit(
      state.copyWith(
        tokenNotification: newNotification,
        isLoading: false,
      ),
    );
  }

  Future<void> updateXSessionId(String? newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));
    do {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);
    emit(
      state.copyWith(
        xSessionId: newValue,
        isLoading: false,
      ),
    );
  }

  Future<void> updateCodeTournoisDefault(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(codeTournois: newValue, isLoading: false),
    );
  }

  Future<void> updateCodeTournoisHist(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(codeTournoisHist: newValue, isLoading: false),
    );
  }

  Future<void> updateCodeAssDefaul(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        isLoading: false,
        codeAssDefaul: newValue,
      ),
    );
  }

  Future<void> updatemembreCode(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        membreCode: newValue,
        isLoading: false,
      ),
    );
  }

  Future<void> updateTokenUser(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        tokenUser: newValue,
        isLoading: false,
      ),
    );
  }

  Future<void> updateuserNameKey(String newValue) async {
    bool donneesChargees = false;
    // print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR 1 $newValue");
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL 1 ${state.userNameKey}");
    emit(state.copyWith(isLoading: true));
    // print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR 2 $newValue");
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL 2 ${state.userNameKey}");

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);
    // print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR 3 $newValue");
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL 3 ${state.userNameKey}");

    emit(
      state.copyWith(
        userNameKey: newValue,
        isLoading: false,
      ),
    );
    // print("RRRRRRRRRRRRRRRRRRRRRRRRRRRRRR 4 $newValue");
    // print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL 4 ${state.userNameKey}");
  }

  Future<void> updatepasswordKey(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        passwordKey: newValue,
        isLoading: false,
      ),
    );
  }


    Future<void> updateDataCookies(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isLoading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        dataCookies: newValue,
        isLoading: false,
      ),
    );
  }

  // Future<void> updateTrakingData(String code, String date, Map<String, dynamic> data) async {
  //   UserAction oneAction = UserAction(code: code, date: date, data: data);

  //   List<UserAction> updatedTrackingData = List.from(state.trakingData ?? [])
  //     ..add(oneAction);
  //   print('trakingData Taille ${updatedTrackingData.length}');
  //   emit(
  //     state.copyWith(
  //       trakingData: updatedTrackingData,
  //       isLoading: false,
  //     ),
  //   );
  //   print('trakingData Taille2 ${state.trakingData!.length}');

  //   // Vérifie si trakingData correspond à updatedTrackingData
  //   if (state.trakingData == updatedTrackingData) {
  //     print('trakingData a bien pris updatedTrackingData');
  //   } else {
  //     print('Erreur: trakingData n\'a pas pris updatedTrackingData');
  //   }
  // }

  Future<void> updateTrakingData(
      String code, String date, Map<String, dynamic> data) async {
    bool donneesChargees = false;
    UserAction oneAction = UserAction(code: code, date: date, data: data);
    List<UserAction> updatedTrackingData = List.from(state.trakingData ?? []);
    updatedTrackingData.add(oneAction);
    print("Contenu de ${updatedTrackingData.length}");
    emit(
      state.copyWith(isLoading: true),
    );
    do {
      await Future.delayed(
        Duration(
          seconds: 1,
        ),
      );
      if (updatedTrackingData != null) {
        // Add newValue to the trakingData list
        // state.trakingData!.add(oneAction);
        print("updateTrakingData1 ${oneAction.code}");
        print("updateTrakingData2 ${oneAction.data}");
        print("updateTrakingData3 ${oneAction.date}");
        donneesChargees = true;
      }
    } while (!donneesChargees);
    emit(
      state.copyWith(
        trakingData: updatedTrackingData,
        isLoading: false,
      ),
    );
    print("Contenu de trakingData: ${state.trakingData!.length}");
  }

  // void trackUserAction(String code, DateTime date, Map<String, dynamic> data) {
  //   // final currentState = state;
  //   state.trakingData!.add(UserAction(code: code, date: date, data: data));
  //   print("AAAAAADDDDDD");
  //   emit(List.from());

  //   if (state.trakingData!.length >= 10) {
  //     _sendDataToAPI(currentState);
  //   }
  // }

  // Future<void> _sendDataToAPI(List<UserAction> actions) async {
  //   final apiUrl = 'YOUR_API_ENDPOINT';
  //   final jsonData = actions.map((action) => action.toJson()).toList();
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(jsonData),
  //   );

  //   if (response.statusCode == 200) {
  //     // Données envoyées avec succès, effacer la liste locale.
  //     emit([]);
  //   } else {
  //     // Gestion des erreurs
  //     print(
  //         'Erreur lors de l\'envoi des données à l\'API: ${response.statusCode}');
  //   }
  // }
  
}
