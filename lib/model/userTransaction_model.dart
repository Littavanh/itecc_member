// To parse this JSON data, do
//
//     final userTransactionModel = userTransactionModelFromJson(jsonString);

import 'dart:convert';

UserTransactionModel userTransactionModelFromJson(String str) => UserTransactionModel.fromJson(json.decode(str));

String userTransactionModelToJson(UserTransactionModel data) => json.encode(data.toJson());

class UserTransactionModel {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    UserTransactionModel({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory UserTransactionModel.fromJson(Map<String, dynamic> json) => UserTransactionModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        totalRecord: json["totalRecord"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "totalRecord": totalRecord,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? transactionId;
    String? transactionDate;
    String? transactionTitle;
    String? amount;
    String? trasactionCode;
    String? shopName;
    String? point;
    String? transactionDetail;
    String? readState;

    Datum({
        this.transactionId,
        this.transactionDate,
        this.transactionTitle,
        this.amount,
        this.trasactionCode,
        this.shopName,
        this.point,
        this.transactionDetail,
        this.readState,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        transactionId: json["transactionId"],
        transactionDate: json["transactionDate"],
        transactionTitle: json["transactionTitle"],
        amount: json["amount"],
        trasactionCode: json["trasactionCode"],
        shopName: json["shopName"],
        point: json["point"],
        transactionDetail: json["transactionDetail"],
        readState: json["readState"],
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "transactionDate": transactionDate,
        "transactionTitle": transactionTitle,
        "amount": amount,
        "trasactionCode": trasactionCode,
        "shopName": shopName,
        "point": point,
        "transactionDetail": transactionDetail,
        "readState": readState,
    };
}
