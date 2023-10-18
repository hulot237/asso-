class AppStorageModel {
  String? Language;
  String? codeTournois;
  String? ValTest;
  String? codeAssDefaul;

  AppStorageModel({
    this.Language,
    this.codeTournois,
    this.ValTest,
    this.codeAssDefaul,
  });
  

  AppStorageModel copyWith({
    String? Language,
    String? codeTournois,
    String? ValTest,
    String? codeAssDefaul,
  }) {
    return AppStorageModel(
      Language: Language ?? this.Language,
      codeTournois: codeTournois ?? this.codeTournois,
      ValTest: ValTest?? this.ValTest,
      codeAssDefaul: codeAssDefaul?? this.codeAssDefaul,
    );
  }

  void setValueCodeTournoi(int is_default , String nouvelleValeur) {
    if (is_default == 1) {
      codeTournois = nouvelleValeur;
    }}

      void setValuecodeAssDefaul(int is_default , String nouvelleValeur) {
    if (is_default == 1) {
      codeTournois = nouvelleValeur;
    }}
}
