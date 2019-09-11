import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:sathyabama_official/models/circular_model.dart';
import 'package:sathyabama_official/services/shared_prefs_service.dart';

class Circulars extends StatefulWidget {
  final String isStaff;
  Circulars({Key key, this.isStaff}) : super(key: key);
  @override
  _CircularsState createState() => _CircularsState();
}

class _CircularsState extends State<Circulars> {
  List circularList;
  bool result;
  Connectivity connectivity;
  SharedPrefs sharedPrefs = SharedPrefs();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future fetchCircular() async {
    final data = await http.get(
        'http://cloudportal.sathyabama.ac.in/mobileappsms/api/staff_circular.php?is_staff=' +
            "${widget.isStaff}");
    if (data.statusCode == HttpStatus.ok) {
      var jsonData = json.decode(data.body);
      List<Circular> circulars = List();
      for (var u in jsonData['circulars']) {
        Circular circular = Circular(u['C_Id'], u['StartDate'], u['EndDate'],
            u['Description'], u['Title'], u['Tag'], u['url']);
        circulars.add(circular);
      }
      return circulars;
    }
  }

  @override
  void initState() {
    super.initState();
    // fetchCircular();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
            widget.isStaff == "0" ? 'Staff Circulars' : 'Student Circulars'),
      ),
      body: Container(
        child: FutureBuilder(
          future: fetchCircular(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var myData = snapshot.data;
            if (snapshot.hasData) {
              return RefreshIndicator(
                color: Colors.redAccent,
                displacement: 40.0,
                onRefresh: fetchCircular,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: myData.length,
                  itemBuilder: (context, index) => Card(
                      elevation: 0.0,
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              trailing: Text(
                                "Dated On: " + myData[index].startDate,
                                style: TextStyle(fontSize: 11.0),
                              ),
                            ),

                            ListTile(
                              leading: Icon(
                                LineAwesomeIcons.file_text,
                                size: 30.0,
                                color: Colors.redAccent,
                              ),
                              title: Text(
                                myData[index].title.toString().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: myData[index].url == ''
                                  ? Row(

                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Icon(LineAwesomeIcons.bars,color: Colors.redAccent,size: 30.0,),
                                  ),

                                  Flexible(child: Padding(
                                    padding: const EdgeInsets.only(left: 32.0, right: 8.0),
                                    child: Text(myData[index].description, textAlign: TextAlign.justify,),
                                  ))
                                ],
                              )
                                  : ListTile(
                                leading: Icon(
                                  LineAwesomeIcons.file_pdf_o,
                                  size: 35.0,
                                  color: Colors.redAccent,
                                ),
                                title: InkWell(
                                    onTap: () {
                                      _launchURL(myData[index].url);
                                    },
                                    child: Text(
                                      "View PDF",
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline),
                                    )),
                              ),
                            ),
                            ListTile(
                              leading: Chip(
                                avatar: Icon(
                                  LineAwesomeIcons.tag,
                                  color: Colors.redAccent,
                                ),
                                label: Text(
                                  myData[index].tag.toString().toLowerCase(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                // onPressed: () {},
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.0, color: Color(0xFFDEDEDE)),
                                    borderRadius: BorderRadius.circular(5.0)),
                                backgroundColor: Color(0xFFF7F7F7),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              );
            } else {
              return Center(
                child: PKCardPageSkeleton(
                  totalLines: 5,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/*
 circularList == null
          ? Center(
              child: PKCardPageSkeleton(
                totalLines: 5,
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchCircular,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: circularList.length,
                itemBuilder: (context, index) => Card(
                    elevation: 0.0,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200.0,
                            child: Image.network(
                              circularList[index]['url'],
                              fit: BoxFit.fill,
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              LineAwesomeIcons.file_text,
                              size: 30.0,
                              color: Colors.redAccent,
                            ),
                            title: Text(
                              circularList[index]['Title'],
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              LineAwesomeIcons.bars,
                              size: 30.0,
                              color: Colors.redAccent,
                            ),
                            title: Text(
                                circularList[index]['Description'].toString()),
                          ),
                          ListTile(
                            leading: ActionChip(
                              avatar: Icon(
                                LineAwesomeIcons.tag,
                                color: Colors.redAccent,
                              ),
                              label: Text(
                                circularList[index]['Tag']
                                    .toString()
                                    .toLowerCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {},
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 0.5, color: Color(0xFFDEDEDE)),
                                  borderRadius: BorderRadius.circular(5.0)),
                              backgroundColor: Color(0xFFF7F7F7),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
 */
