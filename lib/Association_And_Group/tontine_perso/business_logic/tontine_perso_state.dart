import 'package:equatable/equatable.dart';

abstract class TontinePersoState extends Equatable {
  final dynamic dataTontinePerso;

  const TontinePersoState({this.dataTontinePerso});

  @override
  List<Object?> get props => [dataTontinePerso];
}

class TontinePersoInitial extends TontinePersoState {}

class TontinePersoLoading extends TontinePersoState { TontinePersoLoading(dynamic data) : super(dataTontinePerso: data);}

class TontinePersoLoaded extends TontinePersoState {
  const TontinePersoLoaded(dynamic data) : super(dataTontinePerso: data);
}

class TontinePersoError extends TontinePersoState {
  final bool noSubmit;

  const TontinePersoError({this.noSubmit = false, dynamic data})
      : super(dataTontinePerso: data);

  @override
  List<Object?> get props => [noSubmit, dataTontinePerso];
}