import 'package:chaleno/chaleno.dart';

Future<void> main(List<String> args) async {
  Scrap koko = new Scrap();
  await koko.scrapData();
  print(koko.AdresseDefinition);
  print("///////////");
}

class Scrap {
  String mot = "peux";
  dynamic? AdresseDefinition, CatgramDefinition, OrigineDefinition, Definitions;

  Future<void> scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/" + mot);
    this.AdresseDefinition = webpqge
        ?.getElementsByClassName("AdresseDefinition")
        .first
        .text
        ?.replaceAll("	", "");
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
    //print(AdresseDefinition);
    //print(CatgramDefinition);
    // print(OrigineDefinition);
//-------------------------------
    Definitions = webpqge?.getElementsByClassName("DivisionDefinition");
    //  print(Definitions);
  }
}
