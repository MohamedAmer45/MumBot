import 'package:flutter/material.dart';
import 'package:parenting_specialist/Widgets/forum_card.dart';
import 'package:parenting_specialist/api/specialist_api.dart';
import 'package:parenting_specialist/models/question.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = '/forum-screen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

AsyncSnapshot<List<Question>> snapshot;
int listLength;

class _ForumScreenState extends State<ForumScreen> {
  Future<Question> fetchQuestion;

  @override
  void initState() {
    super.initState();
    fetchQuestion = SpecialistAPI().fetchQuestion();
    // print(questionData.length);
  }

  @override
  Widget build(BuildContext context) {
    this.setState(() {
      questionData.length;
    });
    return ListView.builder(
      // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 1,
      //     childAspectRatio: 3 / 2,
      //     crossAxisSpacing: 10,
      //     mainAxisSpacing: 15),
      padding: EdgeInsets.all(10),
      itemCount: questionData.length,
      itemBuilder: (ctx, i) {
        return ForumCards();
      },
    );
    // return FutureBuilder<Question>(
    //   future: fetchQuestion,
    //   builder: (context, snapshot) {
    //     // print(questionData.length);
    //     if (snapshot.hasData) {
    //       // questionData.length;

    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
  }
}
