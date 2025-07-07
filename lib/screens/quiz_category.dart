import 'dart:core';

import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/models/category.dart';
import 'package:quiz_youcat/screens/quiz_category_details.dart';
import 'package:quiz_youcat/stores/quiz_store.dart';

class QuizCategoryScreen extends StatefulWidget {
  static const routeName = '/quizCategory';
  const QuizCategoryScreen({Key? key}) : super(key: key);

  @override
  _QuizCategoryScreenState createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  late List<Category> categoryList = [];
  @override
  void initState() {
    var quizStore = QuizStore();
    quizStore.loadCategoriesAsync().then((value) {
      setState(() {
        categoryList = value;
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
                child: categoryListView(categoryList),
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
                      context, QuizCategoryScreen.routeName);
                },
              ),
            ]),
      ),
    );
  }

  Widget categoryListView(List<Category> categoryList) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 20,
        runSpacing: 30,
        direction: Axis.horizontal,
        children: categoryList
            .map((x) => GestureDetector(
                  child: categoryListViewItem(x),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        QuizCategoryDetailsScreen.routeName,
                        arguments: x);
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget categoryListViewItem(Category category) {
    return Container(
      width: 160,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(category.imagePath),
            width: 130,
          ),
          Text(category.name),
        ],
      ),
    );
  }
}
