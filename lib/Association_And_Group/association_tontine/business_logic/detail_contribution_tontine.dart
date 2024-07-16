import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/contribution_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_repository.dart';

class DetailContributionCubit extends Cubit<ContributionState> {
  DetailContributionCubit()
      : super(
          ContributionState(
            isLoadingContibutionTontine: false,
            detailContributionTontine: null,
            errorLoadDetailCotis: false,
          ),
        );

  Future<void> detailContributionTontineCubit(codeContribution) async {
    emit(
      state.copyWith(
        detailcontributiontontine: state.detailContributionTontine,
        isloadingcontibutionTontine: true,
        errorLoadDetailCotis: state.errorLoadDetailCotis,
      ),
    );
    try {
      final data =
          await TontineRepository().DetailContributionTontine(codeContribution);
      print("widgetDetailHistoriqueTontineCard $codeContribution");

      emit(
        state.copyWith(
          detailcontributiontontine: data,
          isloadingcontibutionTontine: false,
          errorLoadDetailCotis: false,
        ),
      );

      print("detailContributionTontineCubit Cubit ok");
    } catch (e) {
      emit(
        state.copyWith(
          detailcontributiontontine: {},
          isloadingcontibutionTontine: false,
          errorLoadDetailCotis: true,
        ),
      );
    }
  }

  void updateStateAmountPayTontine(String codeMembre, String montant) {
    print("llllllll");
    final currentState = state.detailContributionTontine;

    if (currentState == null || currentState["membres"] == null) {
      return;
    }

    final List<Map<String, dynamic>> updatedMembers =
        List.from(currentState["membres"]);

    for (int i = 0; i < updatedMembers.length; i++) {
      print("iijj2 ${updatedMembers[i]['code']}");
      print("iijj1 ${codeMembre}");
      if (updatedMembers[i]['code'] == codeMembre) {
        double oldBalance = double.parse(updatedMembers[i]['balance']);
        double newAmount = double.parse(montant);

        double newBalance = oldBalance + newAmount;

        updatedMembers[i]['balance'] = newBalance.toString();
        print(updatedMembers[i]['balance']);
      }
    }

    final updatedState = state.copyWith(
      detailcontributiontontine: {
        ...currentState,
        "membres": updatedMembers,
      },
      isloadingcontibutionTontine: false,
      errorLoadDetailCotis: false,
    );

    emit(updatedState);
  }
}
