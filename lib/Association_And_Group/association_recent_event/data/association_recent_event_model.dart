import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_membres/data/association_membres_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/data/association_saction_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_model.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_model.dart';

class RecentEventModel {
  
  List<CotisationModel>? cotisations;
  List<SanctionModel>? sanctions;
  List<TontineModel>? tontines;

  RecentEventModel({
    this.cotisations,
    this.sanctions,
    this.tontines,
  });

  factory RecentEventModel.fromJson(Map<String, dynamic> json) =>
      RecentEventModel(

        cotisations: json['cotisations'] != null ? (json['cotisations'] as List).map((e) => CotisationModel.fromJson(e)).toList(): null,
        sanctions: json['sanctions'] != null ? (json['sanctions'] as List).map((e) => SanctionModel.fromJson(e)).toList(): null,
        tontines: json['tontines'] != null ? (json['tontines'] as List).map((e) => TontineModel.fromJson(e)).toList(): null,
      );
}
