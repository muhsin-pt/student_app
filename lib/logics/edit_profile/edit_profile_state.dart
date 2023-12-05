part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  const EditProfileState();


}

 class EditProfileInitial extends EditProfileState {
    @override
  List<Object> get props => [];
 }
 class EditProfileLoading extends EditProfileState {
    @override
  List<Object> get props => [];
 }
 class EditProfileSuccess extends EditProfileState {
    @override
  List<Object> get props => [];
 }
 class EditProfileTimeout extends EditProfileState {
    @override
  List<Object> get props => [];
 }
  class EditProfileError extends EditProfileState {
    @override
  List<Object> get props => [];
 }
 class NoInternet extends EditProfileState {
    @override
  List<Object> get props => [];
 }

