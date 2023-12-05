// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/dashboard.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<FetchDashboard>((event, emit) async {
      try{
        emit(DashboardLoading());
        final response = await HttpRequest.responseHttp(
          apiUrl: Endpoint.dashboardUrl,params:{"stu_id":event.studentId} 
        );
        if(response.statusCode == 200){
          var jsonData = json.decode(response.body);
          emit(DashboardSuccess(dashboardModel: DashboardModel.fromJson(jsonData)));
        }
        if(response.statusCode == 401 ){
          emit(DashboardTimeout());
        }
        if(response.statusCode == 500 ){
         emit(DashboardError());
        }
      }on SocketException{
        emit(NoAvailableInternet());
      }
  
    });
  }
}
