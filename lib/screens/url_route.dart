import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class UrlRoute extends StatefulWidget {
  final String url, title;
  UrlRoute({Key key, this.url, this.title}) : super(key: key);
  @override
  _UrlRouteState createState() => _UrlRouteState();
}

class _UrlRouteState extends State<UrlRoute> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  double progress = 1.0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebviewScaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.redAccent[200],
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                flutterWebviewPlugin.reloadUrl(widget.url);
              },
              icon: Icon(LineAwesomeIcons.refresh),
            )
          ],
        ),
        supportMultipleWindows: true,
        url: widget.url,
        appCacheEnabled: true,
        withLocalUrl: true,
        clearCookies: true,
        withJavascript: true,
        withZoom: false,
        initialChild: Center(
          child: CircularProgressIndicator(),
        ),
        geolocationEnabled: true,
        allowFileURLs: true,
        withLocalStorage: true,
        enableAppScheme: true,
      ),
    );
  }
}
/*

*/
