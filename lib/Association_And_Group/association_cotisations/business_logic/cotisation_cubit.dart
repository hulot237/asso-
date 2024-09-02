import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CotisationCubit extends Cubit<CotisationState> {
  CotisationCubit()
      : super(
          CotisationState(
            allCotisationAss: null,
            isLoadingCotis: false,
            isLoadingCollect: false,
            collectes: null,
          ),
        );
  Future<bool> AllCotisationAssTournoiCubit(codeTournoi, codeMembre) async {
    print(
        'objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject');
    emit(state.copyWith(
        isLoadingCotis: true, allCotisationAss: state.allCotisationAss));
    try {
      final data = await CotisationRepository()
          .AllCotisationOfAssTournoi(codeTournoi, codeMembre);

      if (data != null) {
        emit(
          state.copyWith(
            allCotisationAss: data,
            isLoadingCotis: false,
          ),
        );

        return true;
      } else {
        emit(
          state.copyWith(
            allCotisationAss: [],
            isLoadingCotis: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          allCotisationAss: [],
          isLoadingCotis: false,
        ),
      );
      return true;
    }
  }

  Future<void> getCollectes(codeTournoi) async {
    emit(
      state.copyWith(
        isLoadingCollect: true,
        collectes: state.collectes,
      ),
    );

    try {
      final data = await CotisationRepository().getCollectes(codeTournoi);

      emit(
        state.copyWith(
          collectes: data,
          isLoadingCollect: false,
        ),
      );
      print("wwwwwwwwwwwwww${state.collectes}");
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingCollect: false,
        ),
      );
    }
  }
}
