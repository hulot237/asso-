import 'package:faroty_association_1/localStorage/appStorageModel.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubitStorage extends HydratedCubit<AppStorageModel> {
  AppCubitStorage()
      : super(
          AppStorageModel(
            Language: "fr",
            codeTournois: "z",
            ValTest: "zzzzzz",
          ),
        );

  @override
  AppStorageModel? fromJson(Map<String, dynamic> json) {
    return AppStorageModel(
      Language: json['Language'],
      codeTournois: json["codeTournois"],
      ValTest: json['ValTest'],
    );
  }

  @override
  Map<String, dynamic> toJson(AppStorageModel state) {
    return {
      'Language': state.Language,
      'codeTournois': state.codeTournois,
      'ValTest': state.ValTest,
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

  // void  updateCodeTournoisDefault(String codetournois) {
  //   emit(
  //     state.copyWith(codeTournois: codetournois),
  //   );
  // }

  // Utilisez async/await dans cette méthode
  // Future<void> updateCodeTournoisDefault(String newValue) async{
  //   // Effectuez ici une opération asynchrone si nécessaire.
  //   await Future.doWhile(() => newValue==null);

  //   // Mise à jour de valeur1
  //   emit(state.copyWith(codeTournois: newValue));
  // }

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

  // void updateValeur1WithValA(int valA, String newValue) {
  //   state.setValueCodeTournoi(valA, newValue);
  //   emit(state.copyWith(codeTournois: newValue));
  // }
}
