import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubitStorage extends HydratedCubit<AppStorageModel> {
  AppCubitStorage()
      : super(
          AppStorageModel(
            Language: "fr",
            codeTournois: null,
            ValTest: "zzzzzz",
            codeAssDefaul: null,
            membreCode: null,
            userNameKey: null,
            passwordKey: null,
          ),
        );

  @override
  AppStorageModel? fromJson(Map<String, dynamic> json) {
    return AppStorageModel(
      Language: json['Language'],
      codeTournois: json["codeTournois"],
      ValTest: json['ValTest'],
      codeAssDefaul: json['codeAssDefaul'],
      membreCode: json["membreCode"],
      userNameKey: json["userNameKey"],
      passwordKey: json["passwordKey"],
    );
  }

  @override
  Map<String, dynamic> toJson(AppStorageModel state) {
    return {
      'Language': state.Language,
      'codeTournois': state.codeTournois,
      'ValTest': state.ValTest,
      'codeAssDefaul': state.codeAssDefaul,
      'membreCode': state.membreCode,
      'userNameKey': state.userNameKey,
      'passwordKey': state.passwordKey,
    };
  }

  void updateLanguage(String language) {
    emit(
      state.copyWith(Language: language),
    );
  }

  void updateValtest(String valtes) {
    emit(
      state.copyWith(ValTest: valtes),
    );
  }

  Future<void> updateCodeTournoisDefault(String newValue) async {
    bool donneesChargees = false;

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(state.copyWith(codeTournois: newValue));
  }

  Future<void> updateCodeAssDefaul(String newValue) async {
    bool donneesChargees = false;

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(state.copyWith(codeAssDefaul: newValue));
  }

  Future<void> updatemembreCode(String newValue) async {
    bool donneesChargees = false;

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(state.copyWith(membreCode: newValue));
  }

  Future<void> updateuserNameKey(String newValue) async {
    bool donneesChargees = false;

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(state.copyWith(userNameKey: newValue));
  }

  Future<void> updatepasswordKey(String newValue) async {
    bool donneesChargees = false;

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(state.copyWith(passwordKey: newValue));
  }
}
