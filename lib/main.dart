import 'package:fletter_github/coler.dart';
import 'package:fletter_github/scrap.dart';
import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

import 'page/definitionspage.dart';
import 'page/expressionspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: const Homep(),
    );
  }
}

class Homep extends StatefulWidget {
  const Homep({super.key});

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Zone_Entree1(),
      ),
      backgroundColor: Styles.Grey,
    );
  }
}

class Zone_Entree1 extends StatefulWidget {
  const Zone_Entree1({super.key});

  @override
  State<Zone_Entree1> createState() => _Zone_Entree1State();
}

class _Zone_Entree1State extends State<Zone_Entree1> {
  String? AdresseDefinition, CatgramDefinition, OrigineDefinition;

  Result? definition, expression;

  void scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/chaud");
    this.AdresseDefinition = webpqge
        ?.getElementsByClassName("AdresseDefinition")
        .first
        .text
        ?.replaceAll("	", "")
        .replaceAll("\n", "");
    this.CatgramDefinition = webpqge
        ?.getElementsByClassName("CatgramDefinition")
        .first
        .text
        ?.replaceAll("	", "");
    this.OrigineDefinition = webpqge
        ?.getElementsByClassName("OrigineDefinition")
        .first
        .text
        ?.replaceAll("	", "");
//-------------------------------
    definition = webpqge?.getElementById("definition");
    expression = webpqge?.getElementById("locution");

    setState(() {});
  }

  @override
  void initState() {
    scrapData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Styles.Navy,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$AdresseDefinition',
                      overflow: TextOverflow.ellipsis, style: Styles.word),
                  Icon(
                    Icons.volume_up,
                    color: Styles.Red,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  '$CatgramDefinition',
                  style: Styles.redp,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: SizedBox(
            height: 800,
            width: double.infinity,
            child: TitleScrollNavigation(
              showIdentifier: false,
              bodyStyle: NavigationBodyStyle(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              barStyle: TitleNavigationBarStyle(
                background: Styles.Grey,
                style: Styles.grantitel,
                deactiveColor: Color.fromARGB(255, 199, 198, 198),
                activeColor: Styles.Dark,
                elevation: 0.0,
              ),
              pages: [
                Container(
                  child: DefinitionsPage(definition: definition),
                ),
                Container(
                  child: ExpressionsPage(expression: expression),
                ),
                Container(color: Colors.purple[100]),
                Container(color: Colors.green[100]),
                Container(color: Colors.purple[100]),
              ],
              titles: [
                "Définitions",
                "Expressions",
                "Homonymes",
                "Définitions",
                "Expressions"
              ],
            ),
          ),
        ),
      ],
    );
  }
}
