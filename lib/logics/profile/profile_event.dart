part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}
class FetchProfile extends ProfileEvent{
  final String studentId;
  const FetchProfile({required this.studentId});
}
