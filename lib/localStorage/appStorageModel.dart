class AppStorageModel {
  String? Language;
  String? codeTournois;
  String? ValTest;

  AppStorageModel({
    this.Language,
    this.codeTournois,
    this.ValTest,
  });
  

  AppStorageModel copyWith({
    String? Language,
    String? codeTournois,
    String? ValTest,
  }) {
    return AppStorageModel(
      Language: Language ?? this.Language,
      codeTournois: codeTournois ?? this.codeTournois,
      ValTest: ValTest?? this.ValTest,
    );
  }

  void setValueCodeTournoi(int is_default , String nouvelleValeur) {
    if (is_default == 1) {
      codeTournois = nouvelleValeur;
    }}
}
