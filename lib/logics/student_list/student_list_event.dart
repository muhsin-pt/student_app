part of 'student_list_bloc.dart';

abstract class StudentListEvent extends Equatable {
  const StudentListEvent();
}

class FetchStudentList extends StudentListEvent {
  @override
  List<Object> get props => [];
}
