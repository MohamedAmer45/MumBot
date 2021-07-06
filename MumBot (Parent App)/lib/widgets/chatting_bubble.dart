import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';

Widget chattingBubble(String message, int data, String image) {
  return Container(
    child: Row(
      mainAxisAlignment:
          data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        data == 0
            ? Container(
                padding: EdgeInsets.all(5),
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage(image),
                ),
              )
            : Container(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Bubble(
              radius: Radius.circular(20.0),
              color: data == 0 ? Colors.blue : Colors.orangeAccent,
              elevation: 0.0,
              child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                        child: Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(
                        message,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ))
                  ],
                ),
              )),
        ),
        data == 1
            ? Container(
                padding: EdgeInsets.all(5),
                height: 60,
                width: 60,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/User.png"),
                  backgroundColor: Colors.white,
                ),
              )
            : Container(),
      ],
    ),
  );
}
