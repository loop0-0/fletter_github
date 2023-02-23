import 'package:chaleno/chaleno.dart';
import 'package:html/dom.dart';

Future<void> main(List<String> args) async {
  Scrap koko = new Scrap();
  await koko.scrapData();
//  print(koko.AdresseDefinition);
  print("///////////");
}

class Scrap {
  String mot = "froid";
  dynamic? CatgramDefinition, OrigineDefinition;
  List? AdresseDefinition;
  //Result? Definitions;

  Future<void> scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/" + mot);

    this.AdresseDefinition =
        webpqge?.getElementsByClassName("AdresseDefinition");

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

    // AdresseDefinition?.forEach((element) {
    //   print(element.text?.replaceAll("	", ""));
    // });
    var newAdresseDefinition =
        AdresseDefinition?.map((e) => e.text?.replaceAll("	", ""));
    newAdresseDefinition?.forEach((element) {
      // print(element);
    });

//-------------------------------
    List<Result>? Definitions = [];
    List<Result?> catgramDefinition = [];

    catgramDefinition.addAll(
        webpqge?.querySelectorAll(".CatgramDefinition") as Iterable<Result>);
    print(catgramDefinition.first?.title);
    for (var element in catgramDefinition) {
      print("----------");
      print(element?.text);
    }
    Definitions.addAll(
        webpqge?.getElementsByClassName("Definitions") as Iterable<Result>);

    Result? def = converter(
        "${Definitions[0].html?.replaceAll(">&nbsp;", '><p class="defnitionparagref">').replaceAll("&nbsp;:", "</p>:")}");
    List<Result>? divisionDefinition =
        def.querySelectorAll(".DivisionDefinition");

    List<List<Result>?> exempleDefinition = [];
    List<List<Result>?> titlsynonyme = [];
    List<Result?> paragrafDefinition = [];
    for (var i = 0; i < divisionDefinition!.length; i++) {
      titlsynonyme
          .add(divisionDefinition[i].querySelectorAll(".LibelleSynonyme"));
      exempleDefinition
          .add(divisionDefinition[i].querySelectorAll(".ExempleDefinition"));
      paragrafDefinition
          .add(divisionDefinition[i].querySelector('.defnitionparagref'));
    }

    // for (var i = 0; i < divisionDefinition.length; i++) {
    //   print(paragrafDefinition[i]?.text);
    //   exempleDefinition[i]?.forEach((element) {
    //     print(element.text);
    //   });
    //   titlsynonyme[i]?.forEach((element) {
    //     print(element.text);
    //   });
    //   print("-----------------");
    // }
  }

  //   });
}

Result converter(String html) => Result(Element.html(html));
