
import 'package:faroty_association_1/localStorage/app_storage_model_tracking.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppTrackingCubitStorage extends HydratedCubit<AppTrackingStorageModel> {
  AppTrackingCubitStorage()
      : super(
          AppTrackingStorageModel(

            trakingData: null,
          ),
        );

  @override
  AppTrackingStorageModel? fromJson(Map<String, dynamic> json) {
    return AppTrackingStorageModel(

      trakingData: json["trakingData"],
    );
  }

  @override
  Map<String, dynamic> toJson(AppTrackingStorageModel state) {
    return {

      "trakingData": state.trakingData,
    };
  }



  Future<void> updateTrakingData(String code, String date, Map<String, dynamic> data) async {
    bool donneesChargees = false;
    UserAction oneAction = UserAction(code: code, date: date, data: data);
    List<UserAction> updatedTrackingData = List.from(state.trakingData ?? []);
    // updatedTrackingData.add(oneAction);
    // print("Contenu de ${updatedTrackingData.length}");
    // // emit(
    // //   state.copyWith(isLoading: true),
    // // );
    // do {
    //   await Future.delayed(
    //     Duration(
    //       seconds: 1,
    //     ),
    //   );
    //   if (updatedTrackingData != null) {
    //     // Add newValue to the trakingData list
    //     // state.trakingData!.add(oneAction);
    //     print("updateTrakingData1 ${oneAction.code}");
    //     print("updateTrakingData2 ${oneAction.data}");
    //     print("updateTrakingData3 ${oneAction.date}");
    //     donneesChargees = true;
    //   }
    // } while (!donneesChargees);
    // emit(
    //   state.copyWith(
    //     trakingData: updatedTrackingData,
    //     // isLoading: false,
    //   ),
    // );
    print("Contenu de trakingData: ${state.trakingData!.length}");
  }


}
