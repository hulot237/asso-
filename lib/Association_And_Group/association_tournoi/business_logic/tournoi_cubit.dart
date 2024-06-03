import 'package:faroty_association_1/Association_And_Group/association/business_logic/delivery_state.dart';
import 'package:faroty_association_1/Association_And_Group/association/data/association_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/business_logic/tournoi_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_tournoi/data/tournoi_repository.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/business_logic/userGroup_state.dart';
import 'package:faroty_association_1/Association_And_Group/user_group/data/user_group_repository.dart';
import 'package:faroty_association_1/localStorage/localCubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:integration_part_one/proposition/business_logic/proposition_state.dart';
// import 'package:integration_part_one/proposition/data/proposition_repository.dart';

class DetailTournoiCourantCubit extends Cubit<DetailTournoiCourantState> {
  DetailTournoiCourantCubit()
      : super(
          DetailTournoiCourantState(
            detailtournoiCourant: null,
            detailtournoiCourantHist: null,
            isLoading: false,
          ),
        );

  Future<bool> detailTournoiCourantCubit(codeTournoiDefaul) async {
    print("cdcdcdcdcdcdcdcdcdcdcdcdcdcdc");
    emit(
      state.copyWith(
        isLoading: true,
        changeTournoi: state.changeTournoi,
        detailtournoiCourant: state.detailtournoiCourant,
      ),
    );
    try {
      final data = await DetailTournoiCourantRepository()
          .DetailTournoiCourant(codeTournoiDefaul);

      if (data != null) {
        emit(
          state.copyWith(
            changeTournoi: state.changeTournoi,
            detailtournoiCourant: data,
            isLoading: false,
          ),
        );

        print("changetournoi Cubit ok");
        // changetournoi: state.changeTournoi,
        return true;
      } else {
        emit(
          state.copyWith(
            changeTournoi: state.changeTournoi,
            detailtournoiCourant: {},
            isLoading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          changeTournoi: state.changeTournoi,
          detailtournoiCourant: {},
          isLoading: false,
        ),
      );
      return true;
    }
  }

  Future<bool> detailTournoiCourantCubitHist(codeTournoiDefaul) async {
    print("detailTournoiCourantCubitHistdetailTournoiCourantCubitHistdetailTournoiCourantCubitHist");
    emit(
      state.copyWith(
        isLoading: true,
        changeTournoi: state.changeTournoi,
        detailtournoiCourantHist: state.detailtournoiCourantHist,
        detailtournoiCourant: state.detailtournoiCourant,
      ),
    );
    try {
      final data = await DetailTournoiCourantRepository()
          .DetailTournoiCourant(AppCubitStorage().state.codeTournoisHist);

      if (data != null) {
        emit(
          state.copyWith(
            changeTournoi: state.changeTournoi,
            detailtournoiCourantHist: data,
            detailtournoiCourant: state.detailtournoiCourant,
            isLoading: false,
          ),
        );

        print("changetournoi Cubit ok");
        // changetournoi: state.changeTournoi,
        return true;
      } else {
        emit(
          state.copyWith(
            changeTournoi: state.changeTournoi,
            detailtournoiCourantHist: {},
            detailtournoiCourant: state.detailtournoiCourant,
            isLoading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          changeTournoi: state.changeTournoi,
          detailtournoiCourantHist: {},
          detailtournoiCourant: state.detailtournoiCourant,
          isLoading: false,
        ),
      );
      return true;
    }
  }

  Future<bool> changeTournoiCubit(codeTournoi, codeAss) async {
    emit(
      state.copyWith(
        isLoading: true,
        changeTournoi: state.changeTournoi,
        detailtournoiCourant: state.detailtournoiCourant,
      ),
    );
    try {
      final data = await DetailTournoiCourantRepository()
          .ChangeTournoi(codeTournoi, codeAss);

      if (data != null) {
        // data.forEach((element) => print("AAAAAAAA ${element.user_group_code}"));

        // print("data in cubit ${data.length}");

        emit(
          state.copyWith(
            changeTournoi: data,
            detailtournoiCourant: state.detailtournoiCourant,
            isLoading: false,
          ),
        );

        print("changetournoi Cubit ok");
        return true;
      } else {
        emit(
          state.copyWith(
            detailtournoiCourant: state.detailtournoiCourant,
            changeTournoi: {},
            isLoading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          detailtournoiCourant: state.detailtournoiCourant,
          changeTournoi: {},
          isLoading: false,
        ),
      );
      return true;
    }
  }
}
