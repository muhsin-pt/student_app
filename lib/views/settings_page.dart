import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/logics/authentication/authentication_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor: AppColors.kwhite,
            leading: IconButton(
                onPressed: () {
                  ntrkey.currentState?.pop();
                },
                icon: const Icon(Icons.arrow_back, color: AppColors.textColor)),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(8),
              child: Divider(),
            ),
            leadingWidth: 30,
            elevation: 0,
            pinned: true,
            title: appTextView(
                name: "Settings",
                color: AppColors.textColor,
                size: 17,
                fontWeight: FontWeight.bold)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () async {
                await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        content: SizedBox(
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Align(
                                  alignment: Alignment.center,
                                  child: Text("Do you want to logout?")),
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          color: Colors.white,
                                          child: const Text(
                                            'No',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            ntrkey.currentState?.pop();
                                          }),
                                    ),
                                    setWidth(5),
                                    Expanded(
                                      child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          color: CupertinoColors.systemRed,
                                          child: const Text('Yes'),
                                          onPressed: () async {
                                            context
                                                .read<AuthenticationBloc>()
                                                .add(LogoutEvent());
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade400)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.red.shade400),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
