// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String status;
  String message;
  Details details;
  List<StudentDetail> studentDetails;

  LoginModel({
    required this.status,
    required this.message,
    required this.details,
    required this.studentDetails,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        details: Details.fromJson(json["details"]),
        studentDetails: List<StudentDetail>.from(
            json["student_details"].map((x) => StudentDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "details": details.toJson(),
        "student_details":
            List<dynamic>.from(studentDetails.map((x) => x.toJson())),
      };
}

class Details {
  String loggedin;
  String memberId;
  dynamic token;
  String name;

  Details({
    required this.loggedin,
    required this.memberId,
    required this.token,
    required this.name,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        loggedin: json["loggedin"],
        memberId: json["member_ID"],
        token: json["token"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "loggedin": loggedin,
        "member_ID": memberId,
        "token": token,
        "name": name,
      };
}

class StudentDetail {
  String pscId;
  String pscStuName;

  StudentDetail({
    required this.pscId,
    required this.pscStuName,
  });

  factory StudentDetail.fromJson(Map<String, dynamic> json) => StudentDetail(
        pscId: json["psc_id"],
        pscStuName: json["psc_stu_name"],
      );

  Map<String, dynamic> toJson() => {
        "psc_id": pscId,
        "psc_stu_name": pscStuName,
      };
}
