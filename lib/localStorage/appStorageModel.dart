// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppStorageModel {
  String? Language;
  String? codeTournois;
  String? ValTest;
  String? codeAssDefaul;
  String? membreCode;
  String? tokenNotification;
  String? passwordKey;
  String? tokenUser;
  String? userNameKey;
  final bool isLoading;

  AppStorageModel({
    this.Language,
    this.codeTournois,
    this.ValTest,
    this.codeAssDefaul,
    this.membreCode,
    this.tokenUser,
    this.tokenNotification,
    this.passwordKey,
    this.isLoading = false,
    this.userNameKey,
  });

  AppStorageModel copyWith({
    String? Language,
    String? codeTournois,
    String? ValTest,
    String? codeAssDefaul,
    String? membreCode,
    String? tokenNotification,
    String? passwordKey,
    String? tokenUser,
    String? userNameKey,
    bool? isLoading, required bool isloading,
  }) {
    return AppStorageModel(
      Language: Language ?? this.Language,
      codeTournois: codeTournois ?? this.codeTournois,
      ValTest: ValTest ?? this.ValTest,
      codeAssDefaul: codeAssDefaul ?? this.codeAssDefaul,
      membreCode: membreCode ?? this.membreCode,
      tokenNotification: tokenNotification ?? this.tokenNotification,
      passwordKey: passwordKey ?? this.passwordKey,
      tokenUser: tokenUser ?? this.tokenUser,
      userNameKey: userNameKey ?? this.userNameKey,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
