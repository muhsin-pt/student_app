// To parse this JSON data, do
//
//     final courseDetailsModel = courseDetailsModelFromJson(jsonString);

import 'dart:convert';

CourseDetailsModel courseDetailsModelFromJson(String str) => CourseDetailsModel.fromJson(json.decode(str));

String courseDetailsModelToJson(CourseDetailsModel data) => json.encode(data.toJson());

class CourseDetailsModel {
  String status;
  String message;
  List<MasterDetail> masterDetails;
  List<VideoRecord> videoRecords;
  List<NoteRecord> noteRecords;

  CourseDetailsModel({
    required this.status,
    required this.message,
    required this.masterDetails,
    required this.videoRecords,
    required this.noteRecords,
  });

  CourseDetailsModel copyWith({
    String? status,
    String? message,
    List<MasterDetail>? masterDetails,
    List<VideoRecord>? videoRecords,
    List<NoteRecord>? noteRecords,
  }) =>
      CourseDetailsModel(
        status: status ?? this.status,
        message: message ?? this.message,
        masterDetails: masterDetails ?? this.masterDetails,
        videoRecords: videoRecords ?? this.videoRecords,
        noteRecords: noteRecords ?? this.noteRecords,
      );

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) => CourseDetailsModel(
    status: json["status"],
    message: json["message"],
    masterDetails: List<MasterDetail>.from(json["master_details"].map((x) => MasterDetail.fromJson(x))),
    videoRecords: List<VideoRecord>.from(json["video_records"].map((x) => VideoRecord.fromJson(x))),
    noteRecords: List<NoteRecord>.from(json["note_records"].map((x) => NoteRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "master_details": List<dynamic>.from(masterDetails.map((x) => x.toJson())),
    "video_records": List<dynamic>.from(videoRecords.map((x) => x.toJson())),
    "note_records": List<dynamic>.from(noteRecords.map((x) => x.toJson())),
  };
}

class MasterDetail {
  String stuId;
  String pscClassId;
  String pscStuName;
  String pscMobNo;
  String couName;
  String couImage;
  String couDescription;
  String couStatus;

  MasterDetail({
    required this.stuId,
    required this.pscClassId,
    required this.pscStuName,
    required this.pscMobNo,
    required this.couName,
    required this.couImage,
    required this.couDescription,
    required this.couStatus,
  });

  MasterDetail copyWith({
    String? stuId,
    String? pscClassId,
    String? pscStuName,
    String? pscMobNo,
    String? couName,
    String? couImage,
    String? couDescription,
    String? couStatus,
  }) =>
      MasterDetail(
        stuId: stuId ?? this.stuId,
        pscClassId: pscClassId ?? this.pscClassId,
        pscStuName: pscStuName ?? this.pscStuName,
        pscMobNo: pscMobNo ?? this.pscMobNo,
        couName: couName ?? this.couName,
        couImage: couImage ?? this.couImage,
        couDescription: couDescription ?? this.couDescription,
        couStatus: couStatus ?? this.couStatus,
      );

  factory MasterDetail.fromJson(Map<String, dynamic> json) => MasterDetail(
    stuId: json["stu_id"],
    pscClassId: json["psc_class_id"],
    pscStuName: json["psc_stu_name"],
    pscMobNo: json["psc_mob_no"],
    couName: json["cou_name"],
    couImage: json["cou_image"],
    couDescription: json["cou_description"],
    couStatus: json["cou_status"],
  );

  Map<String, dynamic> toJson() => {
    "stu_id": stuId,
    "psc_class_id": pscClassId,
    "psc_stu_name": pscStuName,
    "psc_mob_no": pscMobNo,
    "cou_name": couName,
    "cou_image": couImage,
    "cou_description": couDescription,
    "cou_status": couStatus,
  };
}

class NoteRecord {
  String clasRecId;
  String clasRecNoteName;
  String clasRecClassNote;
  String clasRecStatus;

  NoteRecord({
    required this.clasRecId,
    required this.clasRecNoteName,
    required this.clasRecClassNote,
    required this.clasRecStatus,
  });

  NoteRecord copyWith({
    String? clasRecId,
    String? clasRecNoteName,
    String? clasRecClassNote,
    String? clasRecStatus,
  }) =>
      NoteRecord(
        clasRecId: clasRecId ?? this.clasRecId,
        clasRecNoteName: clasRecNoteName ?? this.clasRecNoteName,
        clasRecClassNote: clasRecClassNote ?? this.clasRecClassNote,
        clasRecStatus: clasRecStatus ?? this.clasRecStatus,
      );

  factory NoteRecord.fromJson(Map<String, dynamic> json) => NoteRecord(
    clasRecId: json["clas_rec_id"],
    clasRecNoteName: json["clas_rec_note_name"],
    clasRecClassNote: json["clas_rec_class_note"],
    clasRecStatus: json["clas_rec_status"],
  );

  Map<String, dynamic> toJson() => {
    "clas_rec_id": clasRecId,
    "clas_rec_note_name": clasRecNoteName,
    "clas_rec_class_note": clasRecClassNote,
    "clas_rec_status": clasRecStatus,
  };
}

class VideoRecord {
  String clasRecId;
  String clasRecVideoName;
  String clasRecVideo;
  String clasRecVideoDuration;
  String clasRecStatus;

  VideoRecord({
    required this.clasRecId,
    required this.clasRecVideoName,
    required this.clasRecVideo,
    required this.clasRecVideoDuration,
    required this.clasRecStatus,
  });

  VideoRecord copyWith({
    String? clasRecId,
    String? clasRecVideoName,
    String? clasRecVideo,
    String? clasRecVideoDuration,
    String? clasRecStatus,
  }) =>
      VideoRecord(
        clasRecId: clasRecId ?? this.clasRecId,
        clasRecVideoName: clasRecVideoName ?? this.clasRecVideoName,
        clasRecVideo: clasRecVideo ?? this.clasRecVideo,
        clasRecVideoDuration: clasRecVideoDuration ?? this.clasRecVideoDuration,
        clasRecStatus: clasRecStatus ?? this.clasRecStatus,
      );

  factory VideoRecord.fromJson(Map<String, dynamic> json) => VideoRecord(
    clasRecId: json["clas_rec_id"],
    clasRecVideoName: json["clas_rec_video_name"],
    clasRecVideo: json["clas_rec_video"],
    clasRecVideoDuration: json["clas_rec_video_duration"],
    clasRecStatus: json["clas_rec_status"],
  );

  Map<String, dynamic> toJson() => {
    "clas_rec_id": clasRecId,
    "clas_rec_video_name": clasRecVideoName,
    "clas_rec_video": clasRecVideo,
    "clas_rec_video_duration": clasRecVideoDuration,
    "clas_rec_status": clasRecStatus,
  };
}
