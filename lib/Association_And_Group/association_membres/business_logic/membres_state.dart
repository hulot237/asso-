import 'package:equatable/equatable.dart';

class MembreState extends Equatable {
  final List<dynamic>? allMembers;
  final bool isLoading;
  

  MembreState({
    this.allMembers,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        allMembers,
        isLoading,
      ];

  MembreState copyWith({
    List<dynamic>? allmembers,
    required bool isloading,
  }) {
    return MembreState(
      allMembers: allmembers,
      isLoading: isloading,
    );
  }

}
