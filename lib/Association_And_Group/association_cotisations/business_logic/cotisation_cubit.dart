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
            isLoading: false,
          ),
        );
  Future<bool> AllCotisationAssTournoiCubit(codeTournoi, codeMembre) async {
    print('objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject');
    emit(state.copyWith(isloading: true, allcotisationAss: state.allCotisationAss));
    try {
      final data =
          await CotisationRepository().AllCotisationOfAssTournoi(codeTournoi, codeMembre);

      if (data != null) {
        emit(
          state.copyWith(
            allcotisationAss: data,
            isloading: false,
          ),
        );

        return true;
      } else {
        emit(
          state.copyWith(
            allcotisationAss: [],
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          allcotisationAss: [],
          isloading: false,
        ),
      );
      return true;
    }
  }
}
