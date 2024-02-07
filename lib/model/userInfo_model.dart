// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    UserInfoModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        totalRecord: json["totalRecord"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "totalRecord": totalRecord,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? cusId;
    String? userName;
    String? firstName;
    String? lastName;
    String? dob;
    String? gender;
    String? emailAddr;
    String? villageCode;
    String? village;
    String? district;
    String? province;
    String? userImageUrl;

    Datum({
        this.cusId,
        this.userName,
        this.firstName,
        this.lastName,
        this.dob,
        this.gender,
        this.emailAddr,
        this.villageCode,
        this.village,
        this.district,
        this.province,
        this.userImageUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        cusId: json["cusID"],
        userName: json["userName"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        dob: json["dob"],
        gender: json["gender"],
        emailAddr: json["emailAddr"],
        villageCode: json["villageCode"],
        village: json["village"],
        district: json["district"],
        province: json["province"],
        userImageUrl: json["userImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "cusID": cusId,
        "userName": userName,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "gender": gender,
        "emailAddr": emailAddr,
        "villageCode": villageCode,
        "village": village,
        "district": district,
        "province": province,
        "userImageURL": userImageUrl,
    };
}
