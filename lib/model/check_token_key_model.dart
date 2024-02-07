// To parse this JSON data, do
//
//     final checkTokenKeyModel = checkTokenKeyModelFromJson(jsonString);

import 'dart:convert';

CheckTokenKeyModel checkTokenKeyModelFromJson(String str) => CheckTokenKeyModel.fromJson(json.decode(str));

String checkTokenKeyModelToJson(CheckTokenKeyModel data) => json.encode(data.toJson());

class CheckTokenKeyModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    List<Datum>? data;

    CheckTokenKeyModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.data,
    });

    factory CheckTokenKeyModel.fromJson(Map<String, dynamic> json) => CheckTokenKeyModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? userId;
    String? userName;
    String? tokenKey;
    String? firstName;
    String? lastName;
    String? fullName;
    String? roleId;
    String? roleName;
    String? roleType;
    String? status;
    String? strDate;
    String? expDate;
    String? userImage;
    String? mobileNumber;
    String? updateProfile;
    String? staffWalet;
    String? personalWalet;

    Datum({
        this.userId,
        this.userName,
        this.tokenKey,
        this.firstName,
        this.lastName,
        this.fullName,
        this.roleId,
        this.roleName,
        this.roleType,
        this.status,
        this.strDate,
        this.expDate,
        this.userImage,
        this.mobileNumber,
        this.updateProfile,
        this.staffWalet,
        this.personalWalet,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["userId"],
        userName: json["userName"],
        tokenKey: json["tokenKey"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        roleId: json["roleId"],
        roleName: json["roleName"],
        roleType: json["roleType"],
        status: json["status"],
        strDate: json["strDate"],
        expDate: json["expDate"],
        userImage: json["userImage"],
        mobileNumber: json["mobileNumber"],
        updateProfile: json["updateProfile"],
        staffWalet: json["staffWalet"],
        personalWalet: json["personalWalet"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "tokenKey": tokenKey,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "roleId": roleId,
        "roleName": roleName,
        "roleType": roleType,
        "status": status,
        "strDate": strDate,
        "expDate": expDate,
        "userImage": userImage,
        "mobileNumber": mobileNumber,
        "updateProfile": updateProfile,
        "staffWalet": staffWalet,
        "personalWalet": personalWalet,
    };
}
