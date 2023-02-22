import 'package:fletter_github/coler.dart';
import 'package:fletter_github/scrap.dart';
import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:scroll_navigation/scroll_navigation.dart';

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
  List<Result>? Definitions = [];

  void scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/froid");
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
    Definitions?.addAll(
        webpqge?.getElementsByClassName("Definitions") as Iterable<Result>);
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
                  child: DefinitionsPage(Definitions: Definitions),
                ),
                Container(color: Colors.green[100]),
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

class DefinitionsPage extends StatelessWidget {
  const DefinitionsPage({
    super.key,
    required this.Definitions,
  });

  final List<Result>? Definitions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: Definitions?.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Styles.White,
              ),
              child: DefinitionShow(Definitions: Definitions, index: index)),
        );
      },
    );
  }
}

class DefinitionShow extends StatelessWidget {
  DefinitionShow({
    super.key,
    required this.Definitions,
    required this.index,
  });
  final int index;
  final List<Result>? Definitions;

  @override
  Widget build(BuildContext context) {
    Result? def = converter(
        "${Definitions?[index].html?.replaceAll(">&nbsp;", '><p class="defnitionparagref">').replaceAll("&nbsp;:", "</p>:")}");
    List<Result>? divisionDefinition =
        def.querySelectorAll(".DivisionDefinition");
    List? titlsynonyme;
    List? synonyme;
    List? exempleDefinition;
    List? paragrafDefinition;
    int l = 0;
    for (var ele in divisionDefinition!) {
      exempleDefinition?.add(ele.querySelector('.ExempleDefinition'));
      titlsynonyme?[l] = ele.querySelector('.LibelleSynonyme');
      synonyme?[l] = ele.querySelector('.Synonymes');
      paragrafDefinition?[l] = ele.querySelector('.defnitionparagref');
    }

    return Column(
      children: [
        for (var j = 0; j < divisionDefinition.length; j++)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 0,
                child: Text("${j + 1}. "),
              ),
              Expanded(
                flex: 4,
                child: RichText(
                  text: TextSpan(
                    text: "${paragrafDefinition![j].text}",
                    style: Styles.normalp,
                    children: <TextSpan>[
                      if (exempleDefinition![j] != null)
                        TextSpan(
                            text: ": ${exempleDefinition[j]}",
                            style: TextStyle(color: Colors.indigoAccent)),
                      /* for (var i = 0; i < synonyme!.length; i++)
                        TextSpan(text: "\n${titlsynonyme![i].text}", children: [
                          TextSpan(
                              text: " ${synonyme[i].text}", style: Styles.redp)
                        ]),
                      // ,*/
                    ],
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
