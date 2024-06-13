import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onzlah_app/termsCondition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'verification.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          color: Common.AppColor,
        ),
        child: SingleChildScrollView(
            child: SafeArea(
          left: false,
          top: true,
          bottom: true,
          right: false,
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                BackNavigation(),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: RegisterFrom(),
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
            "Sign Up",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'MontserratExtraBold',
              fontSize: 18.0,
              decoration: TextDecoration.none,
              color: Common.orange_color,
            ),
          ),
        )
      ],
    );
  }
}

class RegisterFrom extends StatefulWidget {
  @override
  RegisterFromState createState() {
    return RegisterFromState();
  }
}

class RegisterFromState extends State<RegisterFrom> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _checked = false;

  void _handleRegister() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'username': usernameController.text,
      'password': passwordController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'referral': referralController.text
    };

    var res = await CallApi().postData(data, 'register');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body["token"]);
      localStorage.setString('user', json.encode(body['user']));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Verification()));
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
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Username",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: usernameController,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        height: 0.6,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          backgroundColor: Colors.red,
                          fontFamily: 'MontserratRegular',
                        ),
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
                          return 'Only alphabets, numbers and underscore are allowed.';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login Password (min, 8 characters)",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'MontserratBold',
                    ),
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      height: 0.6,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                        fontFamily: 'MontserratRegular',
                      ),
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
                        return 'Password is required.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'MontserratBold',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      height: 0.6,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(
                        fontSize: 11.0,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                        fontFamily: 'MontserratRegular',
                      ),
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
                      if (value.isEmpty || validateEmail(value)) {
                        return 'Valid Email Required';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Phone number",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        height: 0.6,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          backgroundColor: Colors.red,
                          fontFamily: 'MontserratRegular',
                        ),
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
                          return 'Valid phone number Required';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Referral Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: referralController,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        height: 0.6,
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
                    ),
                  ],
                )),
            new Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: Colors.white,
                ),
                child: CheckboxListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: RichText(
                    text: TextSpan(
                      // style: defaultStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I have read and agree the ',
                          style: TextStyle(
                            color: Common.pink_light_color,
                            fontSize: 15,
                            fontFamily: 'MontserratRegular',
                          ),
                        ),
                        TextSpan(
                            text: 'Terms & Conditions and Privacy Policy.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontFamily: 'MontserratBold',
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => TermsConditions()));
                              }),
                      ],
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: _checked,
                  onChanged: (bool value) {
                    setState(() {
                      _checked = value;
                    });
                  },
                  checkColor: Color(0xff12FAA5),
                  activeColor: Colors.white,
                )),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                if (!_isLoading && _checked && _formKey.currentState.validate()) _handleRegister();
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
                  _isLoading ? "CREATING" : "SUBMIT",
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
    );
  }
}
