// To parse this JSON data, do
//
//     final scheduledClassModel = scheduledClassModelFromJson(jsonString);

import 'dart:convert';

ScheduledClassModel scheduledClassModelFromJson(String str) => ScheduledClassModel.fromJson(json.decode(str));

String scheduledClassModelToJson(ScheduledClassModel data) => json.encode(data.toJson());

class ScheduledClassModel {
    String status;
    String message;
    List<ScheduledClass> scheduledClass;

    ScheduledClassModel({
        required this.status,
        required this.message,
        required this.scheduledClass,
    });

    factory ScheduledClassModel.fromJson(Map<String, dynamic> json) => ScheduledClassModel(
        status: json["status"],
        message: json["message"],
        scheduledClass: List<ScheduledClass>.from(json["scheduled_class"].map((x) => ScheduledClass.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "scheduled_class": List<dynamic>.from(scheduledClass.map((x) => x.toJson())),
    };
}

class ScheduledClass {
    String clsSchdlMeetingName;
    String couBtClassName;
    String time;
    String clsSchdlStatus;
    String memTrnLogMname;

    ScheduledClass({
        required this.clsSchdlMeetingName,
        required this.couBtClassName,
        required this.time,
        required this.clsSchdlStatus,
        required this.memTrnLogMname,
    });

    factory ScheduledClass.fromJson(Map<String, dynamic> json) => ScheduledClass(
        clsSchdlMeetingName: json["cls_schdl_meeting_name"],
        couBtClassName: json["cou_bt_class_name"],
        time: json["time"],
        clsSchdlStatus: json["cls_schdl_status"],
        memTrnLogMname: json["mem_trn_log_mname"],
    );

    Map<String, dynamic> toJson() => {
        "cls_schdl_meeting_name": clsSchdlMeetingName,
        "cou_bt_class_name": couBtClassName,
        "time": time,
        "cls_schdl_status": clsSchdlStatus,
        "mem_trn_log_mname": memTrnLogMname,
    };
}
