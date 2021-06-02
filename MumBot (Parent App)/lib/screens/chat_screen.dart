import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import '../widgets/chatting_bubble.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  ChatScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChatScreen> {
  // List<Map> _messages = [];
  String _messages = "";
  String _messages2 = "";
  String userID = "";
  List<Map> messagesList = [];
  final myController = new TextEditingController();
  final myController2 = new TextEditingController();
  @override
  void initState() {
    super.initState();
    // userID = '1';
    Backendless.initApp(
        "92FE02D3-C7CC-9235-FF70-5B97F4477F00",
        "AABDF7B8-D50C-4C9E-AF44-5EAF50B0D57A",
        "33705851-F89A-4807-82F5-7DF4A7B4F789");
    initListeners();
  }

  void initListeners() async {
    Channel channel = await Backendless.messaging.subscribe("myChannel");
    channel.addMessageListener(onMessageReceived);
  }

  void onMessageSubmitted(String message) async {
    Backendless.messaging.publish(message,
        channelName: "myChannel",
        publishOptions: PublishOptions()
          ..headers = {"id": "1", "name": "Parent"});

    myController.clear();
  }

  void onMessageReceived(PublishMessageInfo messageInfo) {
    userID = messageInfo.headers['id'];
    // setState(() => _messages +=
    //     "${messageInfo.headers['name']}: ${messageInfo.message}\n");
    setState(() {
      if (userID == "1") {
        _messages += "${messageInfo.message}";
        messagesList.insert(0, {"data": 1, "message": _messages});
        _messages = "";
      } else {
        _messages2 += "${messageInfo.message}";
        messagesList.insert(0, {"data": 0, "message": _messages2});
        _messages2 = "";
      }
    });
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
          title: Text('Chat'),
        ),
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
                    messagesList[index]["message"].toString(),
                    messagesList[index]["data"],
                  ),
                  itemCount: messagesList.length,
                ),
              ),
              // userID == "1"
              //     ? chattingBubble(_messages, 1)
              //     : chattingBubble(_messages2, 0),
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
                      onSubmitted: onMessageSubmitted,
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
                      onMessageSubmitted(myController.text);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              )
            ],
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
