// ignore_for_file: must_be_immutable

part of 'course_dropdwn_bloc.dart';

abstract class CourseDropdwnState extends Equatable {
  const CourseDropdwnState();
  
}

 class CourseDropdwnInitial extends CourseDropdwnState {
  @override
  List<Object> get props => [];
  }
 class CourseDropdwnLoading extends CourseDropdwnState {
  @override
  List<Object> get props => [];
  }
 class CourseDropdwnSuccess extends CourseDropdwnState {

  CourseDropdownModel courseDropdownModel;
  CourseDropdwnSuccess({required this.courseDropdownModel});
  @override
  List<Object> get props => [];
  
  }
 class CourseDropdwnError extends CourseDropdwnState {
  @override
  List<Object> get props => [];
  }
 class CourseDropdwnTimeout extends CourseDropdwnState {
  @override
  List<Object> get props => [];
  }
 class NoAvailableInternet extends CourseDropdwnState {
  @override
  List<Object> get props => [];
  }
