import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_model.dart';

class AssociationState extends Equatable {
  final List<AssociationModel>? association;

  AssociationState({this.association});

  @override
  List<Object?> get props => [association];

  AssociationState copyWith(
      {List<AssociationModel>? association}) {
    return AssociationState(
      association: association,
    );
  }

  factory AssociationState.fromJson(Map<String, dynamic> json) {
    return AssociationState(
      association: json['assciation'],
    );
  }

}
