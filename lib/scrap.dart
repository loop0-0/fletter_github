import 'package:chaleno/chaleno.dart';
import 'package:html/dom.dart';

Future<void> main(List<String> args) async {
  Scrap koko = new Scrap();
  await koko.scrapData();
  print(koko.AdresseDefinition);
  print("///////////");
}

class Scrap {
  String mot = "peux";
  dynamic? AdresseDefinition, CatgramDefinition, OrigineDefinition;
  //Result? Definitions;

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
    print(AdresseDefinition);
    print(CatgramDefinition);
    print(OrigineDefinition);
//-------------------------------

    var Definitions = Result(Element.html(
        "${webpqge?.getElementsByClassName("DivisionDefinition").first.html?.replaceFirst("&nbsp;", '<p class="defnitionparagref">').replaceFirst("&nbsp;", "</p>")}"));
    // Definitions?.forEach((element) {
    //print(Definitions.querySelector('.LibelleSynonyme')?.text);
    //print(Definitions.querySelector('.Synonymes')?.text);
    //print(Definitions.querySelector('.numDef')?.text);
    //  print(Definitions.querySelector('.ExempleDefinition')?.text);
    //  print(Definitions.querySelector('.defnitionparagref')?.text);
    print(Definitions.html);

    //   });
  }
}

Result converter(String html) => Result(Element.html(html));
