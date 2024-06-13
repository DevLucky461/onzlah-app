import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Common {
  static const int Share = 0;
  static const int Gift = 1;
  static const int Setting = 2;

  static const Color AppColor = Color(0xff88119B);

  static const Color orange_color = Color(0xFFFEB732);

  static const Color pink_light_color = Color(0xFFE38FE7);

  static const Color pink_dark_color = Color(0xFF88119B);

  static const Color profile_start_color = Color(0xFFDCE6FD);

  static const Color profile_end_color = Color(0xFFFDC9C4);

  static const Color green_blue_color = Color(0xFF218E8A);

  // static const String VideoLink = "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8";
  static const String VideoLink = "https://livestream.cakexp.com/hls/onzlah.m3u8";

  // static const String BaseUrl = "http://192.168.108.173:8000/";
  static const String BaseUrl = "https://onzlah.live/";
  static const String ApiUrl = BaseUrl + "api/";

  // static const String socketUrl = "https://onzlah-socket.nekopaw.net";
  static const String socketUrl = "https://epic-test-socket.nekopaw.dev";
  // static const String socketUrl = "http://192.168.108.173:3100";

  static bool liveEnabled = false;
}

bool validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  return (!regex.hasMatch(value)) ? true : false;
}

getColor(int i, int lifeCount) {
  if (lifeCount != 0) {
    switch (lifeCount) {
      case 3:
        if (i + 1 <= 3)
          return Colors.white;
        else
          return Color(0xFFFDA6BD);
        break;

      case 2:
        if (i + 1 <= 2)
          return Colors.white;
        else
          return Color(0xffFF7E9F);
        break;

      case 1:
        if (i + 1 <= 1)
          return Colors.white;
        else
          return Color(0xffFF3E6F);
        break;
    }
  } else {
    switch (i) {
      case 2:
        return Color(0xffFF3E6F);
        break;

      case 1:
        return Color(0xffFF7E9F);
        break;

      case 0:
        return Color(0xFFFDA6BD);
        break;
    }
  }
}

void showMsg(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0);
}

String numberFormatter(number) {
  var formatter = NumberFormat('###,###,###,###');
  return formatter.format(number);
}

String getDate(String time) {
  if (time == null || time == '') {
    return "";
  }
  DateTime dateTime = DateTime.parse(time);

  return DateFormat('dd/MMM/yyyy').format(dateTime);
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
