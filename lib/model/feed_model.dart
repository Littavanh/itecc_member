// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));

String feedToJson(Feed data) => json.encode(data.toJson());

class Feed {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    Feed({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
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
    String? feedId;
    String? feedTitle;
    String? feedDetail;
    String? imageUrl;

    Datum({
        this.feedId,
        this.feedTitle,
        this.feedDetail,
        this.imageUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        feedId: json["feedId"],
        feedTitle: json["feedTitle"],
        feedDetail: json["feedDetail"],
        imageUrl: json["imageURL"],
    );

    Map<String, dynamic> toJson() => {
        "feedId": feedId,
        "feedTitle": feedTitle,
        "feedDetail": feedDetail,
        "imageURL": imageUrl,
    };
}
