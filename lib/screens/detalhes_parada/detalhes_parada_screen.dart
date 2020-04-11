import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/linha_tile.dart';
import 'package:horariosonibusapp/screens/horarios/horarios_screen.dart';
import 'package:horariosonibusapp/utils/sort.dart';

class DetalheParadaScreen extends StatelessWidget {
  final _homeController = GetIt.instance<HomeController>();

  final String codigoParada;

  DetalheParadaScreen({Key key, this.codigoParada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linhas de ${codigoParada}"),
      ),
      body: Observer(
        builder: (_) {
          List linhas = _homeController.previsoes[codigoParada].keys.toList();
          if (_homeController.sortOption == SortOption.ASK) {
            linhas.sort((a, b) => a.compareTo(b));
          } else {
            linhas.sort((a, b) => b.compareTo(a));
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: linhas
                .map((linhaKey) => LinhaTile(
                      codigoLinha: linhaKey,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HorariosScreen(
                                  codigoLinha: linhaKey,
                                  codigoParada: codigoParada,
                                )));
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
