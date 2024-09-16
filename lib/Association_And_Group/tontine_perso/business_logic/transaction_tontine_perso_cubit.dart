import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/business_logic/transaction_tontine_perso_state.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/tontine_perso_repository.dart';
import 'package:faroty_association_1/Association_And_Group/tontine_perso/data/transaction_model.dart'; // Assuming you're using Dio for API requests

class TransactionTontinePersoCubit extends Cubit<TransactionTontinePersoState> {


  TransactionTontinePersoCubit() : super(TransactionInitial());

  Future<void> fetchTransaction(String accountRef) async {
    print("accountRef $accountRef");
    try {
      emit(TransactionLoading(state.transactionReponse));
      final List<TransactionModel> transactions = await TontinePersoRepository().getTransationTontinePerso(accountRef);
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError(e.toString()));
    }
  }
}