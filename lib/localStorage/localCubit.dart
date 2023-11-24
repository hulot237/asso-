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
              tokenUser: null,
              // userNameKey: null,
              // passwordKey: null,
              isLoading: false,),
        );

  @override
  AppStorageModel? fromJson(Map<String, dynamic> json) {
    return AppStorageModel(
      Language: json['Language'],
      codeTournois: json["codeTournois"],
      ValTest: json['ValTest'],
      codeAssDefaul: json['codeAssDefaul'],
      membreCode: json["membreCode"],
      tokenUser: json["tokenUser"],
      // userNameKey: json["userNameKey"],
      // passwordKey: json["passwordKey"],
      isLoading: json["isLoading"],
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
      'tokenUser': state.tokenUser,
      // 'userNameKey': state.userNameKey,
      // 'passwordKey': state.passwordKey,
      'isLoading': state.isLoading,

      
    };
  }

  void updateLanguage(String language) {
    emit(state.copyWith(isloading: true));

    emit(
      state.copyWith(
        Language: language,
        isloading: false,
      ),
    );
  }

  void updateValtest(String valtes) {
    emit(state.copyWith(isloading: true));

    emit(
      state.copyWith(
        ValTest: valtes,
        isloading: false,
      ),
    );
  }

  Future<void> updateCodeTournoisDefault(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isloading: true));

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
      state.copyWith(codeTournois: newValue, isloading: false),
    );
  }

  Future<void> updateCodeAssDefaul(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isloading: true));

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
        isloading: false,
        codeAssDefaul: newValue,
      ),
    );
  }

  Future<void> updatemembreCode(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isloading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        membreCode: newValue,
        isloading: false,
      ),
    );
  }


    Future<void> updateTokenUser(String newValue) async {
    bool donneesChargees = false;
    emit(state.copyWith(isloading: true));

    do {
      await Future.delayed(Duration(seconds: 1));
      if (newValue != null) {
        donneesChargees = true;
      }
    } while (!donneesChargees);

    emit(
      state.copyWith(
        tokenUser: newValue,
        isloading: false,
      ),
    );
  }



  // Future<void> updateuserNameKey(String newValue) async {
  //   bool donneesChargees = false;
  //   emit(state.copyWith(isloading: true));

  //   do {
  //     await Future.delayed(Duration(seconds: 1));
  //     if (newValue != null) {
  //       donneesChargees = true;
  //     }
  //   } while (!donneesChargees);

  //   emit(
  //     state.copyWith(
  //       userNameKey: newValue,
  //       isloading: false,
  //     ),
  //   );
  // }

  // Future<void> updatepasswordKey(String newValue) async {
  //   bool donneesChargees = false;
  //   emit(state.copyWith(isloading: true));

  //   do {
  //     await Future.delayed(Duration(seconds: 1));
  //     if (newValue != null) {
  //       donneesChargees = true;
  //     }
  //   } while (!donneesChargees);

  //   emit(
  //     state.copyWith(
  //       passwordKey: newValue,
  //       isloading: false,
  //     ),
  //   );
  // }
}
