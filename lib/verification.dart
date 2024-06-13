import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/logout.dart';
import 'home.dart';

class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: getScreenHeight(context),
            decoration: new BoxDecoration(
              color: Common.AppColor,
            ),
            child: SafeArea(
              left: false,
              top: true,
              bottom: true,
              right: false,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 36,
                  right: 36,
                  top: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        BackNavigation(),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            "To finish creating your account, enter the 6-digit verification code that we have send to your email.",
                            style: TextStyle(
                              fontFamily: 'MontserratRegular',
                              fontSize: 18.0,
                              color: Common.pink_light_color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: getScreenHeight(context) - 200,
                      child: VerificationFrom(),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class BackNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // GestureDetector(
        //   onTap: () {
        //     showAlertDialog(context);
        //   },
        //   child: Image.asset('assets/icon/left-arrow.png'),
        // ),
        Expanded(
            child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 285),
          child: Text(
            "Email Verification",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 25.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        ))
      ],
    );
  }
}

class VerificationFrom extends StatefulWidget {
  @override
  VerificationFormState createState() {
    return VerificationFormState();
  }
}

class VerificationFormState extends State<VerificationFrom> {
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  TextEditingController fourthController = TextEditingController();
  TextEditingController fiveController = TextEditingController();
  TextEditingController sixController = TextEditingController();

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _handleVerification() async {
    setState(() {
      _isLoading = true;
    });

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);

    var data = {
      'userid': user['id'],
      'verification': firstController.text +
          secondController.text +
          thirdController.text +
          fourthController.text +
          fiveController.text +
          sixController.text,
    };

    var res = await CallApi().postData(data, 'verification');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }

    if (body['success'] == false) {
      final snackBar = SnackBar(content: Text(body['data']));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: firstController,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      // decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 23, bottom: 40),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: secondController,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 23, bottom: 40),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: InputBorder.none,
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: thirdController,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 23, bottom: 40),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: fourthController,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 23, bottom: 40),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: fiveController,
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(1),
                    ],
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25, bottom: 40),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Flexible(
                    flex: 1,
                    child: TextFormField(
                      controller: sixController,
                      inputFormatters: [
                        new LengthLimitingTextInputFormatter(1),
                      ],
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 25, bottom: 40),
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onEditingComplete: () => node.unfocus(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                    )),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!_isLoading) {
                setState(() {
                  _isLoading = true;
                });
                _handleVerification();
              }
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
                _isLoading ? "LOADING.." : "CONFIRM",
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
    );
  }
}

void showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    color: Common.AppColor,
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    color: Colors.black,
    child: Text("Continue"),
    onPressed: () {
      Logout().restart(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertMessage"),
    content: Text(
        "This action will cancel your registration process, you have to do verification before enter the app!"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
