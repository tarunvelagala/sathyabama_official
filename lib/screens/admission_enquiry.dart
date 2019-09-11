import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:sathyabama_official/utils/dicts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

class AdmissionEnquiry extends StatefulWidget {
  @override
  _AdmissionEnquiryState createState() => _AdmissionEnquiryState();
}

class _AdmissionEnquiryState extends State<AdmissionEnquiry> {
  String currentSelectedValueState, currentSelectedValueCourse;
  String name, email, mobile, city;
  GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<String> sendQuery(value) async {
    String res = json.encode(value);
    print(res);
    final data = await http.get(
        'http://cloudportal.sathyabama.ac.in/mobileappsms/api/admission_enquiry.php?json=' +
            res);
    var jsonData = json.decode(data.body);
    print(jsonData);
    return jsonData['verify'];
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      appBar: AppBar(
        /*leading: new IconButton(
          onPressed: () {},
          icon: CircleAvatar(
            backgroundImage: AssetImage('images/Poster-Final.jpg'),
            backgroundColor: Colors.white,
          ),
          padding: EdgeInsets.only(left: 1.0, top: 2.0),
        ),*/
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
              padding: EdgeInsets.only(top: 20.0),
              child: FormBuilder(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: height > 800 ? 10.0 : 5,
                      ),
                      Container(
                        height: height > 800 ? 50.0 : 30.0,
                        child: Text(
                          "Admission Enquiry",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Theme(
                        child: FormBuilderTextField(
                          attribute: 'Name',
                          onFieldSubmitted: (String val) {
                            name = val;
                          },
                          validators: [
                            FormBuilderValidators.max(70),
                            FormBuilderValidators.min(4),
                            FormBuilderValidators.required(),
                          ],
                          decoration: InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(LineAwesomeIcons.font),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Theme(
                        child: FormBuilderTextField(
                          attribute: 'Email',
                          validators: [
                            FormBuilderValidators.email(),
                            FormBuilderValidators.required()
                          ],
                          decoration: InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(LineAwesomeIcons.envelope),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Theme(
                        child: FormBuilderTextField(
                          attribute: 'Mobile',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            BlacklistingTextInputFormatter(
                                new RegExp(r'[.,-\s]')),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          validators: [
                            // FormBuilderValidators.numeric(),
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(10),
                            FormBuilderValidators.pattern(r'^[6-9]\d{9}',
                                errorText: 'Please enter a valid mobile number')
                          ],
                          decoration: InputDecoration(
                              labelText: 'Mobile',
                              prefixIcon: Icon(LineAwesomeIcons.mobile),
                              //fillColor: Colors.transparent,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        data: Theme.of(context).copyWith(
                          primaryColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Theme(
                        child: FormBuilderTextField(
                          attribute: 'City',
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(
                              labelText: 'City',
                              prefixIcon: Icon(LineAwesomeIcons.map_marker),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                        data: Theme.of(context).copyWith(
                          //cardColor: Colors.transparent,
                          primaryColor: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Theme(
                          child: FormBuilderDropdown(
                            attribute: 'State',
                            validators: [FormBuilderValidators.required()],
                            // initialValue: 'State',
                            hint: Text('Select State'),

                            decoration: InputDecoration(
                                // labelText: 'St'
                                prefixIcon: Icon(LineAwesomeIcons.map),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            items: states
                                .map((state) => DropdownMenuItem(
                                      value: state,
                                      child: Text("$state"),
                                    ))
                                .toList(),
                          ),
                          data: Theme.of(context).copyWith(
                            primaryColor: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Theme(
                          child: FormBuilderDropdown(
                            attribute: 'Course',
                            // initialValue: 'State',
                            validators: [FormBuilderValidators.required()],
                            hint: Text('Select Course'),
                            decoration: InputDecoration(
                                // labelText: 'St'
                                prefixIcon: Icon(LineAwesomeIcons.book),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            items: courses
                                .map((course) => DropdownMenuItem(
                                      value: course,
                                      child: Text("$course"),
                                    ))
                                .toList(),
                          ),
                          data: Theme.of(context).copyWith(
                            primaryColor: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
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
                              _formKey.currentState.save();
                              if (_formKey.currentState.validate()) {
                                var data = await sendQuery(
                                    _formKey.currentState.value);
                                print(data.toString());
                                if (data == 'OK') {
                                  _showDialog();
                                }
                                // _showDialog();
                              }
                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.transparent)),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: Text("Go Back".toUpperCase()),
                )
              ],
              title: Icon(
                LineAwesomeIcons.smile_o,
                size: 40.0,
                color: Colors.teal,
              ),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Thank You",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.teal),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Your response is submitted successfully. We will respond you soon.!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ));
        });
  }
}
