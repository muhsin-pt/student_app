import 'dart:convert';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<FetchNotes>((event, emit) async {
      try{
        emit(NotesLoading());
        final response = await HttpRequest.responseHttp(apiUrl:Endpoint.notesUrl,params:{'clas_rec_id':event.recordId});
        if(response.statusCode == 200){

        final jsonResponse = json.decode(response.body); 
        final notename = jsonResponse['class_notes']['clas_rec_note_name'];
        final classnote = jsonResponse['class_notes']['clas_rec_class_note'];

      
          emit( NotesSuccess(title: notename, Content: classnote));
        }
        if(response.statusCode == 401){
          emit(NotesTimeout());
        }
         if(response.statusCode == 500){
          emit(NotesError());
        }

      }on SocketException{
        emit(NoInternet());
      }
    
    });
  }
}
