// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as https;
import 'package:package_info_plus/package_info_plus.dart';

//================ App Images  =====================
String icSettings = 'assets/images/ic_settings.svg';
String icMetting = 'assets/images/ic_meting.svg';
String icFrame = 'assets/images/ic_group.svg';
String icDashoard = 'assets/images/ic_dashboard.svg';
String icCalender = 'assets/images/ic_calendar.svg';
String icBg = 'assets/images/ic_bg.png';
String icFace = 'assets/images/ic_demo_face.png';
String icClass = 'assets/images/ic_class.svg';
String icClock = 'assets/images/ic_clock.svg';
String icClassCalender = 'assets/images/ic_class_calender.svg';
String icPlayer = 'assets/images/ic_player.svg';
String icBanner = 'assets/images/ic_banner.png';
String iclogo = 'assets/images/ic_logo.png';
String icTimetable = 'assets/images/ic_timetable_calender.svg';
String icCourse = 'assets/images/ic_course.png';
String icClasses = 'assets/images/ic_classes.png';
String icProfile = 'assets/images/ic_profile.png';
String icDashSetting = 'assets/images/ic_settings.png';
String icprofileBg = 'assets/images/ic_profileBg.png';
String icprofileface = 'assets/images/ic_profileface.png';
String noInternet = 'assets/images/nointernet.png';
String icloginlogo = 'assets/images/ic_logo.webp';
//================== Lottie ====================
String icSession = 'assets/lottie/icsession.json';
String icServer = 'assets/lottie/sever.json';
String icNoData = 'assets/lottie/nodata.json';

//================ URLS  =====================
String baseUrl = 'sb-nawawin.tabsyst.com';

class Endpoint {
  static String apipath = 'API_student';
  static String loginUrl = '$apipath/login/login.php';
  static String dashboardUrl = '$apipath/registration/dashboard.php';
  static String classLinks = '$apipath/registration/class_links.php';
  static String attanceUrl = '$apipath/registration/attendance_record.php';
  static String courseDetails = '$apipath/registration/course_details.php';
  static String courseDrpUrl = '$apipath/registration/course_dropdown.php';
  static String scheduleClassUrl =
      '$apipath/registration/dashboard_details.php';
  static String editProfile = '$apipath/registration/edit_student.php';
  static String profileUrl = '$apipath/registration/student_get_details.php';
  static String attendenceCreateUrl =
      '$apipath/registration/attendence_create.php';
  static String notesUrl = '$apipath/registration/record_notes_details.php';
}

//===========================Alert snackbar======================
SnackBar alertSnackbar(
    {required String message,
    required Color backgroundColor,
    required Widget leading}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            leading,
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );
}
// ===================login====================

Future<bool> loginCheck() async {
  final token = await storage.read(key: 'token');
  if (token == 'false') {
    return false;
  } else {
    return true;
  }
}

//=============packages=====================

const storage = FlutterSecureStorage();

//=============== UI Design Color ====================

class AppColors {
  static Color kwhite = const Color(0xffFFFFFF);
  static Color kbodyColor = const Color(0xffF3F3F3);
  static Color kYellow = const Color(0xffFAA807);
  static const textColor = Color(0xff374A48);
  static const kBlack = Color(0xff000000);
  static const kGreen = Color(0xff3B9533);
  static const kViolet = Color(0xff4B4994);
  static const kOrange = Color(0xfffa9a5f);
  static const kDashboardCircle = Color(0xfffe95d3e);
  static const kgrey = Color(0xff979FAE);
  static const kash = Color(0xff999999);
  static const kDivider = Color(0xffCECECE);
  static const kGrey = Color(0xffD0D5DE);
  static const kLightgrey = Color(0xffDDDDDD);
  static Color kred = const Color(0xffFF0000);
  static Color kAbsent = const Color(0x0ff18b6b);
  static Color kblue = const Color(0x0ff1DA8EC);
  static Color kbottom = const Color(0x0ffB6CBF2);
}

//=============== Navigator Key ==================

GlobalKey<NavigatorState> ntrkey = GlobalKey<NavigatorState>();
GlobalKey<ScaffoldMessengerState> errorSnack =
    GlobalKey<ScaffoldMessengerState>(); // Scaffold Message Key

SizedBox setHeight(double val) {
  return SizedBox(
    height: val,
  );
}

SizedBox setWidth(double val) {
  return SizedBox(width: val);
}

///App Text Viwe

Widget appTextView({
  String name = "",
  double size = 14,
  int maxLines = 1,
  bool isUnderLine = false,
  TextAlign align = TextAlign.center,
  Color color = AppColors.textColor,
  FontWeight fontWeight = FontWeight.w400,
}) {
  return Text(
    name,
    textAlign: align,
    style: TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      decoration: isUnderLine ? TextDecoration.underline : TextDecoration.none,
    ),
    overflow: TextOverflow.ellipsis,
    maxLines: maxLines,
  );
}
//===================bloc http response====================

class HttpRequest {
  static Future responseHttp(
      {Map<String, dynamic>? params, required String apiUrl}) async {
    final token = await storage.read(key: "token");
    final memberId = await storage.read(key: "member_ID");
    PackageInfo packageInfo = await (PackageInfo.fromPlatform());
    String version = packageInfo.version;

    final url = Uri.https(baseUrl, apiUrl, params);
    final response = await https.get(url, headers: {
      'token': '$token',
      'memberid': '$memberId',
      'currentappversion': version
    });
    log("${response.statusCode} CODE========${response.body} || ${response.request}");

    return response;
  }
}
