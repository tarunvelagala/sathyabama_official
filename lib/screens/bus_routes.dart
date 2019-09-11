import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:pk_skeleton/pk_skeleton.dart';
import 'package:sathyabama_official/models/bus_route_model.dart';

class BusRoute extends StatefulWidget {
  @override
  _BusRouteState createState() => _BusRouteState();
}

class _BusRouteState extends State<BusRoute> {
  TextEditingController controller = new TextEditingController();
  List<BusRouteModel> busroutes = List();
  Future<http.Response> _responseFuture;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<Null> getBusRoute() async {
    final response = await http.get(
        'http://cloudportal.sathyabama.ac.in/mobileappsms/api/bus_info.php');
    if (response.statusCode == HttpStatus.ok) {
      var jsonData = json.decode(response.body);

      for (var u in jsonData['bus_route']) {
        BusRouteModel busroute = BusRouteModel(
          u['Busno'],
          u['Busdestiny'],
          u['Busvia'],
        );
        busroutes.add(busroute);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _responseFuture = http.get(
        'http://cloudportal.sathyabama.ac.in/mobileappsms/api/bus_info.php');
    // getBusRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
        title: Text('Bus Information'),
      ),
      body: Container(
        child: FutureBuilder(
          future: _responseFuture,
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> response) {
            if (!response.hasData) {
              return Center(
                child: PKCardPageSkeleton(
                  totalLines: 5,
                ),
              );
            } else if (response.data.statusCode != 200) {
              return Center(
                child: PKCardPageSkeleton(
                  totalLines: 5,
                ),
              );
            } else {
              var jsonData = json.decode(response.data.body);
              return MyExpansionTileList(jsonData);
            }
          },
        ),
      ),
    );
  }
}

class MyExpansionTileList extends StatelessWidget {
  final Map elementList;

  MyExpansionTileList(this.elementList);
  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList['bus_route'].forEach((element) {
      children.add(MyExpansionTile(
          element['Busno'], element['Busvia'], element['Busdestiny']));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _getChildren());
  }
}

class MyExpansionTile extends StatefulWidget {
  final String busno;
  final String busdestiny;
  final String busvia;
  MyExpansionTile(this.busno, this.busvia, this.busdestiny);
  @override
  _MyExpansionTileState createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      trailing: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          LineAwesomeIcons.angle_double_down,
          size: 20.0,
          color: Colors.redAccent,
        ),
      ),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(color: Colors.black26, width: 1.5),
        ),
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.transparent),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text(widget.busno, style: TextStyle(color: Colors.redAccent)),
            ),
          ),
        ),
      ),
      title: Text(
        widget.busdestiny,
      ),
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(LineAwesomeIcons.map_signs),
              ),
              Flexible(child: Text(widget.busvia.trim())),
            ],
          ),
        )
      ],
    );
  }
}
