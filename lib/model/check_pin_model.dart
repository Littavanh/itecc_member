// To parse this JSON data, do
//
//     final checkpinModel = checkpinModelFromJson(jsonString);

import 'dart:convert';

CheckpinModel checkpinModelFromJson(String str) => CheckpinModel.fromJson(json.decode(str));

String checkpinModelToJson(CheckpinModel data) => json.encode(data.toJson());

class CheckpinModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? paymentCode;

    CheckpinModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.paymentCode,
    });

    factory CheckpinModel.fromJson(Map<String, dynamic> json) => CheckpinModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        paymentCode: json["paymentCode"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "paymentCode": paymentCode,
    };
}
