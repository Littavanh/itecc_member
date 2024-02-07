// To parse this JSON data, do
//
//     final villageModel = villageModelFromJson(jsonString);

import 'dart:convert';

VillageModel villageModelFromJson(String str) => VillageModel.fromJson(json.decode(str));

String villageModelToJson(VillageModel data) => json.encode(data.toJson());

class VillageModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    VillageModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory VillageModel.fromJson(Map<String, dynamic> json) => VillageModel(
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
    String? villageId;
    String? villageName;

    Datum({
        this.villageId,
        this.villageName,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        villageId: json["villageId"],
        villageName: json["villageName"],
    );

    Map<String, dynamic> toJson() => {
        "villageId": villageId,
        "villageName": villageName,
    };
}
