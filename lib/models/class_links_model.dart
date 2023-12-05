// To parse this JSON data, do
//
//     final classLinksModel = classLinksModelFromJson(jsonString);

import 'dart:convert';

ClassLinksModel classLinksModelFromJson(String str) => ClassLinksModel.fromJson(json.decode(str));

String classLinksModelToJson(ClassLinksModel data) => json.encode(data.toJson());

class ClassLinksModel {
    String status;
    String message;
    List<Class> todayClass;
    List<Class> upcommingClass;

    ClassLinksModel({
        required this.status,
        required this.message,
        required this.todayClass,
        required this.upcommingClass,
    });

    ClassLinksModel copyWith({
        String? status,
        String? message,
        List<Class>? todayClass,
        List<Class>? upcommingClass,
    }) => 
        ClassLinksModel(
            status: status ?? this.status,
            message: message ?? this.message,
            todayClass: todayClass ?? this.todayClass,
            upcommingClass: upcommingClass ?? this.upcommingClass,
        );

    factory ClassLinksModel.fromJson(Map<String, dynamic> json) => ClassLinksModel(
        status: json["status"],
        message: json["message"],
        todayClass: List<Class>.from(json["today_class"].map((x) => Class.fromJson(x))),
        upcommingClass: List<Class>.from(json["upcomming_class"].map((x) => Class.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "today_class": List<dynamic>.from(todayClass.map((x) => x.toJson())),
        "upcomming_class": List<dynamic>.from(upcommingClass.map((x) => x.toJson())),
    };
}

class Class {
    String clsSchdlId;
    String clsSchdlMeetingName;
    String couBtClassName;
    DateTime clsSchdlDate;
    String clsSchdlTimeFrom;
    String clsSchdlTimeTo;
    String clsSchdlMeetingLink;
    String clsSchdlStatus;
    String memTrnLogMname;
    String? zoomlink;

    Class({
        required this.clsSchdlId,
        required this.clsSchdlMeetingName,
        required this.couBtClassName,
        required this.clsSchdlDate,
        required this.clsSchdlTimeFrom,
        required this.clsSchdlTimeTo,
        required this.clsSchdlMeetingLink,
        required this.clsSchdlStatus,
        required this.memTrnLogMname,
        this.zoomlink,
    });

    Class copyWith({
        String? clsSchdlId,
        String? clsSchdlMeetingName,
        String? couBtClassName,
        DateTime? clsSchdlDate,
        String? clsSchdlTimeFrom,
        String? clsSchdlTimeTo,
        String? clsSchdlMeetingLink,
        String? clsSchdlStatus,
        String? memTrnLogMname,
        String? zoomlink,
    }) => 
        Class(
            clsSchdlId: clsSchdlId ?? this.clsSchdlId,
            clsSchdlMeetingName: clsSchdlMeetingName ?? this.clsSchdlMeetingName,
            couBtClassName: couBtClassName ?? this.couBtClassName,
            clsSchdlDate: clsSchdlDate ?? this.clsSchdlDate,
            clsSchdlTimeFrom: clsSchdlTimeFrom ?? this.clsSchdlTimeFrom,
            clsSchdlTimeTo: clsSchdlTimeTo ?? this.clsSchdlTimeTo,
            clsSchdlMeetingLink: clsSchdlMeetingLink ?? this.clsSchdlMeetingLink,
            clsSchdlStatus: clsSchdlStatus ?? this.clsSchdlStatus,
            memTrnLogMname: memTrnLogMname ?? this.memTrnLogMname,
            zoomlink: zoomlink ?? this.zoomlink,
        );

    factory Class.fromJson(Map<String, dynamic> json) => Class(
        clsSchdlId: json["cls_schdl_id"],
        clsSchdlMeetingName: json["cls_schdl_meeting_name"],
        couBtClassName: json["cou_bt_class_name"],
        clsSchdlDate: DateTime.parse(json["cls_schdl_date"]),
        clsSchdlTimeFrom: json["cls_schdl_time_from"],
        clsSchdlTimeTo: json["cls_schdl_time_to"],
        clsSchdlMeetingLink: json["cls_schdl_meeting_link"],
        clsSchdlStatus: json["cls_schdl_status"],
        memTrnLogMname: json["mem_trn_log_mname"],
        zoomlink: json["zoomlink"],
    );

    Map<String, dynamic> toJson() => {
        "cls_schdl_id": clsSchdlId,
        "cls_schdl_meeting_name": clsSchdlMeetingName,
        "cou_bt_class_name": couBtClassName,
        "cls_schdl_date": "${clsSchdlDate.year.toString().padLeft(4, '0')}-${clsSchdlDate.month.toString().padLeft(2, '0')}-${clsSchdlDate.day.toString().padLeft(2, '0')}",
        "cls_schdl_time_from": clsSchdlTimeFrom,
        "cls_schdl_time_to": clsSchdlTimeTo,
        "cls_schdl_meeting_link": clsSchdlMeetingLink,
        "cls_schdl_status": clsSchdlStatus,
        "mem_trn_log_mname": memTrnLogMname,
        "zoomlink": zoomlink,
    };
}
