class AppStorageModel {
  String? Language;
  String? codeTournois;
  String? ValTest;
  String? codeAssDefaul;
  String? membreCode;
  String? userNameKey;
  String? passwordKey;
    final bool isLoading;



  AppStorageModel({
    this.Language,
    this.codeTournois,
    this.ValTest,
    this.codeAssDefaul,
    this.membreCode,
    this.userNameKey,
    this.isLoading = false,
    this.passwordKey,

  });

  AppStorageModel copyWith({
    String? Language,
    String? codeTournois,
    String? ValTest,
    String? codeAssDefaul,
    String? membreCode,
    String? userNameKey,
    String? passwordKey,
    required bool isloading,


  }) {
    return AppStorageModel(
      Language: Language ?? this.Language,
      codeTournois: codeTournois ?? this.codeTournois,
      ValTest: ValTest ?? this.ValTest,
      codeAssDefaul: codeAssDefaul ?? this.codeAssDefaul,
      membreCode: membreCode ?? this.membreCode,
      userNameKey: userNameKey?? this.userNameKey,
      passwordKey: passwordKey?? this.passwordKey,
          isLoading: isloading,



    );
  }
}
