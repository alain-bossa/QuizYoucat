import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_youcat/common/alert_util.dart';
import 'package:quiz_youcat/common/theme_helper.dart';
import 'package:quiz_youcat/widgets/disco_button.dart';

import 'quiz_category.dart';
import 'quiz_history_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  static String animateur = "non";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: navigationDrawer(),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              Column(
                children: [
                  headerText("Quiz YouCat & Bible"),
                  SizedBox(height: 32),
                  ...homeScreenButtons(context),
                  bottomText(" _______"),
                  bottomText(
                    "   Se plaindre que Dieu est silencieux quand ta Bible est fermée, c'est comme se plaindre de ne pas recevoir de messages quand ton téléphone est éteint.",
                  )
                ],
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
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
              ),
            ]),
      ),
    );
  }

  Drawer navigationDrawer() {
    var modeAnim = "Mode animateur = " + HomeScreen.animateur;
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
        children: [
          SizedBox(
            height: 130,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(
                    color: Colors.black26,
                    width: 8,
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    "Quiz YouCat et Biblique",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Text(
                    "Version: 1.10",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Ecran d accueil'),
              onTap: () {
                Navigator.pushReplacementNamed(context, HomeScreen.routeName);
              },
            ),
          ),
          // ListTile(
          //   title: const Text('Lancer le Quiz toutes catégories'),
          //   onTap: () async {
          //     var quiz = await _quizStore.getRandomQuizAsync();
          //     Navigator.pushNamed(context, "/quiz", arguments: quiz);
          //   },
          // ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Catégorie de Quiz'),
              onTap: () {
                Navigator.pushNamed(context, QuizCategoryScreen.routeName);
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Historique des Quiz'),
              onTap: () {
                Navigator.pushNamed(context, QuizHistoryScreen.routeName);
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: Divider(
              thickness: 4,
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: Text("Activer le mode animateur"),
              onTap: () {
                HomeScreen.animateur = "oui";
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: Text("Enlever le mode animateur"),
              onTap: () {
                HomeScreen.animateur = "non";
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: Divider(
              thickness: 4,
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Notre Père'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Notre Père",
                    "Notre Père, qui es aux cieux, \n"
                        "que ton nom soit sanctifié, \n"
                        "que ton règne vienne, \n"
                        "que ta volonté soit faite sur la terre comme au ciel. \n"
                        "Donne-nous aujourd’hui notre pain de ce jour. \n"
                        "Pardonne-nous nos offenses, \n"
                        "comme nous pardonnons aussi à ceux qui nous ont offensés. \n"
                        "Et ne nous laisse pas entrer en tentation \n"
                        "mais délivre-nous du Mal.");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Je vous salue Marie'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Je vous salue Marie",
                    "Je vous salue Marie, pleine de grâce ; \n"
                        "Le Seigneur est avec vous. \n"
                        "Vous êtes bénie entre toutes les femmes \n"
                        "Et Jésus, le fruit de vos entrailles, est béni. \n"
                        "Sainte Marie, Mère de Dieu, \n"
                        "Priez pour nous pauvres pécheurs, \n"
                        "Maintenant et à l’heure de notre mort.");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('CREDO'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Je crois en Dieu",
                    "Je crois en Dieu,"
                        "le Père tout-puissant, \n"
                        "créateur du ciel et de la terre ; \n"
                        "et en Jésus-Christ, \n"
                        "son Fils unique, notre Seigneur, \n"
                        "qui a été conçu du Saint-Esprit, \n"
                        "est né de la Vierge Marie, \n"
                        "a souffert sous Ponce Pilate, \n"
                        "a été crucifié, \n"
                        "est mort et a été enseveli, \n"
                        "est descendu aux enfers, \n"
                        "le troisième jour est ressuscité des morts, \n"
                        "est monté aux cieux, \n"
                        "est assis à la droite de Dieu le Père tout-puissant, \n"
                        "d’où il viendra juger les vivants et les morts. \n"
                        "Je crois en l’Esprit-Saint, \n"
                        "à la sainte Eglise catholique, \n"
                        "à la communion des saints, \n"
                        "à la rémission des péchés, \n"
                        "à la résurrection de la chair, \n"
                        "à la vie éternelle.");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Je confesse à Dieu'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Je confesse à Dieu",
                    "Je confesse à Dieu tout-puissant,"
                        "Je reconnais devant vous, frères et sœurs, \n"
                        "que j’ai péché en pensée, en parole, \n"
                        "par action et par omission ; \n"
                        "oui, j’ai vraiment péché. \n"
                        "C’est pourquoi je supplie la bienheureuse Vierge Marie, \n"
                        "les anges et tous les saints, \n"
                        "et vous aussi, frères et sœurs, \n"
                        "de prier pour moi le Seigneur notre Dieu.");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Chapelet'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Le chapelet (le Rosaire est un ensemble de 4 chapelets médités à l'aide des mystères du Rosaire)",
                    "Sur la croix du chapelet, faites le signe de croix et dites-le °Je crois en Dieu°, \n"
                        "récitez un °Notre Père°, 3 °Je vous salue Marie° (pour les 3 vertus théologales) et 1 °Gloire au Père°, \n"
                        "méditez 5 mystères sur les 5 dizaines : 1 °Notre Père°, 10 °Je vous salue Marie°, 1 °Gloire au Père°.");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: Divider(
              thickness: 4,
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('A propos'),
              onTap: () {
                AlertUtil.showAlert(
                    context,
                    "Quiz à but éducatif et religieux",
                    "Les réponses aux questionnaires Youcat sont tirées du Youcat. \n"
                        "Ce quiz vient en complément du Youcat pour vérifier et s'assurer de l'acquisition de cette formation. \n"
                        "Formation à la confirmation : Youcat orange \n"
                        "Formations aux sacrements (Baptême et 1ere communion) : Youcat jaune \n\n"
                        "Conçu à partir d'un logiciel tutoriel sur le langage flutter (https://flutter.dev/docs/get-started/codelab), modifié et amélioré pour répondre aux besoins de la paroisse par A. Cressot \n"
                        "\n Le mode animateur permet de mettre les questions dans l'ordre et met une tempo très grande.\n"
                        "Ce logiciel est Freeware. Il peut être distribué librement. \n"
                        "Le texte contenu ne doit pas être modifié. \n © 2024  AC");
              },
            ),
          ),
          SizedBox(
            height: 35,
            child: ListTile(
              title: const Text('Quitter le programme'),
              onTap: () {
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 36,
          color: ThemeHelper.accentColor,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: ThemeHelper.shadowColor,
                offset: Offset(-5, 5),
                blurRadius: 30)
          ]),
    );
  }

  Text bottomText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 28,
          color: Colors.black45,
          fontWeight: FontWeight.normal,
          shadows: [
            Shadow(
              color: ThemeHelper.primaryColor,
            )
          ]),
    );
  }

  List<Widget> homeScreenButtons(BuildContext context) {
    return [
      // DiscoButton(
      //   onPressed: () async {
      //     var quiz = await _quizStore.getRandomQuizAsync();
      //     Navigator.pushNamed(context, QuizScreen.routeName, arguments: quiz);
      //   },
      //   child: Text(
      //     "Quiz toutes catégories",
      //     style: TextStyle(fontSize: 20, color: ThemeHelper.primaryColor),
      //   ),
      // ),
      DiscoButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizCategoryScreen.routeName);
        },
        child: Text(
          "Quiz par catégorie",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        isActive: true,
      ),
      DiscoButton(
        onPressed: () {
          Navigator.pushNamed(context, QuizHistoryScreen.routeName);
        },
        child: Text(
          "Historique des Quiz",
          style: TextStyle(fontSize: 20, color: ThemeHelper.primaryColor),
        ),
      ),
    ];
  }
}
