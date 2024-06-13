import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/landing.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';

class Logout {
  void restart(BuildContext context) async {
    await FirebaseMessaging.instance.deleteToken();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (c) => Landing()), (route) => false);
  }

  void run(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Session timeout'),
          content: new SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Please login again'),
              ],
            ),
          ),
          actions: [
            FlatButton(
              color: Common.AppColor,
              child: Text('Yes'),
              onPressed: () {
                restart(context);
              },
            ),
          ],
        );
      },
    );
  }
}
