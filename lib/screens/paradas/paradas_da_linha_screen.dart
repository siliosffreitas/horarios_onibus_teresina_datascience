import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/paradas/parada_tile.dart';

class ParadasDaLinhaScreen extends StatelessWidget {
  final String codigoLinha;

  final _homeController = GetIt.instance<HomeController>();

  ParadasDaLinhaScreen({Key key, this.codigoLinha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paradas de $codigoLinha"),
      ),
      body: Observer(
        builder: (_) {
          List paradas = _homeController.horarios[codigoLinha].keys.toList();
          paradas.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
          return ListView(
            children: paradas
                .map((horarioKey) => ParadaTile(
                    codigoParada: horarioKey, codigoLinha: codigoLinha))
                .toList(),
          );
        },
      ),
    );
  }
}
