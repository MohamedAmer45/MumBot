import 'package:flutter/material.dart';
import 'package:parenting_specialist/Widgets/constants.dart';
import 'package:parenting_specialist/Widgets/forum_textField.dart';
import 'package:parenting_specialist/Widgets/rounded_button.dart';
import 'package:parenting_specialist/Widgets/rounded_input_field.dart';

class ForumCards extends StatefulWidget {
  @override
  _ForumCardsState createState() => _ForumCardsState();
}

class _ForumCardsState extends State<ForumCards> {
  final String questionText =
      'QuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestionQuestion';

  final TextEditingController _answerController = new TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      '5/6/2021',
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
                    questionText,
                  ),
                ),
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(3),
            //   alignment: Alignment.topLeft,
            //   child: Text(
            //     'Tags',
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
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
                        // autovalidate: AutovalidateMode.onUserInteraction,
                        // validator: (value) {
                        //   if (value.isEmpty) {
                        //     return AnswerNullError;
                        //   }

                        //   return null;
                        // },
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
                                          Navigator.pop(context, true),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  successAddingAnswerSnackBar),
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
  }
}
