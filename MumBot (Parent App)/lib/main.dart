import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbot_v2/VideoChat/index.dart';

import 'package:mumbot_v2/screens/book_Inquiry_screen.dart';
import 'package:mumbot_v2/screens/book_session_screen.dart';
import 'package:mumbot_v2/screens/chat_screen.dart';
import 'package:mumbot_v2/screens/edit_password_screen.dart';
import 'package:mumbot_v2/screens/edit_profile_screen.dart';
import 'package:mumbot_v2/screens/login_screen.dart';
import 'package:mumbot_v2/screens/signup_screen.dart';

import './screens/user_panel_screen.dart';
import 'package:watson_assistant_v2/watson_assistant_v2.dart';

import './widgets/chatting_bubble.dart';

void main() {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = new MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MumBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        UserPanelScreen.routeName: (ctx) => UserPanelScreen(),
        MyHomePage.routeName: (ctx) => MyHomePage(),
        ChatScreen.routeName: (ctx) => ChatScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        EditPasswordScreen.routeName: (ctx) => EditPasswordScreen(),
        IndexPage.routeName: (ctx) => IndexPage(),
        BookSessionScreen.routeName: (ctx) => BookSessionScreen(),
        BookInquiryScreen.routeName: (ctx) => BookInquiryScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const routeName = '/main';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text;
  List<Map> messsages = [];
  WatsonAssistantV2Credential credential = WatsonAssistantV2Credential(
      version: '2019-02-28',
      username: 'apikey',
      apikey: 'IIMOpOIzQfRkf5Bu5JwfDK1SmRpXcgLAhc4MtMNLtpgc',
      assistantID: 'a180cd12-34d5-439f-affe-d1ebf58acc20',
      url:
          'https://api.eu-gb.assistant.watson.cloud.ibm.com/instances/9976a122-9202-401b-959d-e336aca09e0e/v2'
      // url: 'https://gateway-lon.watsonplatform.net/assistant/api/v2',
      );

  WatsonAssistantApiV2 watsonAssistant;
  WatsonAssistantResponse watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  final myController = TextEditingController();

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
      messsages.insert(0, {"data": 0, "message": _text});
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV2(watsonAssistantCredential: credential);
    _callWatsonAssistant();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure you want to end the chat session ?"),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Yes"),
          ),
          // ignore: deprecated_member_use
          FlatButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('MumBot'),
        ),
        body: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) => chattingBubble(
                      messsages[index]["message"].toString(),
                      messsages[index]["data"],
                    ),
                    itemCount: messsages.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  height: 5.0,
                  color: Colors.blue,
                ),
                Container(
                  child: ListTile(
                    title: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(220, 220, 220, 1),
                      ),
                      padding: EdgeInsets.only(left: 15),
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          if (myController.text.isEmpty) {
                            print("empty message");
                          } else {
                            _callWatsonAssistant();
                            setState(() {
                              messsages.insert(
                                  0, {"data": 1, "message": myController.text});
                            });
                            myController.clear();
                          }
                        },
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "Enter a Message...",
                          hintStyle: TextStyle(color: Colors.black26),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Colors.blue[900],
                        ),
                        onPressed: () {
                          if (myController.text.isEmpty) {
                            print("empty message");
                          } else {
                            _callWatsonAssistant();
                            setState(() {
                              messsages.insert(
                                  0, {"data": 1, "message": myController.text});
                            });
                            myController.clear();
                          }
                        }),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
