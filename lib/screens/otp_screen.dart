import 'dart:async';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:quiver/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sathyabama_official/services/crud.dart';
import 'package:sathyabama_official/services/shared_prefs_service.dart';
import 'package:sathyabama_official/utils/otp_crud_utils.dart';
import 'package:sathyabama_official/utils/otp_utils.dart';

class OtpScreen extends StatefulWidget {
  final String phnNumber;
  OtpScreen({Key key, this.phnNumber}) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();
  String otpFinal, _randomOtp, finalUrl = '';
  var user, response;
  bool hasError = false;
  OtpUtil otpUtil = OtpUtil();
  OtpCrud otpCrud = OtpCrud();
  CrudMethods crudObj = CrudMethods();
  SharedPrefs sharedPrefs = SharedPrefs();
  int _start = 30;
  int _current = 30;
  final _otpController = TextEditingController();
  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      if (this.mounted) {
        setState(() {
          _current = _start - duration.elapsed.inSeconds;
        });
      }
    });

    sub.onDone(() {
      print("Done");
      _current = _start;
      sub.cancel();
    });
  }

/*
  /// Control the input text field.
  PinEditingController _pinEditingController =
      PinEditingController(pinLength: 6, autoDispose: false);

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration = UnderlineDecoration(
    textStyle: TextStyle(fontSize: 20.0, color: Colors.blue),
    enteredColor: Colors.deepOrange,
  );*/
  /*listenForCode() async {
    await SmsAutoFill().listenForCode;
  }*/
  startTime() async {
    var _duration = new Duration(minutes: 7);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/loginscreen');
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // listenForCode();
    startTime();
    startTimer();
  }

  updateResendOtp(_randomOtp) {
    crudObj.getPhoneNumber(widget.phnNumber).then((QuerySnapshot docs) async {
      if (docs.documents[0].data.isNotEmpty) {
        otpCrud.updateOtpInDb(docs, _randomOtp);
      }
    });
  }

  sendOtpOnResend() {
    _randomOtp = otpUtil.getRandomOtp();
    finalUrl = otpUtil.concatUrl(widget.phnNumber, _randomOtp);
    response = otpUtil.checkGetOtp(finalUrl);
    updateResendOtp(_randomOtp);
  }

  _validateOtp(otpFinal) {
    crudObj.getPhoneNumber(widget.phnNumber).then((QuerySnapshot docs) async {
      if (docs.documents[0].data.isNotEmpty) {
        if (docs.documents[0].data['otp'] == otpFinal) {
          sharedPrefs.saveValues(widget.phnNumber);
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          _scaffoldKey1.currentState.showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Please enter a valid OTP",
              style: TextStyle(color: Colors.white),
            ),
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
          key: _scaffoldKey1,
          // resizeToAvoidBottomInset: false,
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
                              "Phone Verification",
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' +91 ' + widget.phnNumber,
                                  style: TextStyle(color: Colors.black54))
                            ],
                            style: TextStyle(color: Colors.grey, fontSize: 16.0),
                            text:
                                "A verification code is sent to your number \n provided "),
                      ),
                      SizedBox(
                        height: height > 800 ? 100.0 : 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Theme(
                              child: TextFormField(
                                controller: _otpController,

                                validator: (val) {
                                  if (val.length < 6) {
                                    return 'Please enter a valid OTP';
                                  }
                                  return null;
                                },

                                onSaved: (phn) {
                                  _randomOtp = phn;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  BlacklistingTextInputFormatter(
                                      new RegExp(r'[.,-\s]')),
                                  LengthLimitingTextInputFormatter(6),
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: Icon(LineAwesomeIcons.unlock_alt),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  labelText: "OTP",
                                  // hintText: "example@mail.com",
                                ),
                                // autofocus: true,
                              ),
                              data: Theme.of(context).copyWith(
                                primaryColor: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              height: height > 800 ? 30.0 : 20.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Dont you get SMS ?",
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    child: _current == 30
                                        ? Text(
                                            "Resend",
                                            style: TextStyle(color: Colors.blue),
                                          )
                                        : Text(
                                            "Resend in $_current",
                                            style:
                                                TextStyle(color: Colors.black54),
                                          ),
                                    onTap: _current == 30
                                        ? () {
                                            _otpController.clear();
                                            startTimer();
                                            sendOtpOnResend();
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height > 800 ? 40.0 : 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                width: 400.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: FlatButton(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                      _validateOtp(_randomOtp);
                                    }
                                  },
                                  child: Text(
                                    "Verify Number",
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
          ));

  }
}
/*Visibility(
                      child: RaisedButton(
                        child: _current == 10
                            ? Text("data")
                            : Text("Resend in $_current"),
                        onPressed: hasError && _current == 10
                            ? () {
                                _otpController.clear();
                                startTimer();
                                sendOtpOnResend();
                              }
                            : null,
                      ),
                      visible: hasError,
                    ) */
/*PinCodeTextField(
                            // defaultBorderColor: Colors.transparent,
                            controller: _otpController,
                            hasError: hasError && _current == 10,
                            onTextChanged: (value) {
                              print(value);
                            },
                            errorBorderColor: hasError || _current == 10
                                ? Colors.red
                                : Colors.blue,
                            hasTextBorderColor: Colors.blue,
                            maxLength: 6,
                            autofocus: _autofocus,
                            pinBoxHeight: 50.0,
                            pinBoxWidth: 50.0,
  
                            defaultBorderColor: Colors.grey,
                            highlightColor: Colors.blue,
                            onDone: (text) {
                              otpFinal = text;
                              _validateOtp(otpFinal);
                            },
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
                            pinCodeTextFieldLayoutType:
                                PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                          ), */
/*
Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        /*Padding(
                          padding:
                              const EdgeInsets.only(left: 50.0, right: 50.0),
                          child: PinFieldAutoFill(
                            keyboardType: TextInputType.number,
                            decoration: _pinDecoration,
                            onCodeSubmitted: (String value) =>
                                _validateOtp(value),

                            // onCodeChanged: (String value) => _validateOtp(value),
                          ),
                        ),*/
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            BlacklistingTextInputFormatter(
                                new RegExp(r'[.,-\s]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            counterText: '',
                            // contentPadding: EdgeInsets.all(10.0),
                            icon: Icon(Icons.keyboard),
                            labelText: "OTP",
                          ),
                          onSaved: (value) {
                            otpFinal = value;
                          },
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              _validateOtp(otpFinal);
                            }
                          },
                          child: Text('Validate'),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
 */
