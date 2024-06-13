import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/api.dart';
import 'common/common.dart';

class BeOurPartner extends StatefulWidget {
  @override
  _BeOurPartnerState createState() => new _BeOurPartnerState();
}

class _BeOurPartnerState extends State<BeOurPartner> {
  TextEditingController companyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _nameValidate = false,
      _companyValidate = false,
      _positionValidate = false,
      _contactValidate = false,
      _emailValidate = false;

  var _isLoading = false;

  void _handleForm() async {
    var data = {
      'username': companyController.text,
      'password': nameController.text,
      'email': positionController.text,
      'phone': contactController.text,
      'referral': emailController.text,
    };

    setState(() {
      nameController.text.isEmpty ? _nameValidate = true : _nameValidate = false;
      companyController.text.isEmpty ? _companyValidate = true : _companyValidate = false;
      positionController.text.isEmpty ? _positionValidate = true : _positionValidate = false;
      contactController.text.isEmpty ? _contactValidate = true : _contactValidate = false;
      emailController.text.isEmpty || validateEmail(emailController.text)
          ? _emailValidate = true
          : _emailValidate = false;

      if (_nameValidate != true &&
          _companyValidate != true &&
          _positionValidate != true &&
          _contactValidate != true &&
          _emailValidate != true) {
        _isLoading = true;
      }
    });

    if (_isLoading != false) {
      var res = await CallApi().postData(data, 'becomepartner');
      var body = json.decode(res.body);

      if (body["success"] == true) {
        showDialog(
          context: context,
          builder: (context) => ShowDialog(),
        );

        nameController.clear();
        companyController.clear();
        positionController.clear();
        contactController.clear();
        emailController.clear();
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.all(20),
          height: getScreenHeight(context) - 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Common.profile_start_color, Common.profile_end_color],
            ),
          ),
          child: SafeArea(
            top: true,
            bottom: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 20, top: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      errorText: _nameValidate ? "Invalid name" : null,
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
                                  "Company",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'MontserratBold',
                                  ),
                                ),
                                TextFormField(
                                  controller: companyController,
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    errorText: _companyValidate ? "Invalid Company" : null,
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
                                    "Position",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: positionController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      errorText: _positionValidate ? "Invalid Position" : null,
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
                                    "Contact Number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: contactController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      errorText: _contactValidate ? "Invalid Contact" : null,
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
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      errorText: _emailValidate ? "Invalid Email" : null,
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
                          margin: const EdgeInsets.only(left: 15.0, right: 15, bottom: 20, top: 30),
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
              ],
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
            height: 14,
          ),
        ),
        Expanded(
          child: Text(
            "Be Our Partner",
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

class ShowDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text("Partner Saved"),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('We will get back to you as soon as possible! Stay tune..'),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text('Yes'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
