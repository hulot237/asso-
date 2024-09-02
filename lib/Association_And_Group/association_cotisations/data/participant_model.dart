class ParticipantCollectModel {
  List<Participants>? participants;
  int? total;
  int? currentPage;
  bool? hasMorePages;
  int? firstPage;
  int? lastPage;
  bool? isEmpty;

  ParticipantCollectModel(
      {this.participants,
      this.total,
      this.currentPage,
      this.hasMorePages,
      this.firstPage,
      this.lastPage,
      this.isEmpty});

  ParticipantCollectModel.fromJson(Map<String, dynamic> json) {
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(new Participants.fromJson(v));
      });
    }
    total = json['total'];
    currentPage = json['current_page'];
    hasMorePages = json['has_more_pages'];
    firstPage = json['first_page'];
    lastPage = json['last_page'];
    isEmpty = json['is_empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.participants != null) {
      data['participants'] = this.participants!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['current_page'] = this.currentPage;
    data['has_more_pages'] = this.hasMorePages;
    data['first_page'] = this.firstPage;
    data['last_page'] = this.lastPage;
    data['is_empty'] = this.isEmpty;
    return data;
  }
}

class Participants {
  int? id;
  String? name;
  String? phone;
  String? amount;
  String? email;
  String? photoProfile;
  int? assCollecteExterneId;
  String? createdAt;
  String? updatedAt;

  Participants(
      {this.id,
      this.name,
      this.phone,
      this.amount,
      this.email,
      this.photoProfile,
      this.assCollecteExterneId,
      this.createdAt,
      this.updatedAt});

  Participants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    amount = json['amount'];
    email = json['email'];
    photoProfile = json['photo_profile'];
    assCollecteExterneId = json['ass_collecte_externe_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['email'] = this.email;
    data['photo_profile'] = this.photoProfile;
    data['ass_collecte_externe_id'] = this.assCollecteExterneId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}