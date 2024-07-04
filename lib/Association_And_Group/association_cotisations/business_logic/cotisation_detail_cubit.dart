import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
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
    emit(
      state.copyWith(
        isLoading: true,
        detailCotisation: state.detailCotisation,
        errorLoadDetailCotis: state.errorLoadDetailCotis,
      ),
    );

    try {
      final data =
          await CotisationRepository().DetailCotisation(codeCotisation);

      emit(
        state.copyWith(
          detailCotisation: data,
          isLoading: false,
          errorLoadDetailCotis: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          errorLoadDetailCotis: true,
          isLoading: false,
        ),
      );
    }
  }

  void updateStateAmountPay(String codeMembre, String montant) {
    final currentState = state.detailCotisation;

    if (currentState == null || currentState["membres"] == null) {
      return;
    }

    final List<Map<String, dynamic>> updatedMembers =
        List.from(currentState["membres"]);

    for (int i = 0; i < updatedMembers.length; i++) {
      print("iijj2 ${updatedMembers[i]['code']}");
      if (updatedMembers[i]['membre']['membre_code'] == codeMembre) {
        double oldBalance = double.parse(updatedMembers[i]['balance']);
        double newAmount = double.parse(montant);

        double newBalance = oldBalance + newAmount;

        updatedMembers[i]['balance'] = newBalance.toString();
        print(updatedMembers[i]['balance']);
      }
    }

    final updatedState = state.copyWith(
      detailCotisation: {
        ...currentState,
        "membres": updatedMembers,
      },
      isLoading: false,
      errorLoadDetailCotis: false,
    );

    emit(updatedState);
  }
}
