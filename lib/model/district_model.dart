// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    DistrictModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
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
    String? districtId;
    String? districtName;

    Datum({
        this.districtId,
        this.districtName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        districtId: json["districtId"],
        districtName: json["districtName"],
    );

    Map<String, dynamic> toJson() => {
        "districtId": districtId,
        "districtName": districtName,
    };
}
