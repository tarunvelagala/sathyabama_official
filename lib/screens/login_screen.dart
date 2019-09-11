import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:sathyabama_official/screens/otp_screen.dart';
import 'package:sathyabama_official/services/crud.dart';
import 'package:connectivity/connectivity.dart';
import 'package:sathyabama_official/utils/otp_crud_utils.dart';
import 'package:sathyabama_official/utils/otp_utils.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _phnNumber, _randomOtp, finalUrl = '';
  RegExp _phnRegex = RegExp(r'^[6-9]\d{9}$');
  var result, response;
  CrudMethods crudObj = CrudMethods();
  OtpUtil otpUtil = OtpUtil();
  OtpCrud otpCrud = OtpCrud();

  final _phoneController = new TextEditingController();

  _phoneBtnClicked() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_phnNumber.length == 10) {
        _randomOtp = otpUtil.getRandomOtp();
        otpCrud.verifyPhoneNumberInDB(_phnNumber, _randomOtp);
        finalUrl = otpUtil.concatUrl(_phnNumber, _randomOtp);
        response = otpUtil.checkGetOtp(finalUrl);
        Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
                builder: (context) => OtpScreen(
                      phnNumber: _phnNumber,
                    )));
      }
    }
  }

  checkConnectivity() async {
    result = await Connectivity().checkConnectivity();
    return result;
  }

  @override
  void initState() {
    result = checkConnectivity();
    // _phoneController.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: new IconButton(
            onPressed: () {},
            icon: CircleAvatar(
              backgroundImage: AssetImage('images/Poster-Final.jpg'),
              backgroundColor: Colors.white,
            ),
            padding: EdgeInsets.only(left: 1.0, top: 2.0),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.redAccent[200],
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: 'Sathyabama',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(
                      text: '\nInstitute of Science and Technology',
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.normal))
                ]),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height > 800 ? 100.0 : 60,
                    ),
                    Container(
                      height: 100.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Log in",
                            style: TextStyle(fontSize: 30.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text("Login with your phone number",
                        style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                    SizedBox(
                      height: height > 800 ? 100.0 : 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: <Widget>[
                          /*Container(
                              padding: EdgeInsets.only(bottom: 10.0, right: 15.0),
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Phone Number",
                                style: TextStyle(color: Colors.grey),
                              )),*/
                          Theme(
                            child: TextFormField(
                              controller: _phoneController,
                              validator: (String val) {
                                if (val.isEmpty || val.length < 10) {
                                  return 'Please enter a valid phone number';
                                } else {
                                  if (!_phnRegex.hasMatch(val.toString())) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                }
                              },
                              onSaved: (phn) {
                                _phnNumber = phn;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                BlacklistingTextInputFormatter(
                                    new RegExp(r'[.,-\s]')),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              decoration: InputDecoration(
                                prefixIcon: Icon(LineAwesomeIcons.mobile_phone,
                                    size: 30.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelText: "Phone Number",
                                // hintText: "example@mail.com",
                              ),
                              // autofocus: true,
                            ),
                            data: Theme.of(context).copyWith(
                              primaryColor: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            height: 80.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              width: 400.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: FlatButton(
                                splashColor: Colors.transparent,
                                onPressed: () async {
                                  if (result == ConnectivityResult.none) {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Please check your internet connectivity"),
                                    ));
                                  } else {
                                    _phoneBtnClicked();
                                  }
                                },
                                child: Text(
                                  "Log in",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*
Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(36.0),
                  child: Form(
                    // autovalidate: _autoValidate,
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          // maxLength: 10,
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                          validator: (String val) {
                            if (val.isEmpty || val.length < 10) {
                              return 'Please enter a valid phone number';
                            } else {
                              if (!_phnRegex.hasMatch(val.toString())) {
                                return 'Please enter a valid phone number';
                              }
                              return null;
                            }
                          },
                          onSaved: (phn) {
                            _phnNumber = phn;
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            BlacklistingTextInputFormatter(
                                new RegExp(r'[.,-\s]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 1.5,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (result == ConnectivityResult.none) {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content:
                              Text("Please check your internet connectivity"),
                        ));
                      } else {
                        _phoneBtnClicked();
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
*/
