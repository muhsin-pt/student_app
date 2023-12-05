part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationSucess extends AuthenticationState {
  final LoginModel loginModel;
  const AuthenticationSucess({required this.loginModel});

  @override
  List<Object> get props => [];
}

class AuthenticationTimeout extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class Nointernet extends AuthenticationState {
  @override
  List<Object> get props => [];
}
