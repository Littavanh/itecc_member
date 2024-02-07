// To parse this JSON data, do
//
//     final backgroundImageModel = backgroundImageModelFromJson(jsonString);

import 'dart:convert';

BackgroundImageModel backgroundImageModelFromJson(String str) => BackgroundImageModel.fromJson(json.decode(str));

String backgroundImageModelToJson(BackgroundImageModel data) => json.encode(data.toJson());

class BackgroundImageModel {
    String? bgImage;

    BackgroundImageModel({
        this.bgImage,
    });

    factory BackgroundImageModel.fromJson(Map<String, dynamic> json) => BackgroundImageModel(
        bgImage: json["bgImage"],
    );

    Map<String, dynamic> toJson() => {
        "bgImage": bgImage,
    };
}
