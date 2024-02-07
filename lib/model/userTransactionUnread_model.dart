// To parse this JSON data, do
//
//     final userTransactionUnreadModel = userTransactionUnreadModelFromJson(jsonString);

import 'dart:convert';

UserTransactionUnreadModel userTransactionUnreadModelFromJson(String str) => UserTransactionUnreadModel.fromJson(json.decode(str));

String userTransactionUnreadModelToJson(UserTransactionUnreadModel data) => json.encode(data.toJson());

class UserTransactionUnreadModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    int? numUnread;

    UserTransactionUnreadModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.numUnread,
    });

    factory UserTransactionUnreadModel.fromJson(Map<String, dynamic> json) => UserTransactionUnreadModel(
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
