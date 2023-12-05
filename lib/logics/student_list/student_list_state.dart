part of 'student_list_bloc.dart';

abstract class StudentListState extends Equatable {
  const StudentListState();
}

class StudentListInitial extends StudentListState {
  @override
  List<Object> get props => [];
}

class StudentListLoading extends StudentListState {
  @override
  List<Object> get props => [];
}

class StudentListSuccess extends StudentListState {
  final LoginModel loginModel;
  const StudentListSuccess({required this.loginModel});

  @override
  List<Object> get props => [];
}

class StudentListTimeout extends StudentListState {
  @override
  List<Object> get props => [];
}

class StudentListError extends StudentListState {
  @override
  List<Object> get props => [];
}

class NoInternet extends StudentListState {
  @override
  List<Object> get props => [];
}
