import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:onzlah_app/verification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'forgotUser.dart';
import 'home.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: new BoxDecoration(
            color: Common.AppColor,
          ),
          height: getScreenHeight(context),
          child: SafeArea(
            left: false,
            top: true,
            bottom: true,
            right: false,
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackNavigation(),
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    height: getScreenHeight(context) - 100,
                    child: LoginFrom(),
                  )
                ],
              ),
            ),
          ),
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
            height: 20,
          ),
        ),
        Expanded(
          child: Text(
            "Log In",
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

class LoginFrom extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginFrom> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  var _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    String fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm_token=>' + fcmToken);
    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
      'fcm_token': fcmToken,
    };
    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body["token"]);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }

    if (body['success'] == false) {
      if (body['redirect'] == "verification") {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
      }

      if (body['redirect'] == "login") {
        final snackBar = SnackBar(content: Text(body['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'MontserratBold',
                        ),
                      ),
                      TextFormField(
                        controller: usernameController,
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                        decoration: InputDecoration(
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
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
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Password Required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotUser()));
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
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState.validate()) {
                if (!_isLoading) _handleLogin();
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
                _isLoading ? "LOADING.." : "LET'S GO!",
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
