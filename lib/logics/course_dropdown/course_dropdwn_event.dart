part of 'course_dropdwn_bloc.dart';

abstract class CourseDropdwnEvent extends Equatable {
  const CourseDropdwnEvent();

  @override
  List<Object> get props => [];
}
class FetchCourseDropdown extends CourseDropdwnEvent{}
class SeachCourse extends CourseDropdwnEvent{
  final String query;
   const SeachCourse ({required this.query});
}