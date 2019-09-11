import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:connectivity/connectivity.dart';

class ErrorScreen extends StatefulWidget {
  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  var result;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
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
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ShaderMask(
                child: Icon(
                  Icons.link_off,
                  size: height > 800.0 ? 218.0 : 168.0,
                ),
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return ui.Gradient.linear(
                    Offset(4.0, 24.0),
                    Offset(24.0, 4.0),
                    [
                      //Colors.blue,
                      //Colors.blue[900]
                      Color(0XFF1FA2FF),
                      Color(0XFF12D8FA),
                    ],
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "Oh no!",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 30.0,
                      color: Colors.black87),
                )),
            Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text(
                  "No Internet found. Check your Internet Connection or try again ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                )),
            /*RaisedButton(
              onPressed: () async {
                result = await Connectivity().checkConnectivity();
                if (result != ConnectivityResult.none) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text('Try Again'),
              //textColor: Colors.red,
              splashColor: Colors.grey,
              textTheme: ButtonTextTheme.accent,
              shape: StadiumBorder(),
              
            ),*/
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 180.0,
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0)),
                child: OutlineButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    onTryAgain();
                  },
                  child: Text(
                    "Try Again",
                    //style: TextStyle(color: Colors.blueAccent),
                  ),
                  textTheme: ButtonTextTheme.accent,
                  shape: StadiumBorder(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onTryAgain() async {
    result = await Connectivity().checkConnectivity();
    if (result != ConnectivityResult.none) {
      Navigator.pushReplacementNamed(context, '/splash');
    }
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content:
          Text('Its not your fault. Check your connectivity and try again.'),
      action: SnackBarAction(
        onPressed: () {
          if (result != ConnectivityResult.none) {
            Navigator.pushReplacementNamed(context, '/splash');
          }
          onTryAgain();
        },
        label: 'RETRY',
      ),
    ));
  }
}
