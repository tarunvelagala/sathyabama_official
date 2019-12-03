import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class ComplainUs extends StatefulWidget {
  @override
  _ComplainUsState createState() => _ComplainUsState();
}

class _ComplainUsState extends State<ComplainUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        onPressed: (){},
        child: Icon(LineAwesomeIcons.camera),
      ),
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Complain Us'),
      ),
    );
  }
}
