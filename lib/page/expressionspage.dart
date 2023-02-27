import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';

import '../coler.dart';
import '../scrap.dart';

class ExpressionsPage extends StatelessWidget {
  const ExpressionsPage({
    super.key,
    required this.expression,
  });

  final Result? expression;

  @override
  Widget build(BuildContext context) {
    List<Result>? Expressions = expression?.querySelectorAll(".ListeLocutions");

    List<Result>? catgramDefinition =
        expression?.querySelectorAll(".CatgramDefinition");

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: Expressions?.length,
      itemBuilder: (context, index) {
        if (Expressions != null) {
          return ListTile(
            title: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Styles.White,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "[${catgramDefinition![index].text?.toTitleCase()}]",
                      style: Styles.redp,
                    ),
                    DefinitionShow(
                      Expressions: Expressions,
                      index: index,
                    ),
                  ],
                )),
          );
        }
      },
    );
  }
}

class DefinitionShow extends StatelessWidget {
  const DefinitionShow({
    super.key,
    required this.Expressions,
    required this.index,
  });

  final int index;
  final List<Result>? Expressions;

  @override
  Widget build(BuildContext context) {
    List<Result>? exp = Expressions?[index].querySelectorAll(".Locution");
    List<Result?> adresseLocution = [];
    List<Result?> rubriqueDefinition = [];
    List<Result?> texteLocution = [];
    List<Result?> indicateurLocution = [];
    List<List<Result?>?> exempleDefinition = [];

    List<Map<String, HighlightedWord>> words = [];
    for (var i = 0; i < exp!.length; i++) {
      Map<String, HighlightedWord> word = {};
      texteLocution.add(exp[i].querySelector(".TexteLocution"));
      rubriqueDefinition.add(exp[i].querySelector('.RubriqueDefinition'));

      ///
      indicateurLocution.add(exp[i].querySelector(".IndicateurLocution"));
      word.addAll({
        "${indicateurLocution[i]?.text}": HighlightedWord(
            textStyle: TextStyle(color: Colors.redAccent, fontSize: 15))
      });

      ///
      adresseLocution.add(exp[i].querySelector(".AdresseLocution"));
      word.addAll({
        "${adresseLocution[i]?.text?.replaceFirst("${indicateurLocution[i]?.text}", "")}":
            HighlightedWord(
                textStyle: TextStyle(color: Colors.indigoAccent, fontSize: 15))
      });

      ///

      exempleDefinition.add(exp[i].querySelectorAll(".ExempleDefinition"));
      exempleDefinition[i]?.forEach((elo) {
        word.addAll({"${elo?.text}": HighlightedWord(textStyle: Styles.redp)});
      });

      words.add(word);
    }

    return Column(
      children: [
        for (var j = 0; j < exp.length; j++)
          Container(
            //  color: (j % 2 == 0) ? Styles.White : Styles.Grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (rubriqueDefinition[j] != null)
                  Text(
                    "   ${rubriqueDefinition[j]?.text}",
                    style: Styles.redp,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 0, child: Text("${j + 1}. ")),
                    Expanded(
                      flex: 4,
                      child: TextHighlight(
                        text:
                            "${adresseLocution[j]?.text?.replaceAll("", "")}${texteLocution[j]?.text}\n",
                        words: words[j],
                        textStyle: Styles.normalp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
