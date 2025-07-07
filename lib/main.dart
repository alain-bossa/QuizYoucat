import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_youcat/common/route_generator.dart';
import 'package:desktop_window/desktop_window.dart';
import 'common/theme_helper.dart';
import 'stores/quiz_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   // if (Platform.isWindows) {
   //   DesktopWindow.setWindowSize(Size(1000,1000));
   //   //DesktopWindow.setFullScreen(true);
   // }
  await QuizStore.initPrefs();
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz App',
      theme: ThemeHelper.getThemeData(),
      debugShowCheckedModeBanner: false,  // enleve la banniere debug sur l'application
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
