import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/models/login_model.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:http/http.dart' as http;
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      try {
        emit(AuthenticationLoading());
        final url = Uri.https(baseUrl, Endpoint.loginUrl, event.params);
        final response = await http.post(url);

        if (response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          final token = jsonResponse['details']['logfnds'];
          final memberid = jsonResponse['details']['member_ID'];
          final name = jsonResponse['details']['name'];

          //shared preference

          log("token--------> $token");
          await storage.write(key: 'name', value: name);
          await storage.write(key: 'member_ID', value: memberid.toString());
          await storage.write(key: 'token', value: token);

          if (token != null && memberid != null) {}
          var data = jsonDecode(response.body);
          emit(AuthenticationSucess(loginModel: LoginModel.fromJson(data)));
        }
        if (response.statusCode == 401) {
          emit(AuthenticationTimeout());
        }
      } on SocketException {
        emit(Nointernet());
      }
    });

    on<LogoutEvent>((event, emit) async {
      await storage.deleteAll();
      ntrkey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
    });
  }
}
