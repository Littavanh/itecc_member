import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:itecc_member/model/userTransaction_model.dart';
import 'package:itecc_member/services/todo_services.dart';
import 'package:itecc_member/style/color.dart';

class TestScroll extends StatefulWidget {
  const TestScroll({Key? key}) : super(key: key);

  @override
  State<TestScroll> createState() => _TestScrollState();
}

class _TestScrollState extends State<TestScroll> {
  // We will fetch data from this Rest api
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 5;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List<Datum>? data;
  UserTransactionModel? userTransactionModel;

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    print('firstLoad');
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.post(Uri.tryParse('$url/notication/userTransaction')!,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "userID": "3252",
                "tokenKey": "9303aecb-a7ec-489d-b2d1-89ea25948101",
                "pageNum": _page
              }));
      var json = jsonDecode(res.body);
      final userTransactionModel = Datum.fromJson(json['data'][0]);
      print(json);
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.post(Uri.tryParse('$url/notication/userTransaction')!,
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode({
                  "userID": "3252",
                  "tokenKey": "9303aecb-a7ec-489d-b2d1-89ea25948101",
                  "pageNum": _page
                }));
        userTransactionModel =
            await UserTransactionModel.fromJson(jsonDecode(res.body));
        if (userTransactionModel != null) {
          setState(() {
            data!.addAll(userTransactionModel!.data!);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: const CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                  controller: _controller,
                    itemCount: userTransactionModel!.data!.length,
                    itemBuilder: (_, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: ListTile(
                        trailing:
                            Text('data', style: TextStyle(color: textColor)),
                        title: Text(
                          userTransactionModel
                                  ?.data?[index].transactionDetail ??
                              '',
                          style: TextStyle(color: textColor),
                        ),
                        subtitle: Text(
                            userTransactionModel?.data?[index].transactionId ??
                                '',
                            style: TextStyle(color: textColor)),
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }
}
