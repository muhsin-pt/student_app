part of 'attance_record_bloc.dart';

class AttanceRecordEvent extends Equatable {
  const AttanceRecordEvent();

  @override
  List<Object> get props => [];
}

class FetchAttanceRecord extends AttanceRecordEvent {
  final String studId;
  final String date;

  const FetchAttanceRecord({required this.studId, required this.date});
}
