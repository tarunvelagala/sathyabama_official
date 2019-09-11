import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:sathyabama_official/screens/circulars.dart';
import 'package:http/http.dart' as http;
import '../services/shared_prefs_service.dart';

class StaffCirculars extends StatefulWidget {
  @override
  _StaffCircularsState createState() => _StaffCircularsState();
}

class _StaffCircularsState extends State<StaffCirculars> {
  RegExp _emailRegex = RegExp(r'\w@sathyabama.ac.in');
  var email, attendanceId;
  SharedPrefs sharedPrefs = SharedPrefs();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<String> verifyStaff() async {
    final response = await http.get(
        'http://cloudportal.sathyabama.ac.in/mobileappsms/api/staff_verify.php?email=' +
            email +
            '&attendance_id=' +
            attendanceId);
    var jsonData = json.decode(response.body);
    return jsonData['verify'];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
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
              key: _formkey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height > 800 ? 60.0 : 30.0,
                  ),
                  Container(
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Staff Log in",
                          style: TextStyle(fontSize: 30.0),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                  Text("Login with Email and \n  Attendance Id",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                  SizedBox(
                    height: height > 800 ? 100.0 : 40.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Theme(
                          child: TextFormField(
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter a valid Email Id';
                              } else {
                                if (!_emailRegex.hasMatch(val)) {
                                  return 'Please enter a valid mail';
                                }
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(LineAwesomeIcons.envelope),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelText: 'Email Id'),
                          ),
                          data: Theme.of(context).copyWith(
                            primaryColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Theme(
                          child: TextFormField(
                            maxLength: 4,
                            inputFormatters: [
                              BlacklistingTextInputFormatter(
                                  new RegExp(r'[.,-\s]')),
                              LengthLimitingTextInputFormatter(6),
                            ],
                            validator: (val) {
                              if (val.isEmpty) {
                                return 'Please enter a valid Attendance ID';
                              }
                              return null;
                            },
                            onSaved: (String val) {
                              attendanceId = val;
                            },
                            style: TextStyle(fontSize: 15.0),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: Icon(LineAwesomeIcons.key),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                labelText: 'Attendance ID'),
                          ),
                          data: Theme.of(context).copyWith(
                            primaryColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: height > 800 ? 80.0 : 40.0,
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
                                if (_formkey.currentState.validate()) {
                                  _formkey.currentState.save();
                                  if (await verifyStaff() == 'OK') {
                                    sharedPrefs.updateSharedPrefsStaff();
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                Circulars(
                                                  isStaff: "0",
                                                )));
                                  } else {
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content:
                                          Text('Please enter valid details'),
                                    ));
                                  }
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
