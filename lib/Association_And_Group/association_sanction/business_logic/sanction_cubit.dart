import 'package:faroty_association_1/Association_And_Group/association_prets_epargne/data/prets_epargne_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/business_logic/sanction_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_sanction/data/association_saction_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SanctionCubit extends Cubit<SanctionState> {
  SanctionCubit()
      : super(
          SanctionState(
            sanctions: null,
            isLoading: false,
          ),
        );

  Future<void> getAllSanctions(codeTournoi) async {

    emit(state.copyWith(isLoading: true, sanctions: state.sanctions));
    try {
      final data = await SanctionRepository().getAllSanctions(codeTournoi);

      emit(
        state.copyWith(
          sanctions: data,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          // messageError: e.toString(),
        ),
      );

    }
  }
}
