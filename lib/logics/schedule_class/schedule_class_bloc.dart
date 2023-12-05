import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/schedule_class_mode.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'schedule_class_event.dart';
part 'schedule_class_state.dart';

class ScheduleClassBloc extends Bloc<ScheduleClassEvent, ScheduleClassState> {
  ScheduleClassBloc() : super(ScheduleClassInitial()) {
    on<FetchScheduled>((event, emit) async {
      try{
        emit(ScheduleClassLoading());
        final  response = await HttpRequest.responseHttp(apiUrl: Endpoint.scheduleClassUrl,params: {"stu_id":event.studentId,"cls_schdl_date":event.filterDate});
       if(response.statusCode==200){
        var jsonData = jsonDecode(response.body);
        emit(ScheduleClassSuccess(scheduledClassModel: ScheduledClassModel.fromJson(jsonData)));
       }
       if(response.statusCode == 401){
        emit(ScheduleClassTimeout());

       }
       if(response.statusCode == 500){
        emit(ScheduleClassError());
       }
       
      }on SocketException{
        emit(Nointernet());
      }
    });
  }
}
