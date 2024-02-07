// To parse this JSON data, do
//
//     final applicationListModel = applicationListModelFromJson(jsonString);

import 'dart:convert';

ApplicationListModel applicationListModelFromJson(String str) => ApplicationListModel.fromJson(json.decode(str));

String applicationListModelToJson(ApplicationListModel data) => json.encode(data.toJson());

class ApplicationListModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    ApplicationListModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory ApplicationListModel.fromJson(Map<String, dynamic> json) => ApplicationListModel(
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
    String? applicationId;
    String? applicationIconImage;
    String? applicationName;
    String? applicationUrl;

    Datum({
        this.applicationId,
        this.applicationIconImage,
        this.applicationName,
        this.applicationUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        applicationId: json["applicationId"],
        applicationIconImage: json["applicationIconImage"],
        applicationName: json["applicationName"],
        applicationUrl: json["applicationURL"],
    );

    Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "applicationIconImage": applicationIconImage,
        "applicationName": applicationName,
        "applicationURL": applicationUrl,
    };
}
