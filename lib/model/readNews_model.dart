// To parse this JSON data, do
//
//     final readNewsModel = readNewsModelFromJson(jsonString);

import 'dart:convert';

ReadNewsModel readNewsModelFromJson(String str) => ReadNewsModel.fromJson(json.decode(str));

String readNewsModelToJson(ReadNewsModel data) => json.encode(data.toJson());

class ReadNewsModel {
    int? statusCode;
    String? message;
    bool? isSuccess;

    ReadNewsModel({
        this.statusCode,
        this.message,
        this.isSuccess,
    });

    factory ReadNewsModel.fromJson(Map<String, dynamic> json) => ReadNewsModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
    };
}
