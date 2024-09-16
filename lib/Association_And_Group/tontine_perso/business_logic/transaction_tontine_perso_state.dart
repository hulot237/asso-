// import 'package:equatable/equatable.dart';
// import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/transaction_model.dart';

// abstract class TransactionTontinePersoState extends Equatable {
//   final List<TransactionModel>? transactionReponse; // Updated to a list

//   TransactionTontinePersoState([this.transactionReponse]);

//   @override
//   List<Object?> get props => [transactionReponse];
// }

// class TransactionInitial extends TransactionTontinePersoState {
//   TransactionInitial() : super(null); // Passing null to the superclass constructor
// }

// class TransactionLoading extends TransactionTontinePersoState {
//   TransactionLoading() : super(null); // Passing null to the superclass constructor
// }

// class TransactionLoaded extends TransactionTontinePersoState {
//   TransactionLoaded(List<TransactionModel> transactionReponse)
//       : super(transactionReponse); // Passing the list to the superclass constructor

//   @override
//   List<Object?> get props => [transactionReponse];
// }

// class TransactionError extends TransactionTontinePersoState {
//   final String message;

//   TransactionError(this.message) : super(null); // Passing null to the superclass constructor

//   @override
//   List<Object?> get props => [message, transactionReponse];
// }


import 'package:equatable/equatable.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/transaction_model.dart';

abstract class TransactionTontinePersoState extends Equatable {
  final List<TransactionModel>? transactionReponse; // Updated to a list

  TransactionTontinePersoState([this.transactionReponse]);

  @override
  List<Object?> get props => [transactionReponse];
}

class TransactionInitial extends TransactionTontinePersoState {
  TransactionInitial() : super(null); // Passing null to the superclass constructor
}

class TransactionLoading extends TransactionTontinePersoState {
  TransactionLoading(List<TransactionModel>? transactionReponse) 
      : super(transactionReponse); // Passing the current state data to the superclass constructor
}

class TransactionLoaded extends TransactionTontinePersoState {
  TransactionLoaded(List<TransactionModel> transactionReponse)
      : super(transactionReponse); // Passing the list to the superclass constructor

  @override
  List<Object?> get props => [transactionReponse];
}

class TransactionError extends TransactionTontinePersoState {
  final String message;

  TransactionError(this.message) : super(null); // Passing null to the superclass constructor

  @override
  List<Object?> get props => [message, transactionReponse];
}
