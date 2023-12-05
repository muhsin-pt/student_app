// To parse this JSON data, do
//
//     final courseDropdownModel = courseDropdownModelFromJson(jsonString);

import 'dart:convert';

CourseDropdownModel courseDropdownModelFromJson(String str) => CourseDropdownModel.fromJson(json.decode(str));

String courseDropdownModelToJson(CourseDropdownModel data) => json.encode(data.toJson());

class CourseDropdownModel {
    String status;
    String message;
    List<MasterDetail> masterDetails;

    CourseDropdownModel({
        required this.status,
        required this.message,
        required this.masterDetails,
    });

    factory CourseDropdownModel.fromJson(Map<String, dynamic> json) => CourseDropdownModel(
        status: json["status"],
        message: json["message"],
        masterDetails: List<MasterDetail>.from(json["master_details"].map((x) => MasterDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "master_details": List<dynamic>.from(masterDetails.map((x) => x.toJson())),
    };
}

class MasterDetail {
    String couId;
    String couName;

    MasterDetail({
        required this.couId,
        required this.couName,
    });

    factory MasterDetail.fromJson(Map<String, dynamic> json) => MasterDetail(
        couId: json["cou_id"],
        couName: json["cou_name"],
    );

    Map<String, dynamic> toJson() => {
        "cou_id": couId,
        "cou_name": couName,
    };
}
