// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    News({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
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
    String? newsId;
    String? newsTitle;
    String? newsDetail;
    String? imageUrl;
    String? readState;

    Datum({
        this.newsId,
        this.newsTitle,
        this.newsDetail,
        this.imageUrl,
        this.readState,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        newsId: json["newsId"],
        newsTitle: json["newsTitle"],
        newsDetail: json["newsDetail"],
        imageUrl: json["imageUrl"],
        readState: json["readState"],
    );

    Map<String, dynamic> toJson() => {
        "newsId": newsId,
        "newsTitle": newsTitle,
        "newsDetail": newsDetail,
        "imageUrl": imageUrl,
        "readState": readState,
    };
}
