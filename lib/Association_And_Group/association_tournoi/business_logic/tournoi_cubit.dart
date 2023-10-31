import 'package:faroty_association_1/Association_And_Group/association/business_logic/delivery_state.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/association_tournoi_repository.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_one/proposition/business_logic/proposition_state.dart';
// import 'package:integration_part_one/proposition/data/proposition_repository.dart';

class DetailTournoiCourantCubit extends Cubit<DetailTournoiCourantState> {
  DetailTournoiCourantCubit()
      : super(
          DetailTournoiCourantState(
            detailtournoiCourant: null,
            isLoading: false,
          ),
        );

  Future<bool> detailTournoiCourantCubit() async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await DetailTournoiCourantRepository().DetailTournoiCourant();

      if (data != null) {
        emit(
          state.copyWith(
            changetournoi: state.changeTournoi,
            detailtournoicourant: data,
            isloading: false,
          ),
        );

        print("changetournoi Cubit ok");
        // changetournoi: state.changeTournoi,
        return true;
      } else {
        emit(
          state.copyWith(
            changetournoi: state.changeTournoi,
            detailtournoicourant: {},
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          changetournoi: state.changeTournoi,
          detailtournoicourant: {},
          isloading: false,
        ),
      );
      return true;
    }
  }

  Future<bool> changeTournoiCubit(codeTournoi, codeAss) async {
    emit(state.copyWith(isloading: true));
    try {
      final data = await DetailTournoiCourantRepository()
          .ChangeTournoi(codeTournoi, codeAss);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            changetournoi: data,
            detailtournoicourant: state.detailtournoiCourant,
            isloading: false,
          ),
        );

        print("changetournoi Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailtournoicourant: state.detailtournoiCourant,
            changetournoi: {},
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailtournoicourant: state.detailtournoiCourant,
          changetournoi: {},
          isloading: false,
        ),
      );
      return true;
    }
  }


}
