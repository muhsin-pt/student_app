part of 'class_links_bloc.dart';

class ClassLinksEvent extends Equatable {
  const ClassLinksEvent();

  @override
  List<Object> get props => [];
}

class FetchClassLinks extends ClassLinksEvent {
  final String studId;

  const FetchClassLinks({required this.studId});
}
