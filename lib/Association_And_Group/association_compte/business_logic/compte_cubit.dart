import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CompteCubit extends Cubit<CompteState> {
  CompteCubit()
      : super(
          CompteState(
            allCompteAss: null,
            isLoading: false,
            transactionCompte: null,
            isLoadingTransaction: false
          ),
        );

  Future<bool> AllCompteAssCubit(codeAssociation) async {
    emit(state.copyWith(isLoading: true, allCompteAss: state.allCompteAss));

    try {
      final data = await CompteRepository().AllCompteAss(codeAssociation);

      if (data != null) {
        emit(state.copyWith(
          isLoading: false,
          allCompteAss: data,
        ));

        return true;
      } else {
        emit(state.copyWith(
          isLoading: false,
          allCompteAss: [],
        ));
        return false;
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        allCompteAss: [],
      ));
      return true;
    }
  }

  Future<void> getTransactionCompte(codeCompte) async {
    emit(
      state.copyWith(
        isLoading: false,
        isLoadingTransaction: true,
        allCompteAss: state.allCompteAss,
      ),
    );

    try {
      final data = await CompteRepository().getTransactionCompte(codeCompte);
      print("datadatadatadatadatadatadata $data");

      emit(
        state.copyWith(
          transactionCompte: data,
          isLoadingTransaction: false,
        ),
      );
      print("wwwwwwwwwwwwww${state.transactionCompte}");

    } catch (e) {
      emit(
        state.copyWith(
          isLoadingTransaction: false,
        ),
      );
    }
  }
}
