import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/authentication/data/user_model.dart';

class MembreState extends Equatable {
  final List<UserModel>? allMembers;
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
    List<UserModel>? allmembers,
    required bool isloading,
  }) {
    return MembreState(
      allMembers: allmembers,
      isLoading: isloading,
    );
  }

}
