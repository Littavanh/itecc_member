// To parse this JSON data, do
//
//     final homeScreenApplicationListModel = homeScreenApplicationListModelFromJson(jsonString);

import 'dart:convert';

HomeScreenApplicationListModel homeScreenApplicationListModelFromJson(String str) => HomeScreenApplicationListModel.fromJson(json.decode(str));

String homeScreenApplicationListModelToJson(HomeScreenApplicationListModel data) => json.encode(data.toJson());

class HomeScreenApplicationListModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    HomeScreenApplicationListModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory HomeScreenApplicationListModel.fromJson(Map<String, dynamic> json) => HomeScreenApplicationListModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        totalRecord: json["totalRecord"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "totalRecord": totalRecord,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
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
