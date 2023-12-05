import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nawawin_student/logics/authentication/authentication_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/views/student_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _passwordContoller = TextEditingController();

  // passsword visibility

  bool _isHidden = true;

  //validation
  final _formKey = GlobalKey<FormState>();

  final secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icloginlogo,
                      height: 100,
                    )
                  ],
                ),
                appTextView(name: "Student", fontWeight: FontWeight.w600),
                setHeight(30),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Username',
                    labelText: 'Username',
                    floatingLabelStyle:
                        const TextStyle(color: AppColors.kGreen),
                  ),
                  //validation

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter username';
                    }
                    return null;
                  },
                ),
                setHeight(30),
                TextFormField(
                  controller: _passwordContoller,
                  obscureText: _isHidden,
                  // keyboardType: TextInputType.none,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      hintText: 'Password',
                      labelText: 'Password',
                      floatingLabelStyle:
                          const TextStyle(color: AppColors.kGreen),
                      suffixIcon: GestureDetector(
                        // password visibility------------------------------------------>

                        onTap: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                        child: Icon(_isHidden
                            ? Icons.visibility_off
                            : Icons.visibility),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter password';
                    }
                    return null;
                  },
                ),
                // -------------------------------BlocListerner------------------------------->

                setHeight(20),
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is AuthenticationSucess) {
                      state.loginModel.studentDetails.length == 1
                          ? ntrkey.currentState?.pushNamedAndRemoveUntil(
                              '/home', (route) => false)
                          : ntrkey.currentState?.pushNamedAndRemoveUntil(
                              '/studentlist', (route) => false,
                              arguments: StudentArguments(
                                  studentList:
                                      state.loginModel.studentDetails));
                    }
                    //add login state------------------------------------------------->
                    if (state is AuthenticationError) {
                      //-----------------------------------------------add snackbar -------------------------------------------->

                      errorSnack.currentState?.showSnackBar(
                        alertSnackbar(
                            message:
                                "Check Your Internet Connection, please try again",
                            backgroundColor: AppColors.kred,
                            leading: Icon(
                              Icons.info,
                              color: AppColors.kwhite,
                            )),
                      );
                    }
                    if (state is AuthenticationTimeout) {
                      errorSnack.currentState?.showSnackBar(alertSnackbar(
                          message: 'Invalid password and username',
                          backgroundColor: AppColors.kred,
                          leading: Icon(
                            Icons.info,
                            color: AppColors.kwhite,
                          )));
                    }
                  },
                  //---------------add elevatedbutton--------------------------------------->

                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          //version assign

                          final params = {
                            'username': _nameController.text,
                            'password': _passwordContoller.text,
                          };
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(FetchLogin(params: params));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kGreen,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: appTextView(
                          name: "Login",
                          fontWeight: FontWeight.bold,
                          size: 18,
                          color: AppColors.kwhite)),
                ),
                setHeight(20),
                // richtext

                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          color: AppColors.kgrey,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                      TextSpan(
                          text: 'Powered by ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 182, 181, 185))),
                      TextSpan(
                          text: "Tabsyst",
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
