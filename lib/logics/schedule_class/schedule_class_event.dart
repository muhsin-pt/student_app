part of 'schedule_class_bloc.dart';

sealed class ScheduleClassEvent extends Equatable {
  const ScheduleClassEvent();

  @override
  List<Object> get props => [];
}
class FetchScheduled extends ScheduleClassEvent{
  final String studentId;
  final String filterDate;
  const FetchScheduled({required this.filterDate, required this.studentId});
 
}