import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/course_dropdwn_model.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'course_dropdwn_event.dart';
part 'course_dropdwn_state.dart';

class CourseDropdwnBloc extends Bloc<CourseDropdwnEvent, CourseDropdwnState> {
  CourseDropdwnBloc() : super(CourseDropdwnInitial()) {
    on<FetchCourseDropdown>((event, emit) async {
      try{
        emit(CourseDropdwnLoading());
        final response = await HttpRequest.responseHttp(apiUrl: Endpoint.courseDrpUrl);
        if(response.statusCode == 200 ){
          var jsonData =jsonDecode(response.body);
          emit(CourseDropdwnSuccess(courseDropdownModel: CourseDropdownModel.fromJson(jsonData)));
        }
        if(response.statusCode == 401){
          emit(CourseDropdwnTimeout());
        }
        if(response.statusCode == 500){
          emit(CourseDropdwnError());
        }
      }on SocketException{
        emit(NoAvailableInternet());
      }
      
    });
  }
}
