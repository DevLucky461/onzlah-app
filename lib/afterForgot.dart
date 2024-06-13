import 'package:flutter/material.dart';

import 'common/common.dart';
import 'landing.dart';
import 'login.dart';

class AfterForgotUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30, top: 30),
        decoration: new BoxDecoration(
          color: Common.AppColor,
        ),
        height: getScreenHeight(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BackNavigation(),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "You will receive the recovery email within a few minutes. If you have not received an email check your spam folder or contact our team.",
                    style: TextStyle(
                      fontFamily: 'NunitoSansSemiBold',
                      fontSize: 18.0,
                      color: Common.pink_light_color,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (c) => Landing()), (route) => false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
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
                    "BACK TO LOGIN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'MontserratBold',
                      color: Common.AppColor,
                    ),
                  ),
                ),
              ),
            )
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
