// To parse this JSON data, do
//
//     final attanceRecordModel = attanceRecordModelFromJson(jsonString);

import 'dart:convert';

AttanceRecordModel attanceRecordModelFromJson(String str) =>
    AttanceRecordModel.fromJson(json.decode(str));

String attanceRecordModelToJson(AttanceRecordModel data) =>
    json.encode(data.toJson());

class AttanceRecordModel {
  String status;
  String message;
  List<TodayClass> todayClass;

  AttanceRecordModel({
    required this.status,
    required this.message,
    required this.todayClass,
  });

  AttanceRecordModel copyWith({
    String? status,
    String? message,
    List<TodayClass>? todayClass,
  }) =>
      AttanceRecordModel(
        status: status ?? this.status,
        message: message ?? this.message,
        todayClass: todayClass ?? this.todayClass,
      );

  factory AttanceRecordModel.fromJson(Map<String, dynamic> json) =>
      AttanceRecordModel(
        status: json["status"],
        message: json["message"],
        todayClass: List<TodayClass>.from(
            json["today_class"].map((x) => TodayClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "today_class": List<dynamic>.from(todayClass.map((x) => x.toJson())),
      };
}

class TodayClass {
  String clsSchdlMeetingName;
  String clsSchdlTimeFrom;
  String clsSchdlTimeTo;
  DateTime clsSchdlDate;
  String clsSchdlMeetingLink;
  String clsSchdlStatus;
  String memTrnLogMname;
  String attendStatus;

  TodayClass({
    required this.clsSchdlMeetingName,
    required this.clsSchdlTimeFrom,
    required this.clsSchdlTimeTo,
    required this.clsSchdlDate,
    required this.clsSchdlMeetingLink,
    required this.clsSchdlStatus,
    required this.memTrnLogMname,
    required this.attendStatus,
  });

  TodayClass copyWith({
    String? clsSchdlMeetingName,
    String? clsSchdlTimeFrom,
    String? clsSchdlTimeTo,
    DateTime? clsSchdlDate,
    String? clsSchdlMeetingLink,
    String? clsSchdlStatus,
    String? memTrnLogMname,
    String? attendStatus,
  }) =>
      TodayClass(
        clsSchdlMeetingName: clsSchdlMeetingName ?? this.clsSchdlMeetingName,
        clsSchdlTimeFrom: clsSchdlTimeFrom ?? this.clsSchdlTimeFrom,
        clsSchdlTimeTo: clsSchdlTimeTo ?? this.clsSchdlTimeTo,
        clsSchdlDate: clsSchdlDate ?? this.clsSchdlDate,
        clsSchdlMeetingLink: clsSchdlMeetingLink ?? this.clsSchdlMeetingLink,
        clsSchdlStatus: clsSchdlStatus ?? this.clsSchdlStatus,
        memTrnLogMname: memTrnLogMname ?? this.memTrnLogMname,
        attendStatus: attendStatus ?? this.attendStatus,
      );

  factory TodayClass.fromJson(Map<String, dynamic> json) => TodayClass(
        clsSchdlMeetingName: json["cls_schdl_meeting_name"],
        clsSchdlTimeFrom: json["cls_schdl_time_from"],
        clsSchdlTimeTo: json["cls_schdl_time_to"],
        clsSchdlDate: DateTime.parse(json["cls_schdl_date"]),
        clsSchdlMeetingLink: json["cls_schdl_meeting_link"],
        clsSchdlStatus: json["cls_schdl_status"],
        memTrnLogMname: json["mem_trn_log_mname"],
        attendStatus: json["attend_status"],
      );

  Map<String, dynamic> toJson() => {
        "cls_schdl_meeting_name": clsSchdlMeetingName,
        "cls_schdl_time_from": clsSchdlTimeFrom,
        "cls_schdl_time_to": clsSchdlTimeTo,
        "cls_schdl_date":
            "${clsSchdlDate.year.toString().padLeft(4, '0')}-${clsSchdlDate.month.toString().padLeft(2, '0')}-${clsSchdlDate.day.toString().padLeft(2, '0')}",
        "cls_schdl_meeting_link": clsSchdlMeetingLink,
        "cls_schdl_status": clsSchdlStatus,
        "mem_trn_log_mname": memTrnLogMname,
        "attend_status": attendStatus,
      };
}
