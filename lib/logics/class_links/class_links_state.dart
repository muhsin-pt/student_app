part of 'class_links_bloc.dart';

class ClassLinksState extends Equatable {
  const ClassLinksState();

  @override
  List<Object> get props => [];
}

class ClassLinksInitial extends ClassLinksState {}

class ClassLinksLoading extends ClassLinksState {}

class ClassLinksCompleted extends ClassLinksState {
  final ClassLinksModel classLinksModel;

  const ClassLinksCompleted({required this.classLinksModel});
}

class ClassLinksError extends ClassLinksState {}

class ClassLinksTimeout extends ClassLinksState {}

class ClassLinksDown extends ClassLinksState {}

class ClassLinksNoInternet extends ClassLinksState {}
