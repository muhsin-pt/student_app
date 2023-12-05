part of 'course_deails_bloc.dart';

class CourseDeailsEvent extends Equatable {
  const CourseDeailsEvent();

  @override
  List<Object> get props => [];
}

class FetchCourseDetails extends CourseDeailsEvent {
  final String studId;

  const FetchCourseDetails({required this.studId});
}
