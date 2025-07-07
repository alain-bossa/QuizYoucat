import 'package:flutter/material.dart';

class ThemeHelper {
  static Color primaryColor = const Color.fromARGB(255, 20, 154, 198);
  static Color accentColor =  Color(0xff20aebe);
  static Color shadowColor = Color(0xffa2a6af);

  static ThemeData getThemeData() {
    return ThemeData(
      fontFamily: 'Baloo',
      primarySwatch: Colors.deepPurple,
      colorScheme:
          ColorScheme.light(primary: Colors.deepPurple, secondary: Colors.teal),
      textTheme: TextTheme(
          displaySmall: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          ),
          headlineMedium: TextStyle(
            color: accentColor,
            fontFamily: 'Baloo',
          )),
    );
  }

  static BoxDecoration fullScreenBgBoxDecoration(
      {String backgroundAssetImage = "assets/images/Common.bg.png"}) {
    return BoxDecoration(
      image: DecorationImage(
          image: AssetImage(backgroundAssetImage), fit: BoxFit.cover),
    );
  }

  static roundBoxDeco({Color color = Colors.white, double radius = 15}) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }
}
