part of 'course_deails_bloc.dart';

class CourseDeailsState extends Equatable {
  const CourseDeailsState();

  @override
  List<Object> get props => [];
}

class CourseDeailsInitial extends CourseDeailsState {}

class CourseDeailsLoading extends CourseDeailsState {}

class CourseDeailsSuccess extends CourseDeailsState {
  final CourseDetailsModel courseDetailsModel;

  const CourseDeailsSuccess({required this.courseDetailsModel});
}

class CourseDeailsError extends CourseDeailsState {}

class CourseDeailsNoIntenet extends CourseDeailsState {}

class CourseDeailsTimeout extends CourseDeailsState {}
