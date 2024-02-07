// To parse this JSON data, do
//
//     final requestPaymentStaff = requestPaymentStaffFromJson(jsonString);

import 'dart:convert';

RequestPaymentStaff requestPaymentStaffFromJson(String str) => RequestPaymentStaff.fromJson(json.decode(str));

String requestPaymentStaffToJson(RequestPaymentStaff data) => json.encode(data.toJson());

class RequestPaymentStaff {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? shopCode;
    String? shopName;
    String? totalBalance;
    String? requestAmount;
    String? balance;
    String? paymentCode;

    RequestPaymentStaff({
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

    factory RequestPaymentStaff.fromJson(Map<String, dynamic> json) => RequestPaymentStaff(
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
