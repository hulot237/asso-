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
            errorLoadDetailCotis: false,
          ),
        );

  Future<void> detailCotisationCubit(codeCotisation) async {
      print("object detailCotisationCubit  ");

    emit(
      state.copyWith(
        isLoading: true,
        detailCotisation: state.detailCotisation,
        errorLoadDetailCotis: state.errorLoadDetailCotis,
      ),
    );

      print("object detailCotisationCubitdetailCotisationCubit  ");

    try {
      final data = await CotisationRepository().DetailCotisation(codeCotisation);
      print("detailCotisationCubitdetailCotisationCubitdetailCotisationCubit $codeCotisation");

      emit(
        state.copyWith(
          detailCotisation: data,
          isLoading: false,
          errorLoadDetailCotis: false,
        ),
      );
      // print("object DetailCotisation ${state.detailCotisation} ");
    } catch (e) {
      print("object erreurerreurerreurerreurerreurerreur  ");

      // print("object erreur ${e}");
      emit(
        state.copyWith(
          errorLoadDetailCotis: true,
          isLoading: false,
        ),
      );
    }
  }
}
