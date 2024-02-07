// To parse this JSON data, do
//
//     final readUserTransactionModel = readUserTransactionModelFromJson(jsonString);

import 'dart:convert';

ReadUserTransactionModel readUserTransactionModelFromJson(String str) => ReadUserTransactionModel.fromJson(json.decode(str));

String readUserTransactionModelToJson(ReadUserTransactionModel data) => json.encode(data.toJson());

class ReadUserTransactionModel {
    int? statusCode;
    String? message;
    bool? isSuccess;

    ReadUserTransactionModel({
        this.statusCode,
        this.message,
        this.isSuccess,
    });

    factory ReadUserTransactionModel.fromJson(Map<String, dynamic> json) => ReadUserTransactionModel(
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
