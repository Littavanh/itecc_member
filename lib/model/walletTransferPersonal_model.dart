// To parse this JSON data, do
//
//     final walletTransferPersonalModel = walletTransferPersonalModelFromJson(jsonString);

import 'dart:convert';

WalletTransferPersonalModel walletTransferPersonalModelFromJson(String str) => WalletTransferPersonalModel.fromJson(json.decode(str));

String walletTransferPersonalModelToJson(WalletTransferPersonalModel data) => json.encode(data.toJson());

class WalletTransferPersonalModel {
    int statusCode;
    String message;
    bool isSuccess;
    String toMobileNumber;
    String toAccountFulName;
    String totalBalance;
    String transferAmount;
    String balance;
    String transferCode;

    WalletTransferPersonalModel({
        required this.statusCode,
        required this.message,
        required this.isSuccess,
        required this.toMobileNumber,
        required this.toAccountFulName,
        required this.totalBalance,
        required this.transferAmount,
        required this.balance,
        required this.transferCode,
    });

    factory WalletTransferPersonalModel.fromJson(Map<String, dynamic> json) => WalletTransferPersonalModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        toMobileNumber: json["toMobileNumber"],
        toAccountFulName: json["toAccountFulName"],
        totalBalance: json["totalBalance"],
        transferAmount: json["transferAmount"],
        balance: json["balance"],
        transferCode: json["transferCode"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "toMobileNumber": toMobileNumber,
        "toAccountFulName": toAccountFulName,
        "totalBalance": totalBalance,
        "transferAmount": transferAmount,
        "balance": balance,
        "transferCode": transferCode,
    };
}
