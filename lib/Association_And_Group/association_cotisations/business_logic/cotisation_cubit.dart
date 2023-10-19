import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CotisationCubit extends Cubit<CotisationState> {
  CotisationCubit()
      : super(
          CotisationState(detailCotisation: null, allCotisationAss: null),
        );

  Future<bool> detailCotisationCubit(codeCotisation) async {
    try {
      final data =
          await CotisationRepository().DetailCotisation(codeCotisation);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailcotisation: data,
            allcotisationAss: state.allCotisationAss,
          ),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailcotisation: {},
            allcotisationAss: state.allCotisationAss,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailcotisation: {},
          allcotisationAss: state.allCotisationAss,
        ),
      );
      return true;
    }
  }

  Future<bool> AllCotisationAssCubit(codeAssociation) async {
    try {
      final data =
          await CotisationRepository().AllCotisationOfAss(codeAssociation);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
              allcotisationAss: data, 
              detailcotisation: state.detailCotisation),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
              allcotisationAss: [], 
              detailcotisation: state.detailCotisation),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
            allcotisationAss: [], 
            detailcotisation: state.detailCotisation),
      );
      return true;
    }
  }
}
