import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<FetchEditprofile>((event, emit) async {
    try{
      emit(EditProfileLoading());
      final response = await HttpRequest.responseHttp(apiUrl: Endpoint.editProfile,params: event.params);
      if(response.statusCode == 200){
        emit(EditProfileSuccess());
      }
       if(response.statusCode == 401){
        emit(EditProfileTimeout());
      }
      if(response.statusCode == 500){
        emit(EditProfileError());
      }

    }on SocketException{
      emit(NoInternet());
    }

    });
  }
}
