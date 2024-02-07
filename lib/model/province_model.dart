// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import '../services/todo_services.dart';

ProvinceModel provinceModelFromJson(String str) =>
    ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());
final box = GetStorage();

class ProvinceModel {
  int? statusCode;
  String? message;
  bool? isSuccess;
  double? totalRecord;
  List<Datum>? data;

  ProvinceModel({
    this.statusCode,
    this.message,
    this.isSuccess,
    this.totalRecord,
    this.data,
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        totalRecord: json["totalRecord"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
        "totalRecord": totalRecord,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? provinceId;
  String provinceName;

  Datum({
    this.provinceId,
    required this.provinceName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        provinceId: json["provinceId"],
        provinceName: json["provinceName"],
      );

  Map<String, dynamic> toJson() => {
        "provinceId": provinceId,
        "provinceName": provinceName,
      };
  factory Datum.fromMap(Map<String, dynamic> map) {
    return Datum(
      provinceId: map['provinceId']?.toInt(),
      provinceName: map['provinceName'] ?? '',
    );
  }

}
