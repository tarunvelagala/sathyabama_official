import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:sathyabama_official/screens/url_route.dart';
import 'package:sathyabama_official/services/shared_prefs_service.dart';
import 'package:sathyabama_official/utils/dicts.dart';
import 'dart:ui' as ui;
import 'package:sathyabama_official/utils/url_launch.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPrefs sharedPrefs = SharedPrefs();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AssetImage assetImage = AssetImage('images/banner1.jpg');
    Image image = Image(
      fit: height > 800.0 ? BoxFit.fitHeight : BoxFit.cover,
      image: assetImage,
    );
    LaunchURL launchUrl = LaunchURL();
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Stack(children: <Widget>[
            new IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: CircleAvatar(
                backgroundImage: AssetImage('images/Poster-Final.jpg'),
                backgroundColor: Colors.white,
              ),
              padding: EdgeInsets.only(left: 5.0),
            ),
            new Positioned(
              right: 6,
              bottom: 10,
              child: new Container(
                padding: EdgeInsets.only(
                    top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(maxHeight: 20, minHeight: 14),
                child: //new AssetImage('images'),
                    Icon(
                  Icons.menu,
                  size: 13.0,
                  color: Colors.redAccent,
                ),
              ),
            )
          ]),
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
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                "Sathyabama Institute of Science and Technology",
                style: TextStyle(color: Colors.amber, fontSize: 13),
              ),
              accountEmail: new Text(
                "Deemed University",
                style: TextStyle(color: Colors.amber, fontSize: 13),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://images.static-collegedunia.com/public/college_data/images/pdfthumb/1486719644PROSPECTUS/full-1.jpg"))),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 2.0),
                physics: BouncingScrollPhysics(),
                itemCount: browserData.length,
                itemBuilder: (BuildContext context, int index) {
                  String k = browserData.keys.elementAt(index);
                  return InkWell(
                    onTap: () {
                      browserData[k][3]
                          ? Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      browserData[k][0]))
                          :launchUrl.launchUrlInBrowser(browserData[k][0]) /*Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (BuildContext context) => UrlRoute(
                                        url: browserData[k][0],
                                        title: k,
                                      )))*/;
                    },
                    child: ListTile(
                      title: new Text(
                        k,
                        style: TextStyle(fontSize: 14.0),
                      ),
                      leading: new Icon(
                        browserData[k][1],
                        size: 30.0,
                        color: Color(0XFFFD1D1D),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: height > 800 ? 300.0 : 150.0,
              child: image,
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: browserData.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, childAspectRatio: 1.0),
              itemBuilder: (BuildContext context, int index) {
                String k = browserData.keys.elementAt(index);
                return InkWell(
                  onTap: () {
                    browserData[k][3]
                        ? Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    browserData[k][0]))
                        :launchUrl.launchUrlInBrowser(browserData[k][0]) /*Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (BuildContext context) => UrlRoute(
                                      url: browserData[k][0],
                                      title: k,
                                    )))*/;
                  },
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
                    elevation: 0.1,
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ShaderMask(
                            child: Icon(
                              browserData[k][1],
                              size: 30.0,
                            ),
                            blendMode: BlendMode.srcIn,
                            shaderCallback: (Rect bounds) {
                              return ui.Gradient.linear(
                                Offset(4.0, 24.0),
                                Offset(24.0, 4.0),
                                [
                                  Color(0XFFFD1D1D),
                                  Color(0XFFF77737),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              browserData[k][2],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: circulars.length,
              itemBuilder: (BuildContext context, int index) {
                String k = circulars.keys.elementAt(index);
                return InkWell(
                  onTap: () async {
                    var x = await sharedPrefs.getIsStaff();
                    print(x);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                x == null ? circulars[k][1] : circulars[k][2]));
                  },
                  child: Card(
                    elevation: 1.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 0.1, vertical: 0.3),
                    color: Colors.white,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          circulars[k][3]
                              ? Stack(
                                  children: <Widget>[
                                    ShaderMask(
                                      child: Icon(
                                        circulars[k][0],
                                        size: 35.0,
                                      ),
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (Rect bounds) {
                                        return ui.Gradient.linear(
                                          Offset(24.0, 24.0),
                                          Offset(24.0, 4.0),
                                          [
                                            Color(0XFFFD1D1D),
                                            Color(0XFFF77737),
                                          ],
                                        );
                                      },
                                    ),
                                    /*Positioned(
                                      right: 3,
                                      top: 2,
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        constraints: BoxConstraints(
                                            minHeight: 14, minWidth: 14),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                          constraints: BoxConstraints(
                                              minHeight: 1, maxHeight: 1),
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                    )*/
                                  ],
                                )
                              : ShaderMask(
                                  child: Icon(
                                    circulars[k][0],
                                    size: 35.0,
                                  ),
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (Rect bounds) {
                                    return ui.Gradient.linear(
                                      Offset(24.0, 24.0),
                                      Offset(24.0, 4.0),
                                      [
                                        Color(0XFFFD1D1D),
                                        Color(0XFFF77737),
                                      ],
                                    );
                                  },
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              k,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: circulars.length,
                childAspectRatio: MediaQuery.of(context).size.height > 800
                    ? 100 / 70
                    : 100 / 70,
              ),
            ),
            Container(
              height: height > 800.0 ? 65.0 : height < 600.0 ? 45.0 : 55.0,
              color: Colors.white70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: socialIcon.length,
                itemBuilder: (BuildContext context, int index) {
                  String k = socialIcon.keys.elementAt(index);
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (BuildContext context) =>
                                  UrlRoute(title: k, url: socialIcon[k][0])));
                    },
                    child: Padding(
                      padding: height > 800
                          ? const EdgeInsets.only(
                              left:10.0, top: 10.0)
                          : const EdgeInsets.only(
                               left: 10.0, top: 10.0),
                      child: Container(
                        width: 50.0,
                        child: ShaderMask(
                          child: Icon(
                            socialIcon[k][1],
                            size: 35.0,
                          ),
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              Offset(24.0, 24.0),
                              Offset(24.0, 4.0),
                              [
                                Color(0XFFFD1D1D),
                                Color(0XFFF77737),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
