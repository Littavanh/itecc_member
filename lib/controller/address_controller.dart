import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:itecc_member/model/province_model.dart';
import 'package:http/http.dart' as http;


import '../model/district_model.dart';
import '../model/village_model.dart';
import '../services/todo_services.dart';

final box = GetStorage();

class AddressController extends GetxController {
    var isLoading = false.obs;
    var isLoading1 = false.obs;
    var isLoading2 = false.obs;
  var userID = box.read('userId');
  var tokenKey = box.read('tokenKey');
  ProvinceModel? provinceModel;
  DistrictModel? districtModel;
  VillageModel? villageModel;


  @override
  Future<void> onInit() async {
   
      
    super.onInit();
   fetchProvince();
  
   
  }

  fetchProvince() async {
    try {
      print('fecthProvince');
      isLoading(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/MasterData/provinceList')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        provinceModel = ProvinceModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
        isLoading(false);
    }
  }

  fetchDistrict(int provinceId) async {
    try {
    isLoading1(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/MasterData/districtList')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey,"provinceId": provinceId}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        districtModel = DistrictModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
       isLoading1(false);
    }
  }

  fetchVillage(int districtId) async {
    try {
     isLoading2(true);
      http.Response response = await http.post(
          Uri.tryParse('$url/MasterData/villageList')!,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({"userID": userID, "tokenKey": tokenKey,"districtId": districtId}));
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        villageModel = VillageModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
     isLoading2(false);
    }
  }
}
