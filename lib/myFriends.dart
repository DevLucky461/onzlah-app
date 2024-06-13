import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'addFriends.dart';
import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class MyFriends extends StatefulWidget {
  @override
  _MyFriendsState createState() => new _MyFriendsState();
}

class _MyFriendsState extends State<MyFriends> with SingleTickerProviderStateMixin {
  final logout = Logout();
  TabController _tabController;
  WebViewController webView;

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
    _tabController = TabController(length: 2, vsync: this);

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
          isScrollable: true,
          controller: _tabController,
          labelStyle: TextStyle(
            fontFamily: 'MontserratBold',
            fontSize: 16.0,
            decoration: TextDecoration.none,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Common.orange_color,
          tabs: [Tab(text: 'LIST'), Tab(text: 'FRIEND REQUEST')],
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
                      initialUrl: Common.ApiUrl + 'viewMyFriendsList/' + snapshot.data,
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
                      initialUrl: Common.ApiUrl + 'viewMyFriendsFriendRequest/' + snapshot.data,
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
            "My Friends",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 16.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ),
        GestureDetector(
          child: Image.asset('assets/icon/add_friends.png'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriends()));
          },
        ),
      ],
    );
  }
}
