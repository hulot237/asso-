// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_model.dart';

class CompteState extends Equatable {
  final List<CompteModel>? allCompteAss;
  final List<dynamic>? transactionCompte;
  final bool isLoading;
  final bool isLoadingTransaction;

  CompteState({
    this.allCompteAss,
    this.transactionCompte,
    this.isLoading = false,
    this.isLoadingTransaction = false,
  });

  @override
  List<Object?> get props => [
        allCompteAss,
        isLoading,
        transactionCompte,
        isLoadingTransaction,
        
      ];

  CompteState copyWith({
    List<CompteModel>? allCompteAss,
    List<dynamic>? transactionCompte,
    bool? isLoading,
    bool? isLoadingTransaction,
  }) {
    return CompteState(
      allCompteAss: allCompteAss ?? this.allCompteAss,
      transactionCompte: transactionCompte ?? this.transactionCompte,
      isLoading: isLoading ?? this.isLoading,
      isLoadingTransaction: isLoadingTransaction ?? this.isLoadingTransaction,
    );
  }
}
