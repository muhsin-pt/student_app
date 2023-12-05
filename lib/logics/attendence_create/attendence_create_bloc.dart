import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'attendence_create_event.dart';
part 'attendence_create_state.dart';

class AttendenceCreateBloc extends Bloc<AttendenceCreateEvent, AttendenceCreateState> {
  AttendenceCreateBloc() : super(AttendenceCreateInitial()) {
    on<Fetchattendence>((event, emit) async {
      try{
         emit(AttendenceCreateLoading());
        final response = await HttpRequest.responseHttp(
            apiUrl: Endpoint.attendenceCreateUrl,params: {'attend_cls_schdl_id':event.classId,'attend_type':event.attendtype});

        if (response.statusCode == 200) {
          emit(AttendenceCreateSuccess());
        }
        if (response.statusCode == 401) {
          emit(AttendenceCreateTimeout());
        }
        if (response.statusCode == 500) {
          emit(AttendenceCreateError());
        }


      }on SocketException{
        emit(NoInternet());
      }
     
    });
  }
}
