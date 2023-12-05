import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/class_links_model.dart';
import 'package:nawawin_student/utils/constanst.dart';

part 'class_links_event.dart';
part 'class_links_state.dart';

class ClassLinksBloc extends Bloc<ClassLinksEvent, ClassLinksState> {
  ClassLinksBloc() : super(ClassLinksInitial()) {
    on<FetchClassLinks>((event, emit) async {
      try {
        emit(ClassLinksLoading());
        final response = await HttpRequest.responseHttp(
            apiUrl: Endpoint.classLinks, params: {'stu_id': event.studId});

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          emit(ClassLinksCompleted(
              classLinksModel: ClassLinksModel.fromJson(data)));
        }
        if (response.statusCode == 401) {
          emit(ClassLinksTimeout());
        }
        if (response.statusCode == 500) {
          emit(ClassLinksError());
        }
      } on SocketException {
        emit(ClassLinksNoInternet());
      }
    });
  }
}
