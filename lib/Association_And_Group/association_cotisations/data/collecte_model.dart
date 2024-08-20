class CollecteModel {
  bool? error;
  List<Collections>? collections;
  Data? data;

  CollecteModel({this.error, this.collections, this.data});

  CollecteModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['collections'] != null) {
      collections = <Collections>[];
      json['collections'].forEach((v) {
        collections!.add(new Collections.fromJson(v));
      });
    }
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Collections {
  int? id;
  String? code;
  int? userCreate;
  String? motif;
  String? description;
  String? startDate;
  String? colImage;
  String? collectPayLink;
  String? endDate;
  int? isActive;
  int? isPassed;
  String? type;
  String? amount;
  String? collectStatus;
  String? collectBalance;
  int? assCompteId;
  int? assRubriqueCotisationId;
  int? assTournoisId;
  int? shortLinkId;
  String? createdAt;
  String? updatedAt;
  String? farotiBalanceRemoved;
  String? balanceRemoved;
  String? farotiBalanceRemaining;
  String? balanceRemaining;
  String? removedStatus;
  String? removedFarotyStatus;
  String? farotiBalance;
  int? isFarotiFoundRemoved;
  int? isFoundRemoved;
  String? totalCotise;
  Compte? compte;
  AssRubrique? assRubrique;
  ShortLink? shortLink;

  Collections(
      {this.id,
      this.code,
      this.userCreate,
      this.motif,
      this.description,
      this.startDate,
      this.colImage,
      this.collectPayLink,
      this.endDate,
      this.isActive,
      this.isPassed,
      this.type,
      this.amount,
      this.collectStatus,
      this.collectBalance,
      this.assCompteId,
      this.assRubriqueCotisationId,
      this.assTournoisId,
      this.shortLinkId,
      this.createdAt,
      this.updatedAt,
      this.farotiBalanceRemoved,
      this.balanceRemoved,
      this.farotiBalanceRemaining,
      this.balanceRemaining,
      this.removedStatus,
      this.removedFarotyStatus,
      this.farotiBalance,
      this.isFarotiFoundRemoved,
      this.isFoundRemoved,
      this.totalCotise,
      this.compte,
      this.assRubrique,
      this.shortLink});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userCreate = json['user_create'];
    motif = json['motif'];
    description = json['description'];
    startDate = json['start_date'];
    colImage = json['col_image'];
    collectPayLink = json['collect_pay_link'];
    endDate = json['end_date'];
    isActive = json['is_active'];
    isPassed = json['is_passed'];
    type = json['type'];
    amount = json['amount'];
    collectStatus = json['collect_status'];
    collectBalance = json['collect_balance'];
    assCompteId = json['ass_compte_id'];
    assRubriqueCotisationId = json['ass_rubrique_cotisation_id'];
    assTournoisId = json['ass_tournois_id'];
    shortLinkId = json['short_link_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    farotiBalanceRemoved = json['faroti_balance_removed'];
    balanceRemoved = json['balance_removed'];
    farotiBalanceRemaining = json['faroti_balance_remaining'];
    balanceRemaining = json['balance_remaining'];
    removedStatus = json['removed_status'];
    removedFarotyStatus = json['removed_faroty_status'];
    farotiBalance = json['faroti_balance'];
    isFarotiFoundRemoved = json['is_faroti_found_removed'];
    isFoundRemoved = json['is_found_removed'];
    totalCotise = json['total_cotise'];
    compte =
        json['compte'] != null ? new Compte.fromJson(json['compte']) : null;
    assRubrique = json['ass_rubrique'] != null
        ? new AssRubrique.fromJson(json['ass_rubrique'])
        : null;
    shortLink = json['shortLink'] != null
        ? new ShortLink.fromJson(json['shortLink'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['user_create'] = this.userCreate;
    data['motif'] = this.motif;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['col_image'] = this.colImage;
    data['collect_pay_link'] = this.collectPayLink;
    data['end_date'] = this.endDate;
    data['is_active'] = this.isActive;
    data['is_passed'] = this.isPassed;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['collect_status'] = this.collectStatus;
    data['collect_balance'] = this.collectBalance;
    data['ass_compte_id'] = this.assCompteId;
    data['ass_rubrique_cotisation_id'] = this.assRubriqueCotisationId;
    data['ass_tournois_id'] = this.assTournoisId;
    data['short_link_id'] = this.shortLinkId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['faroti_balance_removed'] = this.farotiBalanceRemoved;
    data['balance_removed'] = this.balanceRemoved;
    data['faroti_balance_remaining'] = this.farotiBalanceRemaining;
    data['balance_remaining'] = this.balanceRemaining;
    data['removed_status'] = this.removedStatus;
    data['removed_faroty_status'] = this.removedFarotyStatus;
    data['faroti_balance'] = this.farotiBalance;
    data['is_faroti_found_removed'] = this.isFarotiFoundRemoved;
    data['is_found_removed'] = this.isFoundRemoved;
    data['total_cotise'] = this.totalCotise;
    if (this.compte != null) {
      data['compte'] = this.compte!.toJson();
    }
    if (this.assRubrique != null) {
      data['ass_rubrique'] = this.assRubrique!.toJson();
    }
    if (this.shortLink != null) {
      data['shortLink'] = this.shortLink!.toJson();
    }
    return data;
  }
}

class Compte {
  int? id;
  int? userGroupId;
  String? typeId;
  String? publicRef;
  String? matricule;
  String? hiddenRef;
  String? name;
  String? balance;
  String? currency;
  String? farotiBalance;
  String? isDefault;
  String? status;
  String? createdAt;
  String? updatedAt;

  Compte(
      {this.id,
      this.userGroupId,
      this.typeId,
      this.publicRef,
      this.matricule,
      this.hiddenRef,
      this.name,
      this.balance,
      this.currency,
      this.farotiBalance,
      this.isDefault,
      this.status,
      this.createdAt,
      this.updatedAt});

  Compte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userGroupId = json['user_group_id'];
    typeId = json['type_id'];
    publicRef = json['public_ref'];
    matricule = json['matricule'];
    hiddenRef = json['hidden_ref'];
    name = json['name'];
    balance = json['balance'];
    currency = json['currency'];
    farotiBalance = json['faroti_balance'];
    isDefault = json['is_default'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_group_id'] = this.userGroupId;
    data['type_id'] = this.typeId;
    data['public_ref'] = this.publicRef;
    data['matricule'] = this.matricule;
    data['hidden_ref'] = this.hiddenRef;
    data['name'] = this.name;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    data['faroti_balance'] = this.farotiBalance;
    data['is_default'] = this.isDefault;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AssRubrique {
  int? id;
  String? name;
  String? code;
  String? createdAt;
  String? updatedAt;

  AssRubrique({this.id, this.name, this.code, this.createdAt, this.updatedAt});

  AssRubrique.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ShortLink {
  int? id;
  String? code;
  String? data;
  String? type;
  String? sourcename;
  int? visits;

  ShortLink(
      {this.id, this.code, this.data, this.type, this.sourcename, this.visits});

  ShortLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    data = json['data'];
    type = json['type'];
    sourcename = json['sourcename'];
    visits = json['visits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['data'] = this.data;
    data['type'] = this.type;
    data['sourcename'] = this.sourcename;
    data['visits'] = this.visits;
    return data;
  }
}

class Data {
  List<Collections>? collections;
  int? total;
  int? currentPage;
  bool? hasMorePages;
  int? firstPage;
  int? lastPage;
  bool? isEmpty;

  Data(
      {this.collections,
      this.total,
      this.currentPage,
      this.hasMorePages,
      this.firstPage,
      this.lastPage,
      this.isEmpty});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['collections'] != null) {
      collections = <Collections>[];
      json['collections'].forEach((v) {
        collections!.add(new Collections.fromJson(v));
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
    if (this.collections != null) {
      data['collections'] = this.collections!.map((v) => v.toJson()).toList();
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
