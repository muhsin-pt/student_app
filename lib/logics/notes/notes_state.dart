// ignore_for_file: camel_case_types, non_constant_identifier_names

part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
  

}

 class NotesInitial extends NotesState {
    @override
  List<Object> get props => [];
 }
 class NotesSuccess extends NotesState {

  final String title; final String Content;
   const NotesSuccess({required this.title,required this.Content});

    @override
  List<Object> get props => [title,Content];
 }
 class NotesLoading extends NotesState {
    @override
  List<Object> get props => [];
 }
 class NotesTimeout extends NotesState {
    @override
  List<Object> get props => [];
 }
 class NotesError extends NotesState {
    @override
  List<Object> get props => [];
 }
 class NoInternet extends NotesState {
    @override
  List<Object> get props => [];
 }

