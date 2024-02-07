// To parse this JSON data, do
//
//     final rewardList = rewardListFromJson(jsonString);

import 'dart:convert';

RewardList rewardListFromJson(String str) => RewardList.fromJson(json.decode(str));

String rewardListToJson(RewardList data) => json.encode(data.toJson());

class RewardList {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    RewardList({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory RewardList.fromJson(Map<String, dynamic> json) => RewardList(
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
    String? rewardCode;
    String? rewardName;
    String? rewardCondition;
    String? rewardPoint;
    String? imageUrl;
    String? beginDate;
    String? expDate;

    Datum({
        this.rewardCode,
        this.rewardName,
        this.rewardCondition,
        this.rewardPoint,
        this.imageUrl,
        this.beginDate,
        this.expDate,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        rewardCode: json["rewardCode"],
        rewardName: json["rewardName"],
        rewardCondition: json["rewardCondition"],
        rewardPoint: json["rewardPoint"],
        imageUrl: json["imageUrl"],
        beginDate: json["beginDate"],
        expDate: json["expDate"],
    );

    Map<String, dynamic> toJson() => {
        "rewardCode": rewardCode,
        "rewardName": rewardName,
        "rewardCondition": rewardCondition,
        "rewardPoint": rewardPoint,
        "imageUrl": imageUrl,
        "beginDate": beginDate,
        "expDate": expDate,
    };
}
