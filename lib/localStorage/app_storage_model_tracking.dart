// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppTrackingStorageModel {

  List<UserAction>? trakingData;


  AppTrackingStorageModel({

    this.trakingData,
  });

  AppTrackingStorageModel copyWith({

    List<UserAction>? trakingData,
  }) {
    return AppTrackingStorageModel(

      trakingData: trakingData ?? this.trakingData,
    );
  }
}



class UserAction {
  final String code;
  final String date;
  final Map<String, dynamic> data;

  UserAction({required this.code, required this.date, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'date': date,
      'data': data,
    };
  }
}