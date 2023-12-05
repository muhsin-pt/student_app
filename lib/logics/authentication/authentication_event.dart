part of 'authentication_bloc.dart';

 class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override

  List<Object?> get props => [];
  Map<String, dynamic>?get params => null;
}
class FetchLogin extends AuthenticationEvent{
  @override
   final Map<String,String>params;
   const FetchLogin({required this.params});
}

class LogoutEvent extends AuthenticationEvent{}