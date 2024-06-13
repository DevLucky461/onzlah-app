import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onzlah_app/howtoplay.dart';
import 'package:onzlah_app/register.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';
import 'forgotUser.dart';
import 'home.dart';
import 'login.dart';

class Landing extends StatefulWidget {
  @override
  LandingState createState() {
    return LandingState();
  }
}

class LandingState extends State<Landing> {
  final logout = Logout();
  bool _loggedIn = false;
  bool _loaded = false;

  @override
  initState() {
    super.initState();

    _loaded = false;
    _loggedIn = false;
    _checkIfLoggedIn();
  }

  _checkIfLoggedIn() async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null || body['user'] == null) {
      setState(() {
        _loggedIn = false;
        _loaded = true;
      });
    } else if (body['message'] == null) {
      setState(() {
        _loggedIn = true;
        _loaded = true;
      });
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure you want to quit?'),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Common.AppColor,
              ),
              child: Text('Quit'),
              onPressed: () => exit(0),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Colors.black,
              ),
              child: Text('No'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      child: Scaffold(
        body: _loggedIn ? Home() : ViewLanding(loaded: _loaded),
      ),
    );
  }
}

class ViewLanding extends StatelessWidget {
  final bool loaded;

  const ViewLanding({Key key, this.loaded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Common.AppColor,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 150),
            width: double.infinity,
            child: Image.asset('assets/img/onzlah-logo.png'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70),
            width: double.infinity,
            child: Image.asset('assets/img/tagline.png'),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loaded
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [Common.orange_color, Common.pink_light_color]),
                          ),
                          margin: const EdgeInsets.only(left: 40.0, right: 40),
                          padding: const EdgeInsets.all(15.0),
                          child: const Text(
                            'SIGN UP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'MontserratBold',
                              color: Common.AppColor,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                loaded
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.only(top: 10, left: 40.0, right: 40),
                          padding: const EdgeInsets.all(15.0),
                          child: const Text(
                            'LOG IN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                loaded
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ForgotUser()));
                        },
                        child: Container(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Forgot Username/Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w100,
                              decoration: TextDecoration.none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                loaded
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Howtoplay()));
                        },
                        child: Container(
                          padding: new EdgeInsets.only(top: 150.0),
                          child: Text(
                            "How to Play?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w200,
                              decoration: TextDecoration.underline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
