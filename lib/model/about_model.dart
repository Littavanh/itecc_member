// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

AboutModel aboutModelFromJson(String str) =>
    AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  String? applicationName;
  String? applicationVersion;
  String? applicationLastUpDate;
  String? applicationOwner;
  String? applicationInfo;
  String? applicationCopyRight;
  String? address;
  String? callCenter;
  String? appUrl;

  AboutModel({
    this.applicationName,
    this.applicationVersion,
    this.applicationLastUpDate,
    this.applicationOwner,
    this.applicationInfo,
    this.applicationCopyRight,
    this.address,
    this.callCenter,
    this.appUrl,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
        applicationName: json["applicationName"],
        applicationVersion: json["applicationVersion"],
        applicationLastUpDate: json["applicationLastUpDate"],
        applicationOwner: json["applicationOwner"],
        applicationInfo: json["applicationInfo"],
        applicationCopyRight: json["applicationCopyRight"],
        address: json["address"],
        callCenter: json["callCenter"],
        appUrl: json["appURL"],
      );

  Map<String, dynamic> toJson() => {
        "applicationName": applicationName,
        "applicationVersion": applicationVersion,
        "applicationLastUpDate": applicationLastUpDate,
        "applicationOwner": applicationOwner,
        "applicationInfo": applicationInfo,
        "applicationCopyRight": applicationCopyRight,
        "address": address,
        "callCenter": callCenter,
        "appURL": appUrl,
      };
}
