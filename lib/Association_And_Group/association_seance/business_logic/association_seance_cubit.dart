import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SeanceCubit extends Cubit<SeanceState> {
  SeanceCubit()
      : super(
          SeanceState(
            detailSeance: null,
            allSeanceAss: null,
            isLoading: false,
            errorLoadDetailSeance: false,
          ),
        );

  Future<void> AllAssSeanceCubit(codeAss) async {
    emit(state.copyWith(
      isLoading: true,
      detailSeance: state.detailSeance,
      allSeanceAss: state.allSeanceAss,
    ));
    try {
      final data = await SeanceRepository().AllSeanceAss(codeAss);

      emit(
        state.copyWith(
          allSeanceAss: data,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailSeance: state.detailSeance,
          errorLoadDetailSeance: true,
          isLoading: false,
        ),
      );
      // return true;
    }
  }

  Future<void> detailSeanceCubit(codeSeance) async {
    emit(
      state.copyWith(
        isLoading: true,
        detailSeance: state.detailSeance,
        errorLoadDetailSeance: state.errorLoadDetailSeance,
      ),
    );
    try {
      final data = await SeanceRepository().DetailSeance(codeSeance);

      emit(
        state.copyWith(
          detailSeance: data,
          allSeanceAss: state.allSeanceAss,
          isLoading: false,
          errorLoadDetailSeance: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          detailSeance: {},
          allSeanceAss: state.allSeanceAss,
          isLoading: false,
          errorLoadDetailSeance: true,
        ),
      );
    }
  }
}
