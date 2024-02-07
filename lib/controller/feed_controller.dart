import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:itecc_member/model/applicationList_model.dart';
import 'package:itecc_member/model/bannerList_model.dart';
import 'package:itecc_member/model/news_model.dart';
import 'dart:convert';

import '../model/backgroundImage_model.dart';
import '../model/feed_model.dart';
import '../services/todo_services.dart';

class FeedController extends GetxController {
  ///////////////////// applicationList
  var isLoading = false.obs;

  Feed? feed;

  @override
  Future<void> onInit() async {
    super.onInit();

    fetchFeed();
  }

  fetchFeed() async {
    try {
      isLoading(true);
      http.Response response =
          await http.get(Uri.tryParse('$url/Main/Feed')!);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        print(result);
        feed = Feed.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
