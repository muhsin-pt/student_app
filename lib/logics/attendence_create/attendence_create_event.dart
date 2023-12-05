part of 'attendence_create_bloc.dart';

abstract class AttendenceCreateEvent extends Equatable {
  const AttendenceCreateEvent();


}
class Fetchattendence extends AttendenceCreateEvent{

  final String classId;final String attendtype;
  const Fetchattendence({required this.attendtype, required this.classId});

  @override
  List<Object> get props => [attendtype,classId];
}