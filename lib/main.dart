import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:game_app/api.dart';
import 'package:game_app/button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Future<APIModel> fetchAPI;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  void initState() {
    fetchAPI = fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        top: true,
        child: FutureBuilder<APIModel>(
            future: fetchAPI,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Button(
                                    color: Colors.green,
                                    text: "Đăng ký",
                                    onClicked: () {
                                      _launchUrl(
                                          snapshot.data.data?.urlSignUp ?? "");
                                    }),
                              ),
                            ),
                            Expanded(
                              child: Button(
                                text: "Đăng nhập",
                                onClicked: () {
                                  _launchUrl(
                                      snapshot.data.data?.urlSignIn ?? "");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 24, bottom: 16, left: 48, right: 48),
                        child: Image.network(
                          snapshot.data.data?.logo ?? "",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          snapshot.data.data?.welcome ?? "",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: t32M.copyWith(
                              color: primarya500, fontStyle: FontStyle.italic),
                        ),
                      ),
                      // Text(
                      //   'DK8',
                      //   textAlign: TextAlign.center,
                      //   maxLines: 1,
                      //   style: t32M.copyWith(
                      //       color: primarya500,
                      //       fontWeight: FontWeight.bold,
                      //       fontStyle: FontStyle.italic),
                      // ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                        child: Button(
                            color: Colors.green,
                            text: "Trang Chủ",
                            icon: Icon(
                              Icons.roofing,
                              color: Colors.white,
                              size: 30.0,
                            ),
                            onClicked: () {
                              _launchUrl(snapshot.data.data?.urlHome ?? "");
                            }),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                        child: Button(
                          text: "Hỗ Trợ",
                          icon: Icon(
                            Icons.message,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onClicked: () {
                            _launchUrl(snapshot.data.data.urlSupport ?? "");
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 64, vertical: 8),
                        child: Button(
                          text: "Khuyến Mãi",
                          onClicked: () {
                            _launchUrl(snapshot.data.data?.urlPromotion ?? "");
                          },
                          icon: Icon(
                            Icons.card_giftcard,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  _launchUrl(String url) async {
    try {
      await launch(url);
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  Future<APIModel> fetchApi() async {
    final response = await http.get(Uri.parse(
        'http://dk888.online/getxs.aspx?apiSecretKey=p105g118e102k113e105k112m97u101'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      return APIModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
