import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_detail_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/business_logic/cotisation_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_cotisations/data/association_cotisations_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/business_logic/association_payements_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_payements/data/association_payements_repository.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/business_logic/association_seance_state.dart';
import 'package:faroty_association_1/Association_And_Group/association_seance/data/association_seance_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class PayementCubit extends Cubit<PayementState> {
  PayementCubit()
      : super(
          PayementState(
            retraitApprove: null,
            isLoading: false,
          ),
        );

  Future<bool> approvePayementCubit(withdrawId, codeMembre) async {
    emit(state.copyWith(isloading: true));
    try {
      final data =
          await PayementRepository().ApprouvePayement(withdrawId, codeMembre);

      if (data != null) {
        emit(
          state.copyWith(
            retraitapprove: data,
            isloading: false,
          ),
        );

        print("DetailSeance Cubit ok");

        return true;
      } else {
        emit(
          state.copyWith(
            retraitapprove: false,
            isloading: false,
          ),
        );
        return false;
      }
    } catch (e) {
      emit(
        state.copyWith(
          retraitapprove: false,
          isloading: false,
        ),
      );
      return true;
    }
  }
}
