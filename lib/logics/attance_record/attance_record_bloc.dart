import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/attance_record_model.dart';

import '../../utils/constanst.dart';

part 'attance_record_event.dart';
part 'attance_record_state.dart';

class AttanceRecordBloc extends Bloc<AttanceRecordEvent, AttanceRecordState> {
  AttanceRecordBloc() : super(AttanceRecordInitial()) {
    on<FetchAttanceRecord>((event, emit) async {
      try {
        emit(AttanceRecordLoading());
        final response = await HttpRequest.responseHttp(
            apiUrl: Endpoint.attanceUrl,
            params: {
              'stu_id': event.studId,
              'date': event.date,
            });

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          emit(
            AttanceRecordCompleted(
              attanceRecordModel: AttanceRecordModel.fromJson(data),
            ),
          );
        }
        if (response.statusCode == 401) {
          emit(AttanceRecordTimeout());
        }
        if (response.statusCode == 500) {
          emit(AttanceRecordError());
        }
      } on SocketException {
        emit(AttanceRecordNoInternet());
      }
    });
  }
}
