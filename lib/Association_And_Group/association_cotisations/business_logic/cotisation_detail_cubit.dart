import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CotisationDetailCubit extends Cubit<CotisationDetailState> {
  CotisationDetailCubit()
      : super(
          CotisationDetailState(
            detailCotisation: null,
            isLoading: false,
          ),
        );

  Future<bool> detailCotisationCubit(codeCotisation) async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await CotisationRepository().DetailCotisation(codeCotisation);

      if (data != null) {
        emit(
          state.copyWith(
            detailcotisation: data,
            isloading: false,
          ),
        );


        return true;
      } else {
        emit(
          state.copyWith(
            detailcotisation: {},
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailcotisation: {},
          isloading: false,
        ),
      );
      return true;
    }
  }
}
