// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/authentication/data/user_model.dart';
import 'package:faroty_association_1/network/localisation_phone/data/localisation_phone_model.dart';

class LocalisationPhoneState extends Equatable {
  final LocalisationPhoneModel? localisationPhone;
  final bool isLoading;
  

  LocalisationPhoneState({
    this.localisationPhone,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        localisationPhone,
        isLoading,
      ];

  LocalisationPhoneState copyWith({
    LocalisationPhoneModel? localisationPhone,
    bool? isLoading,
  }) {
    return LocalisationPhoneState(
      localisationPhone: localisationPhone ?? this.localisationPhone,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}
