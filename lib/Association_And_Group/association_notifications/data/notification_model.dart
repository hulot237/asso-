class NotificationModel {
  int? id;
  String? authorName;
  String? mode;
  String? sourceName;
  int? sourceId;
  String? valeur;
  String? description;
  int? isReaded;
  int? isActive;
  String? type;
  int? assMembreId;
  String? createdAt;
  String? updatedAt;
  String? tartgetCode;

  NotificationModel(
      {this.id,
      this.authorName,
      this.mode,
      this.sourceName,
      this.sourceId,
      this.valeur,
      this.description,
      this.isReaded,
      this.isActive,
      this.type,
      this.assMembreId,
      this.createdAt,
      this.updatedAt,
      this.tartgetCode});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authorName = json['author_name'];
    mode = json['mode'];
    sourceName = json['source_name'];
    sourceId = json['source_id'];
    valeur = json['valeur'];
    description = json['description'];
    isReaded = json['is_readed'];
    isActive = json['is_active'];
    type = json['type'];
    assMembreId = json['ass_membre_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tartgetCode = json['tartget_code'];
  }
}