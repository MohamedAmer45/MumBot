import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:parenting_specialist/Screens/home_page.dart';
import 'package:parenting_specialist/Screens/login_screen.dart';
import 'package:parenting_specialist/Widgets/forum_textField.dart';
import 'package:parenting_specialist/api/specialist_api.dart';
import 'package:parenting_specialist/models/question.dart';
import 'package:http/http.dart' as http;

class ForumScreen extends StatefulWidget {
  static const routeName = '/forum-screen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

final successAddingAnswerSnackBar = SnackBar(
  content: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Answer Added Successfully',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    ],
  ),
  backgroundColor: Color(0XFF009D26),
  duration: Duration(seconds: 2),
  elevation: 7,
);
final emptyAnswerSnackBar = SnackBar(
  content: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Please Enter a Valid Answer',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    ],
  ),
  backgroundColor: Color(0XFFDA0000),
  duration: Duration(seconds: 2),
  elevation: 7,
);

List data;
int questionId;
String questionBody;
String questionDate;

class _ForumScreenState extends State<ForumScreen> {
  Future<Question> fetchQuestion;

  @override
  void initState() {
    super.initState();
    fetchQuestionData();
  }

  Future<Question> fetchQuestionData() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/apis/api/question/'));

    if (response.statusCode == 200) {
      setState(() {
        var resBody = json.decode(response.body);
        data = resBody;
      });
    } else {
      print('404');
      throw Exception('Failed to load question');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (context, index) {
        questionId = data[index]['id'];
        questionBody = data[index]['question_body'];
        questionDate = data[index]['question_date'];
        Size size = MediaQuery.of(context).size;
        final TextEditingController _answerController =
            new TextEditingController();
        int answerQuestionId = questionId;

        return Container(
          // width: size.width * 0.9,
          // height: size.height * 0.3,
          child: Card(
            color: Colors.grey[200],
            margin: EdgeInsets.all(5),
            elevation: 20,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.topLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          questionDate.substring(0, 10),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        questionBody,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Answer',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * 0.87,
                        child: ForumInputField(
                            controller: _answerController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(Icons.question_answer),
                                onPressed: () {
                                  if (_answerController.text.isNotEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text(
                                            "Are you sure you want to submit your answer ?"),
                                        actions: [
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                            onPressed: () => {
                                              this.setState(() {
                                                SpecialistAPI().addAnswer(
                                                    answerQuestionId,
                                                    _answerController.text,
                                                    specialistLoginData['id']);
                                              }),
                                              Navigator.pop(context, true),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      successAddingAnswerSnackBar),
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      HomePage.routeName),
                                              _answerController.clear(),
                                            },
                                            child: Text("Yes"),
                                          ),
                                          // ignore: deprecated_member_use
                                          FlatButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                              child: Text("No")),
                                        ],
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(emptyAnswerSnackBar);
                                  }
                                },
                              ),
                              counterText: "",
                              hintText: 'Enter Your Answer',
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
