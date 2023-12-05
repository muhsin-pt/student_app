import 'dart:convert';
ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));
String profileModelToJson(ProfileModel data) => json.encode(data.toJson());
class ProfileModel {
    String status;
    String message;
    List<MasterDetail> masterDetails;

    ProfileModel({
        required this.status,
        required this.message,
        required this.masterDetails,
    });
    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
    String stuId;
    String pscStuName;
    String pscMobNo;
    String couName;
    String pscAddress;
    String promoter;
    String code;

    MasterDetail({
        required this.stuId,
        required this.pscStuName,
        required this.pscMobNo,
        required this.couName,
        required this.pscAddress,
        required this.promoter,
        required this.code,
    });

    factory MasterDetail.fromJson(Map<String, dynamic> json) => MasterDetail(
        stuId: json["stu_id"],
        pscStuName: json["psc_stu_name"],
        pscMobNo: json["psc_mob_no"],
        couName: json["cou_name"],
        pscAddress: json["psc_address"],
        promoter: json["promoter"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "stu_id": stuId,
        "psc_stu_name": pscStuName,
        "psc_mob_no": pscMobNo,
        "cou_name": couName,
        "psc_address": pscAddress,
        "promoter": promoter,
        "code": code,
    };
}
