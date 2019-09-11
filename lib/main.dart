import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sathyabama_official/screens/error_screen.dart';
import 'package:sathyabama_official/screens/homepage.dart';
import 'package:sathyabama_official/screens/login_screen.dart';
import 'package:sathyabama_official/screens/circulars.dart';
import 'package:sathyabama_official/services/crud.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MaterialApp(
      theme: ThemeData(splashColor: Colors.transparent),
      color: Colors.redAccent,
      title: 'Sathyabama Official',
      home: new SplashScreen(),
      routes: {
        '/loginscreen': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomePage(),
        '/errorscreen': (BuildContext context) => ErrorScreen(),
        '/splash': (BuildContext context) => SplashScreen(),
        '/studentcircular': (BuildContext context) => Circulars()
      },
    ));
  });
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var result;
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigationPage);
  }

  checkConnectivity() async {
    result = await Connectivity().checkConnectivity();
    return result;
  }

  navigationPage() async {
    CrudMethods crudObj = CrudMethods();
    final prefs = await SharedPreferences.getInstance();
    var phnNumber;
    phnNumber = prefs.getString('phone_number');
    print(phnNumber);
    try {
      if (result == ConnectivityResult.none) {
        _key.currentState.showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enable your internet and try again'),
        ));
        Navigator.of(context).pushReplacementNamed('/errorscreen');
      } else {
        crudObj.getPhoneNumber(phnNumber).then((QuerySnapshot docs) {
          print(docs.documents[0].data);
          if (docs.documents[0].data.isEmpty || phnNumber == null) {
            Navigator.of(context).pushReplacementNamed('/loginscreen');
          } else {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        });
      }
    } catch (e) {
      Navigator.of(context).pushReplacementNamed('/errorscreen');
      print(e.code);
    }
  }

  @override
  void initState() {
    super.initState();
    result = checkConnectivity();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/sist_220.png');
    Image image = Image(
      image: assetImage,
      width: 140.0,
      height: 150.0,
    );
    return Scaffold(
      key: _key,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image,
          ],
        ),
      ),
    );
  }
}
