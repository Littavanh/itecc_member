// To parse this JSON data, do
//
//     final customerInfoModel = customerInfoModelFromJson(jsonString);

import 'dart:convert';

CustomerInfoModel customerInfoModelFromJson(String str) => CustomerInfoModel.fromJson(json.decode(str));

String customerInfoModelToJson(CustomerInfoModel data) => json.encode(data.toJson());

class CustomerInfoModel {
    int statusCode;
    String message;
    bool isSuccess;
    int totalRecord;
    String cusId;
    String firstName;
    String lastName;
    String mobileNumber;
    String dob;
    String gender;
    String emailAddr;
    String village;
    String district;
    String province;
    String userImageUrl;
    String statusText;
    bool transaferState;

    CustomerInfoModel({
        required this.statusCode,
        required this.message,
        required this.isSuccess,
        required this.totalRecord,
        required this.cusId,
        required this.firstName,
        required this.lastName,
        required this.mobileNumber,
        required this.dob,
        required this.gender,
        required this.emailAddr,
        required this.village,
        required this.district,
        required this.province,
        required this.userImageUrl,
        required this.statusText,
        required this.transaferState,
    });

    factory CustomerInfoModel.fromJson(Map<String, dynamic> json) => CustomerInfoModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        totalRecord: json["totalRecord"],
        cusId: json["cusID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
        dob: json["dob"],
        gender: json["gender"],
        emailAddr: json["emailAddr"],
        village: json["village"],
        district: json["district"],
        province: json["province"],
        userImageUrl: json["userImageURL"],
        statusText: json["statusText"],
        transaferState: json["transaferState"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "totalRecord": totalRecord,
        "cusID": cusId,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "dob": dob,
        "gender": gender,
        "emailAddr": emailAddr,
        "village": village,
        "district": district,
        "province": province,
        "userImageURL": userImageUrl,
        "statusText": statusText,
        "transaferState": transaferState,
    };
}
