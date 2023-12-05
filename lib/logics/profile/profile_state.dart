part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}
 class ProfileInitial extends ProfileState {
   @override
  List<Object> get props => [];
 }
 class ProfileLoading extends ProfileState {
   @override
  List<Object> get props => [];
 }
 class ProfileSuccess extends ProfileState {

  final ProfileModel profileModel;
  const ProfileSuccess({required this.profileModel});

   @override
  List<Object?> get props => [];
 }
 class ProfileTimeout extends ProfileState {
   @override
  List<Object> get props => [];
 }
 class ProfileError extends ProfileState {
   @override
  List<Object> get props => [];
 }
 class Nointernet extends ProfileState {
   @override
  List<Object> get props => [];
 }

