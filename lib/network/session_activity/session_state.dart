// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SessionState extends Equatable {
  final Map<String, dynamic>? detailSession;
  final bool isValidSession;

  SessionState({
    this.detailSession,
    this.isValidSession = false,
  });

  @override
  List<Object?> get props => [
        detailSession,
        isValidSession,
      ];

  SessionState copyWith({
    Map<String, dynamic>? detailSession,
    bool? isValidSession,
  }) {
    return SessionState(
      detailSession: detailSession ?? this.detailSession,
      isValidSession: isValidSession ?? this.isValidSession,
    );
  }

}
