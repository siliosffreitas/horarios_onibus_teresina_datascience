import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/linha_tile.dart';
import 'package:horariosonibusapp/utils/sort.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class LineSearch extends SearchDelegate<String> {
  final _homeController = GetIt.instance<HomeController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List linhas = _homeController.horarios.keys.toList();
    if (_homeController.sortOption == SortOption.ASK) {
      linhas.sort((a, b) => a.compareTo(b));
    } else {
      linhas.sort((a, b) => b.compareTo(a));
    }

    if (query == null || query.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: linhas
            .map((horarioKey) => LinhaTile(
                codigoLinha: horarioKey,
                onTap: () {
                  close(context, horarioKey);
                }))
            .toList(),
      );
    }

    List linhasEncontradas = linhas
        .where((linha) =>
            removeDiacritics(linha).contains(removeDiacritics(query)))
        .toList();

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: linhasEncontradas
          .map((horarioKey) => LinhaTile(
                codigoLinha: horarioKey,
                onTap: () {
                  close(context, horarioKey);
                },
              ))
          .toList(),
    );
  }

  suggestions(String search) {}
}
