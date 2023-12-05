part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
}
class FetchEditprofile extends EditProfileEvent{
final Map<String,String>params;
  const FetchEditprofile({required this.params});
   @override
  List<Object?> get props => [params];

}