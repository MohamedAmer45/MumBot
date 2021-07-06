import 'package:flutter/material.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import '../Widgets/chatting_bubble.dart';

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
        "0F85F2E6-240E-F1C7-FF53-0695F8E5E300",
        "7021D8A5-CA5E-470C-8843-0BFAC2644E7E",
        "1D407144-27F8-45A4-A20F-DA02C22D6F00");
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
          ..headers = {"id": "0", "name": "Parent_spec"});

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
                        if (myController.text.isEmpty) {
                          print("empty message");
                        } else {
                          onMessageSubmitted(myController.text);
                        }
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
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
