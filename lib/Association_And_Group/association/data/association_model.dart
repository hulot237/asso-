class AssociationModel {
  int? id;
  String? urlcode;
  String? name;
  String? description;
  String? logo;
  int? partner_id;
  String? created_at;
  String? updated_at;


  AssociationModel({
    this.id,
    this.urlcode,
    this.name,
    this.description,
    this.logo,
    this.partner_id,
    this.created_at,
    this.updated_at,

  });

  factory AssociationModel.fromJson(Map<String, dynamic> json) => AssociationModel(
        id: json["id"],
        urlcode: json["urlcode"],
        name: json["name"],
        description: json["description"],
        logo: json["logo"],
        partner_id: json["partner_id"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],

      );
}
