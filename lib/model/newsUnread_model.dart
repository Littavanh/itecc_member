// To parse this JSON data, do
//
//     final newsUnreadModel = newsUnreadModelFromJson(jsonString);

import 'dart:convert';

NewsUnreadModel newsUnreadModelFromJson(String str) => NewsUnreadModel.fromJson(json.decode(str));

String newsUnreadModelToJson(NewsUnreadModel data) => json.encode(data.toJson());

class NewsUnreadModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    int? numUnread;

    NewsUnreadModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.numUnread,
    });

    factory NewsUnreadModel.fromJson(Map<String, dynamic> json) => NewsUnreadModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        numUnread: json["numUnread"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "numUnread": numUnread,
    };
}
