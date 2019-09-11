import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sathyabama_official/screens/url_route.dart';
import 'package:sathyabama_official/utils/dicts.dart';

class LearnOnline extends StatefulWidget {
  @override
  _LearnOnlineState createState() => _LearnOnlineState();
}

class _LearnOnlineState extends State<LearnOnline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Learn Online'),
      ),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: youTubeData.length,
          itemBuilder: (BuildContext context, int index) {
            String k = youTubeData.keys.elementAt(index);
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (BuildContext context) => UrlRoute(
                              url: youTubeData[k][0],
                              title: k,
                            )));
              },
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: Icon(
                      youTubeData[k][1],
                      size: 30.0,
                      color: Colors.redAccent,
                    ),
                    title: Text(k),
                    trailing: Icon(
                      Icons.open_in_browser,
                      size: 25.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
