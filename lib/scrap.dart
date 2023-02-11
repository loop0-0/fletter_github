import 'package:chaleno/chaleno.dart';

void main(List<String> args) {
  Scrap().scrapData();
}

class Scrap {
  String mot = "peux";
  List? AdresseDefinition, CatgramDefinition, OrigineDefinition;
  dynamic? Definitions = [];
  void scrapData() async {
    var webpqge = await Chaleno()
        .load("https://www.larousse.fr/dictionnaires/francais/" + mot);
    AdresseDefinition = webpqge?.getElementsByClassName("AdresseDefinition");

    //subscribeCount = webpqge?.querySelector("#name=description").text;
    //img = webpqge?.querySelector('.jsx-1373700303 img').src;
    //print(webpqge?.html);
    AdresseDefinition?.forEach((element) {
      print(element.text);
    });
    print(AdresseDefinition);
    //print(subscribeCount);
  }
}
