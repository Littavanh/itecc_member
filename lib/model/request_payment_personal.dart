// To parse this JSON data, do
//
//     final requestPaymentPersonal = requestPaymentPersonalFromJson(jsonString);

import 'dart:convert';

RequestPaymentPersonal requestPaymentPersonalFromJson(String str) => RequestPaymentPersonal.fromJson(json.decode(str));

String requestPaymentPersonalToJson(RequestPaymentPersonal data) => json.encode(data.toJson());

class RequestPaymentPersonal {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? shopCode;
    String? shopName;
    String? totalBalance;
    String? requestAmount;
    String? balance;
    String? paymentCode;

    RequestPaymentPersonal({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.shopCode,
        this.shopName,
        this.totalBalance,
        this.requestAmount,
        this.balance,
        this.paymentCode,
    });

    factory RequestPaymentPersonal.fromJson(Map<String, dynamic> json) => RequestPaymentPersonal(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        shopCode: json["shopCode"],
        shopName: json["shopName"],
        totalBalance: json["totalBalance"],
        requestAmount: json["requestAmount"],
        balance: json["balance"],
        paymentCode: json["paymentCode"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "shopCode": shopCode,
        "shopName": shopName,
        "totalBalance": totalBalance,
        "requestAmount": requestAmount,
        "balance": balance,
        "paymentCode": paymentCode,
    };
}
