import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onzlah_app/common/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/api.dart';
import 'common/logout.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => new _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final logout = Logout();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  bool _currentValidate = false, _newValidate = false, _confirmValidate = false;
  var _currentErrorText, _newErrorText, _confirmErrorText;

  String referral;

  @override
  void initState() {
    checkUser();

    super.initState();
  }

  void _handleForm() async {
    var data = {
      'current': currentController.text,
      'new': newController.text,
    };

    setState(() {
      currentController.text.isEmpty ? _currentValidate = true : _currentValidate = false;
      currentController.text.isEmpty
          ? _currentErrorText = "Empty Password"
          : _currentErrorText = "";
      newController.text.isEmpty ? _newValidate = true : _newValidate = false;
      newController.text.isEmpty ? _newErrorText = "Empty Password" : _newErrorText = "";
      confirmController.text.isEmpty ? _confirmValidate = true : _confirmValidate = false;
      confirmController.text.isEmpty
          ? _confirmErrorText = "Empty Password"
          : _confirmErrorText = "";

      if (newController.text != confirmController.text) {
        _newValidate = true;
        _newErrorText = "New Password is not same as Confirm Password";
        _confirmValidate = true;
        _confirmErrorText = "Confirm Password is not same as New Password";
      }

      if (_currentValidate != true && _newValidate != true && _confirmValidate != true) {
        _isLoading = true;
      }
    });

    if (_isLoading != false) {
      var res = await CallApi().postData(data, 'editPassword');
      var body = json.decode(res.body);

      if (body["success"] == true) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.clear();
        showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text("Success!"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('Password Updated Successfully, Please login again'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Yes'),
                onPressed: () {
                  logout.restart(context);
                },
              ),
            ],
          ),
        );

        currentController.clear();
        newController.clear();
        confirmController.clear();
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  checkUser() async {
    var data;
    var res = await CallApi().postData(data, 'getCurrentUser');
    var body = json.decode(res.body);

    if (body['message'] != null) {
      logout.run(context);
    }
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
        body: new SingleChildScrollView(
            child: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Common.profile_start_color,
            Common.profile_end_color,
          ])),
          height: getScreenHeight(context) - 70,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Current Password",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'MontserratBold',
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: currentController,
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                helperText: "Minimum 8 characters",
                                errorText: _currentValidate ? _currentErrorText : null,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "New Password",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'MontserratBold',
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: newController,
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                            decoration: InputDecoration(
                              helperText: "Minimum 8 characters",
                              errorText: _newValidate ? _newErrorText : null,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Confirm Password",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'MontserratBold',
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: confirmController,
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                              decoration: InputDecoration(
                                helperText: "Minimum 8 characters",
                                errorText: _confirmValidate ? _confirmErrorText : null,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    _isLoading ? null : _handleForm;
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
                    margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 50),
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      _isLoading ? "LOADING.." : "SUBMIT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'MontserratBold',
                        color: Common.AppColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )));
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
            "EDIT PASSWORD",
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
