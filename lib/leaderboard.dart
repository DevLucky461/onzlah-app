import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => new _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> with SingleTickerProviderStateMixin {
  TabController _tabController;
  WebViewController webView;
  final logout = Logout();

  /*Future<String> get _friendlist async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    var data2  = {
      "user_id" :  body['user']['id'],
    };
    var res2 = await CallApi().postData(data2, 'leaderboard');
    var body2 = json.decode(res2.body);
    return body2['friendlist'].toString();
  }*/

  Future<String> get _id async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    } else {
      await Future.delayed(Duration(seconds: 1));

      return body['user']['id'].toString();
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Common.AppColor,
          ),
        ),
        title: BackNavigation(),
        toolbarHeight: 100,
        bottom: new TabBar(
          indicatorColor: Color(0xffFF3E6F),
          controller: _tabController,
          isScrollable: true,
          labelStyle: TextStyle(
            fontFamily: 'MontserratBold',
            fontSize: 16.0,
            decoration: TextDecoration.none,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Common.orange_color,
          tabs: [
            Tab(text: 'DAILY'),
            Tab(text: 'FRIENDS'),
            Tab(text: 'NATIONWIDE'),
          ],
        ),
      ),
      body: new TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          FutureBuilder(
              future: _id,
              builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                  ? WebView(
                      initialUrl: Common.ApiUrl + 'leaderboarddaily/' + snapshot.data,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        webView = controller;
                      },
                    )
                  : Center(child: CircularProgressIndicator())),
          FutureBuilder(
              future: _id,
              builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                  ? WebView(
                      initialUrl: Common.ApiUrl + 'leaderboardfriend/' + snapshot.data,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        webView = controller;
                      },
                    )
                  : Center(child: CircularProgressIndicator())),
          FutureBuilder(
              future: _id,
              builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                  ? WebView(
                      initialUrl: Common.ApiUrl + 'leaderboardall/' + snapshot.data,
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (controller) {
                        webView = controller;
                      },
                    )
                  : Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }
}

class BackNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/icon/left-arrow.png',
            height: 20,
          ),
        ),
        Expanded(
          child: Text(
            "Leaderboard",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 16.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ),
      ],
    );
  }
}
