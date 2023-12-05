import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nawawin_student/logics/attance_record/attance_record_bloc.dart';
import 'package:nawawin_student/logics/attendence_create/attendence_create_bloc.dart';
import 'package:nawawin_student/logics/authentication/authentication_bloc.dart';
import 'package:nawawin_student/logics/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:nawawin_student/logics/class_links/class_links_bloc.dart';
import 'package:nawawin_student/logics/courseDetails/course_deails_bloc.dart';
import 'package:nawawin_student/logics/dashboard/dashboard_bloc.dart';
import 'package:nawawin_student/logics/notes/notes_bloc.dart';
import 'package:nawawin_student/logics/profile/profile_bloc.dart';
import 'package:nawawin_student/logics/schedule_class/schedule_class_bloc.dart';
import 'package:nawawin_student/logics/student_list/student_list_bloc.dart';
import 'package:nawawin_student/utils/constanst.dart';
import 'package:nawawin_student/views/bottom_navigation.dart';
import 'package:nawawin_student/views/class_schedulepage.dart';
import 'package:nawawin_student/views/course_notes.dart';
import 'package:nawawin_student/views/dashboard.dart';
import 'package:nawawin_student/views/edit_profile.dart';
import 'package:nawawin_student/views/login.dart';
import 'package:nawawin_student/views/profile.dart';
import 'package:nawawin_student/views/student_list.dart';
import 'logics/course_dropdown/course_dropdwn_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final islog = await loginCheck();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthenticationBloc()),
      BlocProvider(create: (context) => DashboardBloc()),
      BlocProvider(create: (context) => ClassLinksBloc()),
      BlocProvider(create: (context) => AttanceRecordBloc()),
      BlocProvider(create: (context) => CourseDeailsBloc()),
      BlocProvider(create: (context) => ProfileBloc()),
      BlocProvider(create: (context) => CourseDeailsBloc()),
      BlocProvider(create: (context) => ScheduleClassBloc()),
      BlocProvider(create: (context) => StudentListBloc()),
      BlocProvider(
        create: (context) => CourseDropdwnBloc(),
      ),
      BlocProvider(
        create: (context) => AttendenceCreateBloc(),
      ),
      BlocProvider(
        create: (context) => NotesBloc(),
      ),
    ],
    child: MyApp(
      islog: islog,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final bool islog;
  const MyApp({super.key, required this.islog});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavigationCubit(),
        )
      ],
      child: MaterialApp(
        navigatorKey: ntrkey,
        scaffoldMessengerKey: errorSnack,
        debugShowCheckedModeBanner: false,
        title: 'Nawawin Student',
        theme: ThemeData(
          fontFamily: 'Proxima-Nova',
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.textColor),
          useMaterial3: true,
        ),
        home: const Dashbaord(),
        routes: {
          '/bottomNavigation': (context) => BottomNavgation(),
          '/home': (context) => const Dashbaord(),
          '/profile': (context) => const Profile(),
          '/classSchedule': (context) => const SchedulePage(),
          'loginpage': (context) => const LoginPage(),
          '/editprofile': (context) => const EditProfile(),
          '/login': (context) => const LoginPage(),
          '/notes': (context) => const CourseNotes(),
          '/studentlist': (context) => const StudentList()
        },
        initialRoute: islog ? '/home' : '/login',
      ),
    );
  }
}
