// To parse this JSON data, do
//
//     final requestNewPin = requestNewPinFromJson(jsonString);

import 'dart:convert';

RequestNewPin requestNewPinFromJson(String str) => RequestNewPin.fromJson(json.decode(str));

String requestNewPinToJson(RequestNewPin data) => json.encode(data.toJson());

class RequestNewPin {
    int? statusCode;
    String? message;
    bool? isSuccess;

    RequestNewPin({
        this.statusCode,
        this.message,
        this.isSuccess,
    });

    factory RequestNewPin.fromJson(Map<String, dynamic> json) => RequestNewPin(
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
