import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/course_details_model.dart';
import 'package:nawawin_student/utils/constanst.dart';

part 'course_deails_event.dart';
part 'course_deails_state.dart';

class CourseDeailsBloc extends Bloc<CourseDeailsEvent, CourseDeailsState> {
  CourseDeailsBloc() : super(CourseDeailsInitial()) {
    on<FetchCourseDetails>((event, emit) async {
      try {
        emit(CourseDeailsLoading());
        final response = await HttpRequest.responseHttp(
            apiUrl: Endpoint.courseDetails, params: {'stu_id': event.studId});

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          emit(
            CourseDeailsSuccess(
              courseDetailsModel: CourseDetailsModel.fromJson(data),
            ),
          );
        }
        if (response.statusCode == 401) {
          emit(CourseDeailsTimeout());
        }
        if (response.statusCode == 500) {
          emit(CourseDeailsError());
        }
      } on SocketException {
        emit(CourseDeailsNoIntenet());
      }
    });
  }
}
