import 'package:chaleno/chaleno.dart';
import 'package:flutter/material.dart';

import '../coler.dart';
import '../scrap.dart';

class DefinitionsPage extends StatelessWidget {
  const DefinitionsPage({
    super.key,
    required this.definition,
  });

  final Result? definition;

  @override
  Widget build(BuildContext context) {
    List<Result>? Definitions = definition?.querySelectorAll(".Definitions");

    List<Result>? catgramDefinition =
        definition?.querySelectorAll(".CatgramDefinition");

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: Definitions?.length,
      itemBuilder: (context, index) {
        if (Definitions != null) {
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
                      Definitions: Definitions,
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

    List<Result?> paragrafDefinition = [];
    List<Result?> rubriqueDefinition = [];
    List<List<Result>?> exempleDefinition = [];
    List<List<Result>?> titlsynonyme = [];
    List<List<Result>?> synonyme = [];

    for (var i = 0; i < divisionDefinition!.length; i++) {
      paragrafDefinition
          .add(divisionDefinition[i].querySelector('.defnitionparagref'));
      rubriqueDefinition
          .add(divisionDefinition[i].querySelector('.RubriqueDefinition'));
      exempleDefinition
          .add(divisionDefinition[i].querySelectorAll(".ExempleDefinition"));
      titlsynonyme
          .add(divisionDefinition[i].querySelectorAll('.LibelleSynonyme'));
      synonyme.add(divisionDefinition[i].querySelectorAll('.Synonymes'));
    }
    return Column(
      children: [
        for (var j = 0; j < divisionDefinition.length; j++)
          Container(
            //   color: (j % 2 == 0) ? Styles.White : Styles.Grey,
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
                      child: RichText(
                        text: TextSpan(
                          text: paragrafDefinition[j]?.text,
                          style: Styles.normalp,
                          children: <TextSpan>[
                            if (exempleDefinition[j] != null)
                              for (var i = 0;
                                  i < exempleDefinition[j]!.length;
                                  i++)
                                if (i == 0)
                                  TextSpan(
                                      text:
                                          ": ${exempleDefinition[j]?[i].text}",
                                      style:
                                          TextStyle(color: Colors.indigoAccent))
                                else
                                  TextSpan(
                                      text: " ${exempleDefinition[j]?[i].text}",
                                      style: TextStyle(
                                          color: Colors.indigoAccent)),
                            for (var i = 0; i < synonyme[j]!.length; i++)
                              TextSpan(
                                  text: "\n${titlsynonyme[j]?[i].text}",
                                  children: [
                                    TextSpan(
                                      text: " ${synonyme[j]?[i].text}",
                                      style: Styles.redp,
                                    )
                                  ]),
                            TextSpan(text: "\n")
                          ],
                        ),
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
