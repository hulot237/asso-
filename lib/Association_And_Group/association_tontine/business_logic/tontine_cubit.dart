import 'package:bloc/bloc.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/business_logic/tontine_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tontine/data/tontine_repository.dart';

class TontineCubit extends Cubit<TontineState> {
  TontineCubit()
      : super(
          TontineState(
            detailTontine: null,
            isLoading: false,
          ),
        );

  Future<bool> detailTontineCubit(codeTournoi, codeTontine) async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await TontineRepository().DetailTontine(codeTournoi, codeTontine);

      if (data != null) {
        emit(
          state.copyWith(
              detailtontine: data,
              isloading: false,),
        );

        print("DetailSeance Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
              detailtontine: [],
              isloading: false,),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
            detailtontine: [],
            isloading: false,),
      );
      return true;
    }
  }

}
