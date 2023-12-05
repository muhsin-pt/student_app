import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nawawin_student/logics/authentication/authentication_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';

//TOKEN EXPIERED
class TokenExpierdWidget extends StatelessWidget {
  const TokenExpierdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          setHeight(h / 10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Lottie.asset(icSession)
          ),
          setHeight(30),
          Center(
              child: appTextView(
            name:
                "Your session has expired due to a security measure. Please log in again to continue using the app.",
            maxLines: 6,
            align: TextAlign.center,
            fontWeight: FontWeight.w600,
          )),
          setHeight(30),
          InkWell(
            onTap: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                  child: appTextView(name: 'Login', size: 19)),
            ),
          )
        ],
      ),
    );
  }
}

///NOINTERNET WIDGET

class NoInternetWidget extends StatelessWidget {
  final String routeName;
  const NoInternetWidget({
    Key? key,
    required this.routeName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          setHeight(h / 5),
          Image.asset(noInternet, height: 250, fit: BoxFit.fitHeight),
          setHeight(20),
          appTextView(name: 'No Active Internet Connection'),
          setHeight(10),
          ElevatedButton(
            onPressed: () async {
              if (checkMultipleClick(DateTime.now())) {
                return;
              }
              if (await hasNetwork()) {
                ntrkey.currentState?.pop();
                ntrkey.currentState?.pushNamed(routeName);
              }
            },
            child: appTextView(
              name: 'Try Again',
              color: AppColors.kwhite,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

///SERVER DOWN
class ServerDownWidget extends StatelessWidget {
  const ServerDownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          setHeight(h / 5),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Lottie.asset(
              icServer,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
              child: appTextView(
                  name:
                      "We're having some technical problems right now that could affect our services. Our team is working to fix it ASAP. Thanks for being patient with us!",
                  align: TextAlign.center,
                  maxLines: 5,
                  fontWeight: FontWeight.w600)),
          setHeight(30),
        ],
      ),
    );
  }
}

/// No Data
class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(icNoData, width: w / 3),
            const SizedBox(height: 15),
            appTextView(name: 'No data....!', fontWeight: FontWeight.w600)
          ],
        ),
      ),
    );
  }
}
////common textfield
TextFormField textfield(
    {required TextInputType type,
      String? Function(String?)? validator,
      String? Function(String?)? onchange,
      String? label,
      List<TextInputFormatter>? formater,
      required TextEditingController controller,
      String? prefix}) =>
    TextFormField(
        textCapitalization: TextCapitalization.words,
        onChanged: onchange,
        inputFormatters: formater,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 13),
        keyboardType: type,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        maxLines: 3,
        minLines: 1,
        decoration: decorationMethod(label: label.toString()));
InputDecoration decorationMethod({required String label}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    labelText: label,
    floatingLabelStyle: const TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300)),
  );
}


//restrict multiple click
DateTime? loginClickTime;

bool checkMultipleClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    return false;
  }
  if (currentTime.difference(loginClickTime!).inMilliseconds < 200) {
    //set this difference time in seconds
    return true;
  }

  loginClickTime = currentTime;
  return false;
}

// NET CHECK CHECK
Future<bool> hasNetwork() async {
  try {
    if (!kIsWeb) {
      final result = await InternetAddress.lookup('www.google.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } else {
      /*log("Connection Status:${web.window.navigator.onLine}"); //Important to add this line

      return web.window.navigator.onLine!;*/

      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
