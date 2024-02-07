
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../services/todo_services.dart';
UpdateUserModel updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
    int? statusCode;
    String? message;
    bool? isSuccess;

    UpdateUserModel({
        this.statusCode,
        this.message,
        this.isSuccess,
    });

    factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
        statusCode: json["statusCode"],
        message: json["message"],
        isSuccess: json["isSuccess"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "isSuccess": isSuccess,
    };
    
}
