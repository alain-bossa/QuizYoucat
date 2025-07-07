import 'package:flutter/material.dart';
import 'package:quiz_youcat/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/SplashScreen.bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: Image(
            image: AssetImage("assets/images/SplashScreen.shape.png"),
          ),
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
                Navigator.pushReplacementNamed(context, SplashScreen.routeName);
              },
            ),
          ]),
    );
  }
}
