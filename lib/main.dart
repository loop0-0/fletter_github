import 'package:fletter_github/scrap.dart';
import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';

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
        ));
  }
}

class Zone_Entree1 extends StatefulWidget {
  const Zone_Entree1({super.key});

  @override
  State<Zone_Entree1> createState() => _Zone_Entree1State();
}

class _Zone_Entree1State extends State<Zone_Entree1> {
  String? AdresseDefinition, CatgramDefinition, OrigineDefinition;
  List? Definitions = [];

  void scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/peux");
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
        webpqge?.getElementsByClassName("DivisionDefinition") as Iterable);
    //  print(Definitions);
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.radio_button_on_outlined,
              color: Color.fromARGB(255, 219, 19, 19),
              size: 24,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$AdresseDefinition',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 37, 36, 63)),
                ),
                Text(
                  '$CatgramDefinition',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 76, 71, 224)),
                ),
                Text(
                  '$OrigineDefinition',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 83, 83, 92)),
                )
              ],
            ),
          ],
        ),
        if (Definitions != null)
          ListView.builder(
            shrinkWrap: true,
            reverse: true,
            scrollDirection: Axis.vertical,
            itemCount: Definitions?.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(Definitions?[index].text),
              );
            },
          ),
      ],
    );
  }
}
