import 'package:equatable/equatable.dart';

class TontineState extends Equatable {
  final List<dynamic>? detailTontine;
  final bool isLoading;

  TontineState({
    this.detailTontine,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        detailTontine,
        isLoading,
      ];

  TontineState copyWith({
    List<dynamic>? detailtontine,
    required bool isloading,
  }) {
    return TontineState(
      detailTontine: detailtontine,
      isLoading: isloading,
    );
  }

}
