// ignore_for_file: unnecessary_string_interpolations, unnecessary_cast

import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:nawawin_student/models/login_model.dart';
import 'package:nawawin_student/utils/constanst.dart';

class StudentArguments {
  final List<StudentDetail> studentList;

  StudentArguments({
    required this.studentList,
  });
}

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  int? _selectedIndex;
  String studentId = '';

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as StudentArguments;
    return Scaffold(
      // backgroundColor: AppColors.kblue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    ntrkey.currentState?.pop();
                  },
                  icon:
                      const Icon(Icons.arrow_back, color: AppColors.textColor)),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(8),
                child: Divider(),
              ),
              leadingWidth: 30,
              elevation: 0,
              backgroundColor: AppColors.kwhite,
              pinned: true,
              title: appTextView(
                  name: "Student List",
                  color: AppColors.textColor,
                  size: 17,
                  fontWeight: FontWeight.bold)),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 5,
                    backgroundColor: AppColors.kBlack,
                  ),
                  setWidth(10),
                  appTextView(
                      name: '${arguments.studentList[index].pscStuName}',
                      fontWeight: FontWeight.bold,
                      size: 17),
                  const Spacer(),
                  Radio(
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => AppColors.kblue),
                    value: index,
                    groupValue: _selectedIndex,
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedIndex = newValue;
                        studentId = arguments
                            .studentList[int.parse(newValue.toString())].pscId
                            .toString();
                        log("fytytytyt------------------------>${studentId}");
                      });
                    },
                  ),
                  const Divider()
                ],
              ),
            );
          }, childCount: arguments.studentList.length))
        ],
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   backgroundColor: AppColors.textColor,
      //   items: [Icon(Icons.home)],
      // ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.kbottom,
          border: const Border(
            top: BorderSide(color: AppColors.kLightgrey),
          ),
        ),
        padding: const EdgeInsets.only(left: 100),
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () async {
                  await storage.write(key: 'stuId', value: studentId);
                  ntrkey.currentState
                      ?.pushNamedAndRemoveUntil('/home', (route) => false);
                },
                icon: Icon(
                  Icons.home,
                  color: AppColors.kwhite,
                  size: 24,
                )),
            appTextView(
                name: "Go To HomePage",
                color: AppColors.kwhite,
                size: 18,
                fontWeight: FontWeight.bold)
          ],
        ),
      ),
    );
  }
}
