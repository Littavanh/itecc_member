// To parse this JSON data, do
//
//     final scanQrCodeShop = scanQrCodeShopFromJson(jsonString);

import 'dart:convert';

ScanQrCodeShop scanQrCodeShopFromJson(String str) => ScanQrCodeShop.fromJson(json.decode(str));

String scanQrCodeShopToJson(ScanQrCodeShop data) => json.encode(data.toJson());

class ScanQrCodeShop {
    int? statusCode;
    String? message;
    bool? isSuccess;
    String? shopCode;
    String? shopName;

    ScanQrCodeShop({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.shopCode,
        this.shopName,
    });

    factory ScanQrCodeShop.fromJson(Map<String, dynamic> json) => ScanQrCodeShop(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        shopCode: json["shopCode"],
        shopName: json["shopName"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "shopCode": shopCode,
        "shopName": shopName,
    };
}
