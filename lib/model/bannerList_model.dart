// To parse this JSON data, do
//
//     final bannerList = bannerListFromJson(jsonString);

import 'dart:convert';

BannerList bannerListFromJson(String str) => BannerList.fromJson(json.decode(str));

String bannerListToJson(BannerList data) => json.encode(data.toJson());

class BannerList {
    int? statusCode;
    String? message;
    bool? isSuccess;
    double? totalRecord;
    List<Datum>? data;

    BannerList({
        this.statusCode,
        this.message,
        this.isSuccess,
        this.totalRecord,
        this.data,
    });

    factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
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
    String? bannerId;
    String? bannerName;
    String? bannerDetail;
    String? imageUrl;

    Datum({
        this.bannerId,
        this.bannerName,
        this.bannerDetail,
        this.imageUrl,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bannerId: json["bannerId"],
        bannerName: json["bannerName"],
        bannerDetail: json["bannerDetail"],
        imageUrl: json["imageURL"],
    );

    Map<String, dynamic> toJson() => {
        "bannerId": bannerId,
        "bannerName": bannerName,
        "bannerDetail": bannerDetail,
        "imageURL": imageUrl,
    };
}
