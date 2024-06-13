import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';

class ShareFeedback extends StatefulWidget {
  @override
  _ShareFeedbackState createState() => new _ShareFeedbackState();
}

class _ShareFeedbackState extends State<ShareFeedback> {
  final logout = Logout();
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

  Future<String> get f_result async {
    var f_res = await CallApi().postData({"user_id": _id}, 'get-feedback');
    var f_body = json.decode(f_res.body);
    var feed_result = f_body['feedback'].toString();
    print(feed_result);
    return feed_result;
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
      ),
      body: Container(
        height: getScreenHeight(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Common.profile_start_color, Common.profile_end_color],
          ),
        ),
        child: FutureBuilder(
            future: _id,
            builder: (BuildContext context, AsyncSnapshot snapshot) => snapshot.hasData
                ? (f_result == "false"
                    ? WebView(
                        initialUrl: Common.ApiUrl + 'createFeedback/' + snapshot.data,
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (controller) {
                          webView = controller;
                        },
                      )
                    : Container(
                        padding: EdgeInsets.all(18),
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text(
                          "Congratulations, you have been credited 1 LIFE for your response! We appreciate your feedback in making OnzLAH! a better-gamified engagement platform. Stay tuned for another feedback form to get extra LIFE(s)!",
                          style: TextStyle(
                            fontFamily: 'MontserratRegular',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ))
                : Center(child: CircularProgressIndicator())),
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
            height: 14,
          ),
        ),
        Expanded(
          child: Text(
            "Share Feedback",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratBold',
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
