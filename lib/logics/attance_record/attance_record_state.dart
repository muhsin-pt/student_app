part of 'attance_record_bloc.dart';

class AttanceRecordState extends Equatable {
  const AttanceRecordState();

  @override
  List<Object> get props => [];
}

class AttanceRecordInitial extends AttanceRecordState {}

class AttanceRecordLoading extends AttanceRecordState {}

class AttanceRecordCompleted extends AttanceRecordState {
  final AttanceRecordModel attanceRecordModel;

  const AttanceRecordCompleted({required this.attanceRecordModel});
}

class AttanceRecordError extends AttanceRecordState {}

class AttanceRecordNoInternet extends AttanceRecordState {}

class AttanceRecordTimeout extends AttanceRecordState {}
