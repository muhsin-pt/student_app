// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nawawin_student/logics/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/views/calender_page.dart';
import 'package:nawawin_student/views/dashboard.dart';
import 'package:nawawin_student/views/course_page.dart';
import 'package:nawawin_student/views/meeting_page.dart';
import 'package:nawawin_student/views/settings_page.dart';

class BottomNavgation extends StatelessWidget {
  BottomNavgation({super.key});
  final screenList = [
    const Dashbaord(),
    CoursePage(),
    const MeetingPage(),
    const CalenderPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.kbodyColor,
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: screenList.elementAt(state.currentIndex),
          ),
          bottomNavigationBar: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 5),
            child: SizedBox(
              height: 70,
              child: Card(
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BottomNavigationBar(
                    onTap: (index) {
                      if (index == 0) {
                        ntrkey.currentState?.pushNamed('/home');
                      } else {
                        context
                            .read<BottomNavigationCubit>()
                            .changeIndex(index);
                      }
                    },
                    currentIndex: state.currentIndex,
                    selectedFontSize: 10,
                    unselectedFontSize: 10,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: AppColors.kYellow,
                    unselectedItemColor: Colors.grey.shade600,
                    selectedLabelStyle:
                        const TextStyle(color: AppColors.textColor),
                    items: [
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(
                            icDashoard,
                            color: AppColors.textColor,
                          ),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icDashoard,
                              color: AppColors.kYellow),
                        ),
                        label: 'Dashboard',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icFrame),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icFrame,
                              color: AppColors.kYellow),
                        ),
                        label: 'Courses',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icMetting),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icMetting,
                              color: AppColors.kYellow),
                        ),
                        label: 'Meetings',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icCalender),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icCalender,
                              color: AppColors.kYellow),
                        ),
                        label: 'Time Table',
                      ),
                      BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icSettings),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: SvgPicture.asset(icSettings,
                              color: AppColors.kYellow),
                        ),
                        label: 'Settings',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
