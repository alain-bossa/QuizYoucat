import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/models/category.dart';
import 'package:quiz_youcat/models/quiz.dart';
import 'package:quiz_youcat/stores/quiz_store.dart';

class QuizCategoryDetailsScreen extends StatefulWidget {
  static const routeName = '/categoryDetails';
  late Category category;

  QuizCategoryDetailsScreen(this.category, {Key? key}) : super(key: key);

  @override
  _QuizCategoryDetailsScreenState createState() =>
      _QuizCategoryDetailsScreenState(category);
}

class _QuizCategoryDetailsScreenState extends State<QuizCategoryDetailsScreen> {
  late Category category;

  _QuizCategoryDetailsScreenState(this.category);

  late List<Quiz> quizList = [];
  @override
  void initState() {
    var quizStore = QuizStore();
    quizStore.loadQuizListByCategoryAsync(category.id).then((value) {
      setState(() {
        quizList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(10.0),
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              Expanded(
                child: categoryDetailsView(quizList),
              ),
            ],
          ),
        ),
        appBar: AppBar(
            title: const Text('Quiz Youcat & Bible'),
            backgroundColor: Color.fromARGB(255, 47, 133, 152),
            actions: [
              IconButton(
                icon: const Icon(Icons.access_time),
                tooltip: 'action à implémenter ...',
                onPressed: () {
                  //premPassage = 0;
                  Navigator.pushReplacementNamed(
                      context, QuizCategoryDetailsScreen.routeName);
                },
              ),
            ]),
      ),
    );
  }

  categoryDetailsView(List<Quiz> quizList) {
    return SingleChildScrollView(
      child: Column(
        children: quizList
            .map((quiz) => GestureDetector(
                  child: categoryDetailsItemView(quiz),
                  onTap: () {
                    Navigator.of(context).pushNamed("/quiz", arguments: quiz);
                  },
                ))
            .toList(),
      ),
    );
  }

  categoryDetailsItemBadge(Quiz quiz) {
    return Container(
      alignment: Alignment.topRight,
      child: Container(
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ThemeHelper.primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
            )),
        child: Text(
          "${quiz.questions.length} Questions",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  categoryDetailsItemView(Quiz quiz) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 20),
      decoration: ThemeHelper.roundBoxDeco(),
      child: Stack(
        children: [
          categoryDetailsItemBadge(quiz),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: ThemeHelper.roundBoxDeco(
                      color: Color(0xffE1E9F6), radius: 10),
                  child: Image(
                    image: AssetImage(quiz.imagePath.isEmpty == true
                        ? category.imagePath
                        : quiz.imagePath),
                    width: 130,
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(quiz.description),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
