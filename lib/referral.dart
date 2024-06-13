import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onzlah_app/common/common.dart';

import 'common/api.dart';
import 'common/logout.dart';

class Referral extends StatefulWidget {
  @override
  _ReferralState createState() => new _ReferralState();
}

class _ReferralState extends State<Referral> {
  final logout = Logout();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String referral;

  @override
  void initState() {
    getReferral();

    super.initState();
  }

  getReferral() async {
    var data;
    var res = await CallApi().postData(data, 'viewReferral');
    var body = json.decode(res.body);

    if (!mounted) return;
    if (body['message'] != null) {
      logout.run(context);
    } else {
      setState(() {
        referral = body['referral_code'];
      });
    }
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text(referral + ' : Copied to clipboard!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            gradient:
                LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          Common.profile_start_color,
          Common.profile_end_color,
        ])),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "You can introduce your friends and families about this app, and let them register their account using your referral codes.",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'MontserratRegular',
                  color: Colors.black,
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    // text: "One successful registrant will rewards you get 1 FREE",
                    text: "You'll be rewarded with 1 FREE",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'MontserratRegular',
                      color: Colors.black,
                    ),
                  ),
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Image.asset(
                        'assets/img/lifes.png',
                        width: 16,
                        height: 16,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: "for every successful registrant! No limitation!",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'MontserratRegular',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    referral == "" || referral == null ? "No Referral Code" : referral,
                    style: TextStyle(
                      fontFamily: 'MontserratRegular',
                      fontSize: 16,
                    ),
                  ),
                  //new Spacer(flex: 1,),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(
                          text:
                              referral == "" || referral == null ? "No Referral Code" : referral));

                      _displaySnackBar(context);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Common.orange_color,
                              Common.pink_light_color,
                            ]),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "COPY",
                        style: TextStyle(
                          color: Common.pink_dark_color,
                          fontFamily: 'MontserratBold',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            "My Referral Code",
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
