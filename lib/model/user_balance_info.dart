// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UserBalanceInfoModel {
  int? statusCode;
  String? message;
  bool? isSuccess;
  String? lastUpdate;
  double? totalPoint;
  double? totalBonus;
  double? staffBalance;
  double? personalBalance;
  UserBalanceInfoModel(
      {this.statusCode,
      this.message,
      this.isSuccess,
      this.lastUpdate,
      this.totalPoint,
      this.totalBonus,
      this.staffBalance,
      this.personalBalance});

  UserBalanceInfoModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    isSuccess = json['isSuccess'];
    lastUpdate = json['lastUpdate'];
    totalPoint = json['totalPoint'];
    totalBonus = json['totalBonus'];
    staffBalance = json['staffBalance'];
    personalBalance = json['personalBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    data['lastUpdate'] = this.lastUpdate;
    data['totalPoint'] = this.totalPoint;
    data['totalBonus'] = this.totalBonus;
    data['staffBalance'] = this.staffBalance;
    data['personalBalance'] = this.personalBalance;
    return data;
  }

  // static Future<UserBalanceInfoModel> fetchUbi() async {
  //   try {
  //     final response = await http.post(
  //         Uri.parse('$url/Account/userBalanceInfo'),
  //         headers: {'Content-Type': 'application/json'},
  //         body: jsonEncode({
  //           "userID": S_userId,
  //           "tokenKey": S_tokenKey
  //         }));
  //     if (response.statusCode == 200) {
  //       final json = UserBalanceInfoModel.fromJson(jsonDecode(response.body));
  //        print("response: ${json.toJson().toString()}");
  //       return json;
  //     } else {
  //       throw FetchDataException(error: response.body);
  //     }
  //   } on Exception catch (e) {
  //     throw e.toString();
  //   }
  // }
}
