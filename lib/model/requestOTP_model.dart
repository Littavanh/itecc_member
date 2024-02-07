// To parse this JSON data, do
//
//     final requstOtpModel = requstOtpModelFromJson(jsonString);

import 'dart:convert';

RequstOtpModel requstOtpModelFromJson(String str) => RequstOtpModel.fromJson(json.decode(str));

String requstOtpModelToJson(RequstOtpModel data) => json.encode(data.toJson());

class RequstOtpModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? userImage;

    RequstOtpModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.userImage,
    });

    factory RequstOtpModel.fromJson(Map<String, dynamic> json) => RequstOtpModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        userImage: json["userImage"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "userImage": userImage,
    };
}
