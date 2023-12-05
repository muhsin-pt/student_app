part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}
class FetchNotes extends NotesEvent{
    final String recordId;

  const FetchNotes({required this.recordId});
  @override
  List<Object> get props => [recordId];
}