import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/login_model.dart';
import 'package:nawawin_student/utils/constanst.dart';

part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  StudentListBloc() : super(StudentListInitial()) {
    on<FetchStudentList>((event, emit) async {
      try {
        emit(StudentListLoading());
        final response =
            await HttpRequest.responseHttp(apiUrl: Endpoint.loginUrl);
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          emit(StudentListSuccess(loginModel: LoginModel.fromJson(jsonData)));
        }
        if (response.statusCode == 401) {
          emit(StudentListTimeout());
        }
        if (response.statusCode == 500) {
          emit(StudentListError());
        }
      } on SocketException {
        emit(NoInternet());
      }
    });
  }
}
