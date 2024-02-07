// To parse this JSON data, do
//
//     final saveNewPin = saveNewPinFromJson(jsonString);

import 'dart:convert';

SaveNewPin saveNewPinFromJson(String str) => SaveNewPin.fromJson(json.decode(str));

String saveNewPinToJson(SaveNewPin data) => json.encode(data.toJson());

class SaveNewPin {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? newPin;

    SaveNewPin({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.newPin,
    });

    factory SaveNewPin.fromJson(Map<String, dynamic> json) => SaveNewPin(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        newPin: json["newPIN"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "newPIN": newPin,
    };
}
