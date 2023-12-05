import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/profile_model.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      try{
        emit(ProfileLoading());
        final response = await HttpRequest.responseHttp(apiUrl: Endpoint.profileUrl,params: {'stu_id':event.studentId});
        if(response.statusCode == 200){
          var jsonData = jsonDecode(response.body);
           emit(ProfileSuccess(profileModel: ProfileModel.fromJson(jsonData)));

        }
        if(response.statusCode == 401){
          emit(ProfileTimeout());
        }
         if(response.statusCode == 500){
          emit(ProfileError());
         }
      }on SocketException{
        emit(Nointernet());
      }
    });
  }
}
