import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'afterForgot.dart';
import 'common/api.dart';
import 'common/common.dart';

class ForgotUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotUser();
}

class _ForgotUser extends State<ForgotUser> {
  final dataKey = new GlobalKey();
  bool entered = true;

  @override
  void initState() {
    entered = true;

    KeyboardVisibilityController keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe
    keyboardVisibilityController.onChange.listen((bool visible) {
      if (visible && entered) Scrollable.ensureVisible(dataKey.currentContext);
    });

    super.initState();
  }

  @override
  void dispose() {
    entered = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          left: false,
          top: true,
          bottom: true,
          right: false,
          child: Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 30),
            decoration: new BoxDecoration(
              color: Common.AppColor,
            ),
            height: getScreenHeight(context),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BackNavigation(),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "Fill in your email address to recover your username or password.",
                          style: TextStyle(
                            fontFamily: 'NunitoSansSemiBold',
                            fontSize: 18.0,
                            color: Common.pink_light_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    height: getScreenHeight(context) - 150,
                    child: ForgotFrom(),
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
            "Forgot Username/Password",
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

class ForgotFrom extends StatefulWidget {
  @override
  ForgotFormState createState() {
    return ForgotFormState();
  }
}

class ForgotFormState extends State<ForgotFrom> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();

  bool _checked = false;
  bool _checked2 = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: 'MontserratBold',
                          fontWeight: FontWeight.w600),
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        height: 1.0,
                      ),
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        // hintText: "Enter your registered email",
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty || validateEmail(value)) {
                          return 'Valid Email Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.white,
                        ),
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            "Forgot Username",
                            style: TextStyle(
                                color: Common.pink_light_color,
                                fontSize: 16.0,
                                fontFamily: 'MontserratBold',
                                fontWeight: FontWeight.w600),
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
                    new Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          "Forgot Password",
                          style: TextStyle(
                              color: Common.pink_light_color,
                              fontSize: 16.0,
                              fontFamily: 'MontserratBold',
                              fontWeight: FontWeight.w600),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _checked2,
                        onChanged: (bool value) {
                          setState(() {
                            _checked2 = value;
                          });
                        },
                        checkColor: Color(0xff12FAA5),
                        activeColor: Colors.white,
                      ),
                    ),
                  ],
                )),
            GestureDetector(
              onTap: () {
                if (!_isLoading && _formKey.currentState.validate()) {
                  setState(() {
                    _isLoading = true;
                  });
                  sendResetPasswordLink(emailController.text);
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
        ));
  }

  sendResetPasswordLink(String email) async {
    var data = {
      'email': email,
    };
    var res = await CallApi().postData(data, 'forgotPassword');
    var body = json.decode(res.body);
    setState(() {
      _isLoading = false;
    });
    if (body["success"] == true) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AfterForgotUser()));
    } else {
      showMsg("Email not found");
    }
  }
}
