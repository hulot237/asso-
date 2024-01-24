class CompteModel {
  int? id;
  String? public_ref;
  String? name;
  String? balance;
  String? currency;
  String? faroti_balance;
  String? created_at;
  String? updated_at;
  List? color;

  CompteModel({
    this.id,
    this.public_ref,
    this.name,
    this.balance,
    this.currency,
    this.faroti_balance,
    this.created_at,
    this.updated_at,
    this.color,
  });

  factory CompteModel.fromJson(Map<String, dynamic> json) => CompteModel(
        id: json["id"],
        public_ref: json["public_ref"],
        name: json["name"],
        balance: json["balance"],
        currency: json["currency"],
        faroti_balance: json["faroti_balance"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
      );
}
