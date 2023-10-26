import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SeanceCubit extends Cubit<SeanceState> {
  SeanceCubit()
      : super(
          SeanceState(detailSeance: null, allSeanceAss: null, isLoading: false),
        );

  Future<bool> AllAssSeanceCubit(codeAss) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await SeanceRepository().AllSeanceAss(codeAss);

      if (data != null) {
        emit(
          state.copyWith(
            allseanceass: data,
            detailseance: state.detailSeance,
            isloading: false,
          ),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            allseanceass: [],
            detailseance: state.detailSeance,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          allseanceass: [],
          detailseance: state.detailSeance,
          isloading: false,
        ),
      );
      return true;
    }
  }

  Future<bool> detailSeanceCubit(codeSeance) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await SeanceRepository().DetailSeance(codeSeance);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            detailseance: data,
            allseanceass: state.allSeanceAss,
            isloading: false,
          ),
        );

        print("DetailSeance Cubit ok");

        // emit(state.copyWith(isloading: false));

        return true;
      } else {
        emit(
          state.copyWith(
            detailseance: {},
            allseanceass: state.allSeanceAss,
            isloading: false,
          ),
        );
        // emit(state.copyWith(isloading: false));

        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailseance: {},
          allseanceass: state.allSeanceAss,
          isloading: false,
        ),
      );
      return true;
    }
  }
}
