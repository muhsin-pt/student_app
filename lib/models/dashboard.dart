// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    String status;
    String message;
    dynamic presentPercentage;
    dynamic absentPercentage;
    dynamic leavePercentage;
    List<UpcommingClass> upcommingClass;

    DashboardModel({
        required this.status,
        required this.message,
        required this.presentPercentage,
        required this.absentPercentage,
        required this.leavePercentage,
        required this.upcommingClass,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        status: json["status"],
        message: json["message"],
        presentPercentage: json["present_percentage"],
        absentPercentage: json["absent_percentage"],
        leavePercentage: json["leave_percentage"],
        upcommingClass: List<UpcommingClass>.from(
            json["upcomming_class"].map((x) => UpcommingClass.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "present_percentage": presentPercentage,
        "absent_percentage": absentPercentage,
        "leave_percentage": leavePercentage,
        "upcomming_class":
            List<dynamic>.from(upcommingClass.map((x) => x.toJson())),
    };
}

class UpcommingClass {
    String clsSchdlMeetingName;
    String couBtClassName;
    String time;
    String clsSchdlDate;
    String clsSchdlStatus;
    String memTrnLogMname;

    UpcommingClass({
        required this.clsSchdlMeetingName,
        required this.couBtClassName,
        required this.time,
        required this.clsSchdlDate,
        required this.clsSchdlStatus,
        required this.memTrnLogMname,
    });

    factory UpcommingClass.fromJson(Map<String, dynamic> json) => UpcommingClass(
        clsSchdlMeetingName: json["cls_schdl_meeting_name"],
        couBtClassName: json["cou_bt_class_name"],
        time: json["time"],
        clsSchdlDate: json["cls_schdl_date"],
        clsSchdlStatus: json["cls_schdl_status"],
        memTrnLogMname: json["mem_trn_log_mname"],
    );

    Map<String, dynamic> toJson() => {
        "cls_schdl_meeting_name": clsSchdlMeetingName,
        "cou_bt_class_name": couBtClassName,
        "time": time,
        "cls_schdl_date": clsSchdlDate,
        "cls_schdl_status": clsSchdlStatus,
        "mem_trn_log_mname": memTrnLogMname,
    };
}
