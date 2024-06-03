// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class SanctionState extends Equatable {
  final List<dynamic>? sanctions;
  final bool isLoading;


  SanctionState({
    this.sanctions,
    this.isLoading= false,
  });

  @override
  List<Object?> get props => [
        sanctions,
        isLoading,
      ];

  SanctionState copyWith({
    List<dynamic>? sanctions,
    bool? isLoading,
  }) {
    return SanctionState(
      sanctions: sanctions ?? this.sanctions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
