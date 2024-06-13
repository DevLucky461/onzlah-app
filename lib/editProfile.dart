import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'common/api.dart';
import 'common/common.dart';
import 'common/imagepicker.dart';
import 'common/logout.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => new _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin, ImagePickerListener {
  final logout = Logout();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;

  //question 1 Controller
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  String imageUrl = "";

  bool _nameValidate = false,
      _emailValidate = false,
      _phoneValidate = false,
      _addressValidate = false;

  //_currentStateValidate = false;

  var _nameErrorText, _emailErrorText, _phoneErrorText, _addressErrorText;

  File _image;
  ImagePickerHandler imagePicker;
  AnimationController _controller;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();

    checkUser();

    super.initState();
  }

  void _handleForm() async {
    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
    };

    setState(() {
      nameController.text.isEmpty ? _nameValidate = true : _nameValidate = false;
      nameController.text.isEmpty ? _nameErrorText = "Empty Name" : _nameErrorText = "";
      emailController.text.isEmpty || validateEmail(emailController.text)
          ? _emailValidate = true
          : _emailValidate = false;
      emailController.text.isEmpty ? _emailErrorText = "Empty Email" : _emailErrorText = "";
      phoneController.text.isEmpty ? _phoneValidate = true : _phoneValidate = false;
      phoneController.text.isEmpty ? _phoneErrorText = "Empty Password" : _phoneErrorText = "";
      addressController.text.isEmpty ? _addressValidate = true : _addressValidate = false;
      addressController.text.isEmpty ? _addressErrorText = "Empty Address" : _addressErrorText = "";

      if (_nameValidate != true && _emailValidate != true && _phoneValidate != true) {
        _isLoading = true;
      }
    });

    if (_isLoading != false) {
      var res = _image == null
          ? await CallApi().postData(data, 'editUserData')
          : await CallApi().multipartPostData(data, _image, 'editUserData');
      var body = json.decode(res.body);

      if (body["status"] == 'success') {
        final snackBar = SnackBar(content: Text(body['message']));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    } else {
      setState(() {
        nameController.text = body['user']['name'].toString();
        emailController.text = body['user']['email'].toString();
        phoneController.text = body['user']['phonenumber'].toString();
        addressController.text = body['user']['address'].toString();
        fullnameController.text = body['user']['fullname'].toString();
        imageUrl = body['user']['picture'].toString();
      });
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
                height: fullnameController.text != null
                    ? getScreenHeight(context) - 10
                    : getScreenHeight(context),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Common.profile_start_color,
                    Common.profile_end_color,
                  ],
                )),
                child: Column(
                  children: [
                    new Form(
                        key: _formKey,
                        child: Column(children: [
                          InkWell(
                            onTap: () {
                              imagePicker.showDialog(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              width: 100,
                              height: 100,
                              child: Stack(alignment: Alignment.center, children: <Widget>[
                                _image == null
                                    ? Image.network(
                                        Common.BaseUrl + imageUrl,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        height: 100,
                                        loadingBuilder: (context, child, loadingProgress) =>
                                            (loadingProgress == null)
                                                ? child
                                                : Center(child: CircularProgressIndicator()),
                                        errorBuilder: (context, error, stackTrace) => Image.asset(
                                          'assets/img/profile-icon-unlit.png',
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      )
                                    : Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                Text("Change picture"),
                              ]),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     imagePicker.showDialog(context);
                          //   },
                          //   child: Container(
                          //     margin: EdgeInsets.only(top: 30),
                          //     decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
                          //     width: 100,
                          //     height: 100,
                          //     child: _image == null
                          //         ? Image.network(
                          //             Common.BaseUrl + imageUrl,
                          //             fit: BoxFit.cover,
                          //             loadingBuilder: (context, child, loadingProgress) =>
                          //                 (loadingProgress == null)
                          //                     ? child
                          //                     : Center(child: CircularProgressIndicator()),
                          //             errorBuilder: (context, error, stackTrace) => Image.asset(
                          //               'assets/img/profile-icon-unlit.png',
                          //               fit: BoxFit.cover,
                          //             ),
                          //           )
                          //         : Image.file(
                          //             _image,
                          //             fit: BoxFit.cover,
                          //           ),
                          //   ),
                          // ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login Username",
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
                                      errorText: _nameValidate ? _nameErrorText : null,
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
                            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email address",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'MontserratBold',
                                  ),
                                ),
                                TextFormField(
                                  controller: emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.none,
                                  ),
                                  decoration: InputDecoration(
                                    errorText: _emailValidate ? _emailErrorText : null,
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
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone Number",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      errorText: _phoneValidate ? _phoneErrorText : null,
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
                              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Address",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'MontserratBold',
                                    ),
                                  ),
                                  TextFormField(
                                    controller: addressController,
                                    style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                    ),
                                    decoration: InputDecoration(
                                      errorText: _addressValidate ? _addressErrorText : null,
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
                              margin: const EdgeInsets.only(left: 50.0, right: 50, bottom: 50),
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                _isLoading ? "LOADING.." : "SAVE PROFILE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'MontserratBold',
                                  color: Common.AppColor,
                                ),
                              ),
                            ),
                          ),
                        ])),
                    // Divider(
                    //   color: Color(0xffEAEAEA),
                    //   thickness: 10,
                    // ),
                    Container(
                      child: fullnameController.text != null ? Container() : SecondForm(),
                    )
                    // Container(
                    //   child: SecondForm(),
                    // )
                  ],
                ))));
  }

  @override
  userImage(File _image) {
    if (_image != null) {
      print(_image.path);
      setState(() {
        this._image = _image;
      });
    }
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
            "Edit Profile",
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

class SecondForm extends StatefulWidget {
  @override
  _SecondFormState createState() => new _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  final _formKey2 = GlobalKey<FormState>();

  var _fullnameErrorText,
      _datePickerErrorText,
      _stateErrorText = "",
      _cityErrorText = "",
      _genderErrorText = "";

  bool _fullnameValidate = false,
      _datePickerValidate = false,
      _stateValidate = false,
      _cityValidate = false,
      _genderValidate = false;

  String _disableStateText = "";

  //question 2 Controller
  TextEditingController datePickerController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController currentStateController = TextEditingController();

  String stateDropdownValueController = 'Pick a State';
  String cityDropdownValueController = 'Pick a City';
  String genderDropdownValueController = 'Pick a Gender';

  var _isLoading2 = false;

  parseDateTime(dateTime) {
    //var parsedDate = DateTime.parse(dateTime);
    var myFormat = DateFormat('yyyy-MM-dd');
    return myFormat.format(dateTime);
  }

  bool isEnableStateDropDown = true, isEnableCityDropDown = false;

  List<String> city = [
    'Pick a City',
  ];

  List<String> gender = ['Pick a Gender', 'Male', 'Female'];

  setStateDropdownBorderColour() {
    if (isEnableStateDropDown == false) {
      return Colors.grey;
    } else if (_stateValidate == true) {
      return Colors.red;
    } else if (_stateValidate == false) {
      return Colors.black;
    }
  }

  setCityDropdownBorderColour() {
    if (isEnableCityDropDown == false) {
      return Colors.grey;
    } else if (_cityValidate == true) {
      return Colors.red;
    } else if (_cityValidate == false) {
      return Colors.black;
    }
  }

  var selangor = [
    "Pick a City",
    "Gombak",
    "Hulu Langat",
    "Hulu Selangor",
    "Klang",
    "Kuala Langat",
    "Kuala Selangor",
    "Petaling Jaya",
    "Sabak Bernam",
    "Sepang"
  ];
  var kedah = [
    "Pick a City",
    "Baling",
    "Bandar Baharu",
    "Kota Setar",
    "Kuala Muda",
    "Kubang Pasu",
    "Kulim",
    "Pulau Langkawi ",
    "Padang Terap",
    "Pendang",
    "Pokok Sena",
    "Sik",
    "Yan"
  ];
  var melaka = [
    "Pick a City",
    "Tangga Batu",
    "Hang Tuah Jaya",
    "Kota Melaka",
    "Sungai Udang",
    "Pantai Kundor",
    "Paya Rumput",
    "Klebang",
    "Pengkalan Batu",
    "Ayer Keroh",
    "Bukit Katil",
    "Ayer Molek",
    "Kesidang",
    "Kota Laksamana",
    "Duyong",
    "Bandar Hilir",
    "Telok Mas"
  ];
  var johor = [
    "Pick a City",
    "Batu Pahat",
    "Johor Bahru",
    "Kluang",
    "Kota Tinggi",
    "Kulai",
    "Mersing",
    "Muar",
    "Pontian Kechil",
    "Segamat",
    "Tangkak"
  ];
  var pahang = [
    "Pick a City",
    "Bera",
    "Bentong",
    "Cameron Highlands",
    "Jerantut",
    "Kuantan",
    "Lipis",
    "Maran",
    "Pekan",
    "Raub",
    "Rompin",
    "Temerloh"
  ];
  var terengganu = [
    "Pick a City",
    "Besut",
    "Setiu",
    "Dungun",
    "Hulu Terengganu",
    "Marang",
    "Kemaman",
    "Kuala Terengganu",
    "Kuala Nerus"
  ];
  var perak = [
    "Pick a City",
    "Batang Padang",
    "Manjung",
    "Kinta",
    "Kerian",
    "Kuala Kangsar",
    "Laut",
    "Hilir Perak",
    "Hulu Perak",
    "Selama",
    "Perak Tengah",
    "Kampar",
    "Muallim",
    "Bagan Datuk"
  ];
  var perlis = [
    "Pick a City",
    "Arau",
    "Chuping",
    "Kaki Bukit",
    "Kuala Perlis",
    "Sanglang",
    "Padang Besar"
  ];
  var sabah = [
    "Pick a City",
    "Kota Belud",
    "Kota Kinabalu",
    "Papar",
    "penampang",
    "Putatan",
    "Ranau",
    "Tuaran",
    "Beaufort",
    "Nabawan",
    "Keninggau",
    "Kuala Penyu",
    "Sipitang",
    "Tambunan",
    "Tenom",
    "Kota Marudu",
    "Kudat",
    "Pitas",
    "Beluran",
    "Kinabatangan",
    "Sandakan",
    "Telupid",
    'Tongod',
    "Kunak",
    "Lahad Datu",
    "Semporna",
    "Tawau"
  ];
  var sarawak = [
    "Pick a City",
    "Kuching",
    "Sri Aman",
    "Sibu",
    "Miri",
    "Limbang",
    "Sarikei",
    "Kapit",
    "Samarahan",
    "Bintulu",
    "Betong",
    "Mukah",
    "Serian"
  ];
  var n9 = [
    "Pick a City",
    "Seremban",
    "Port Dickson",
    "Rembau",
    "Jelebu",
    "Kuala Pilah",
    "Jempol",
    "Tampin"
  ];
  var penang = [
    "Pick a City",
    "Bukit Mertajam",
    "Seberang Perai",
    "Balik Pulau",
    "Bayan Lepas",
    "Butterworth",
    "Jelutong",
    "Kepala Batas",
    "Perai",
    'Pematang Pauh',
    "Teluk Bahang"
  ];
  var kelantan = [
    "Pick a City",
    "Bachok",
    "Gua Musang",
    "Jeli",
    "Kota Bharu",
    "Kuala Krai",
    "Machang",
    "Pasir Mas",
    "Pasir Putih",
    "Tanah Merah",
    "Tumpat"
  ];
  var kualalumpur = [
    "Pick a City",
    "Bukit Bintang",
    "Titiwangsa",
    "Setiawangsa",
    "Wangsa Maju",
    "Kepong"
  ];

  List<String> state = [
    'Pick a State',
    'Johor',
    'Kedah',
    'Kelantan',
    'Kuala Lumpur',
    'Malacca',
    'Negeri Sembilan',
    'Pahang',
    'Perak',
    'Perlis',
    'Penang',
    'Sabah',
    'Sarawak',
    'Selangor',
    'Terengganu'
  ];

  setStateDropDown(city) {
    if (city == "Pick a City") {
      setState(() {
        isEnableStateDropDown = true;
      });
    }
  }

  changeCity(state) {
    //city.removeWhere((item) => item != 'Pick a City');
    //cityDropdownValueController = "";
    //city = null;

    if (state != 'Pick a State') {
      setState(() {
        isEnableStateDropDown = false;
        isEnableCityDropDown = true;
        _disableStateText = state;
      });
    }

    switch (state) {
      case "Johor":
        city = johor;
        break;
      case "Kedah":
        city = kedah;
        break;
      case "Kelantan":
        city = kelantan;
        break;
      case "Kuala Lumpur":
        city = kualalumpur;
        break;
      case "Malacca":
        city = melaka;
        break;
      case "Negeri Sembilan":
        city = n9;
        break;
      case "Pahang":
        city = pahang;
        break;
      case "Perak":
        city = perak;
        break;
      case "Perlis":
        city = perlis;
        break;
      case "Penang":
        city = penang;
        break;
      case "Sabah":
        city = sabah;
        break;
      case "Sarawak":
        city = sarawak;
        break;
      case "Selangor":
        city = selangor;
        break;
      case "Terengganu":
        city = terengganu;
        break;
    }
  }

  void _handleForm2() async {
    setState(() {
      fullnameController.text.isEmpty ? _fullnameValidate = true : _fullnameValidate = false;

      if (fullnameController.text.isEmpty) _fullnameErrorText = "Empty FullName";

      datePickerController.text.isEmpty ? _datePickerValidate = true : _datePickerValidate = false;

      if (datePickerController.text.isEmpty) _datePickerErrorText = "Empty Birthday Date";

      stateDropdownValueController != "Pick a State"
          ? _stateErrorText = ""
          : _stateErrorText = "Pick a State";

      stateDropdownValueController == "Pick a State"
          ? _stateValidate = true
          : _stateValidate = false;

      cityDropdownValueController == "Pick a City"
          ? _cityErrorText = "Pick a City"
          : _cityErrorText = "";

      cityDropdownValueController == "Pick a City" ? _cityValidate = true : _cityValidate = false;

      genderDropdownValueController == "Pick a Gender"
          ? _genderErrorText = "Pick a Gender"
          : _genderErrorText = "";

      genderDropdownValueController == "Pick a Gender"
          ? _genderValidate = true
          : _genderValidate = false;

      if (_fullnameValidate != true &&
          stateDropdownValueController != "Pick a State" &&
          cityDropdownValueController != "Pick a City" &&
          genderDropdownValueController != "Pick a Gender") {
        _isLoading2 = true;
      }
    });

    if (_isLoading2 != false) {
      var data = {
        'fullname': fullnameController.text,
        'birthday': datePickerController.text,
        'state': stateDropdownValueController,
        'city': cityDropdownValueController,
        'gender': genderDropdownValueController,
      };

      var res = await CallApi().postData(data, 'editUserData2');
      var body = json.decode(res.body);

      if (body["success"] == true) {
        fullnameController.clear();
        datePickerController.clear();

        setState(() {
          _isLoading2 = false;
          fullnameController.text = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Form(
        key: _formKey2,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: fullnameController,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        errorText: _fullnameValidate ? _fullnameErrorText : null,
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
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "When is your birthday?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    TextFormField(
                      controller: datePickerController,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        hintText: 'YYY-MM-DD',
                        filled: true,
                        fillColor: Colors.white,
                        errorText: _datePickerValidate ? _datePickerErrorText : null,
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
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019, 1),
                            lastDate: DateTime(2100),
                            builder: (BuildContext context, Widget picker) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  colorScheme: ColorScheme.highContrastLight(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    surface: Colors.pink,
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: picker,
                              );
                            }).then((selectedDate) {
                          if (selectedDate != null) {
                            datePickerController.text = parseDateTime(selectedDate);
                          }
                        });
                      },
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Current State",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1.0)),
                      width: double.infinity,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: stateDropdownValueController,
                          icon: Icon(Icons.expand_more),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            //color: Colors.black,
                          ),
                          disabledHint: Text(_disableStateText != null ? _disableStateText : ""),
                          onChanged: isEnableStateDropDown
                              ? (value) {
                                  setState(() {
                                    stateDropdownValueController = value;
                                    changeCity(value);
                                  });
                                }
                              : null,
                          items: state.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_stateValidate ? 10 : 0),
                      child: Text(
                        _stateValidate ? _stateErrorText : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.0,
                            fontFamily: 'MontserratBold',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Current City",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: setCityDropdownBorderColour())),
                      width: double.infinity,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: cityDropdownValueController,
                          icon: Icon(Icons.expand_more),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          disabledHint: Text("Please Pick a State first"),
                          underline: Container(
                            height: 2,
                            //color: Colors.black,
                          ),
                          onChanged: isEnableCityDropDown
                              ? (value) {
                                  setState(() {
                                    cityDropdownValueController = value;
                                    setStateDropDown(value);
                                  });
                                }
                              : null,
                          items: city.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_cityValidate ? 10 : 0),
                      child: Text(
                        _cityValidate ? _cityErrorText : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.0,
                            fontFamily: 'MontserratBold',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Current Gender",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: 'MontserratBold',
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              width: 1, color: _genderValidate ? Colors.red : Colors.black)),
                      width: double.infinity,
                      child: DropdownButton<String>(
                          isExpanded: true,
                          value: genderDropdownValueController,
                          icon: Icon(Icons.expand_more),
                          iconEnabledColor: Colors.black,
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            //color: Colors.black,
                          ),
                          onChanged: (String value) {
                            setState(() {
                              genderDropdownValueController = value;
                            });
                          },
                          items: gender.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList()),
                    ),
                    Padding(
                      padding: EdgeInsets.all(_genderValidate ? 10 : 0),
                      child: Text(
                        _genderValidate ? _genderErrorText : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 13.0,
                            fontFamily: 'MontserratBold',
                            fontWeight: FontWeight.w900),
                      ),
                    )
                  ],
                )),
            GestureDetector(
              onTap: () {
                _isLoading2 ? null : _handleForm2;
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
                margin: const EdgeInsets.only(left: 50.0, right: 50, bottom: 50),
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  _isLoading2 ? "LOADING.." : "SUBMIT",
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
