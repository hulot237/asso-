import 'package:faroty_association_1/Association_And_Group/association_compte/business_logic/compte_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_compte/data/association_compte_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class CompteCubit extends Cubit<CompteState> {
  CompteCubit()
      : super(
          CompteState(allCompteAss: null),
        );


  Future<bool> AllCompteAssCubit(codeAssociation) async {
    try {
      final data =
          await CompteRepository().AllCompteAss(codeAssociation);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
              allcompteAss: data, )
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
              allcompteAss: [],)
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
            allcompteAss: [], )
      );
      return true;
    }
  }
}
