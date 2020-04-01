import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/horarios/horario_tile.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class HorariosScreen extends StatelessWidget {
  final String codigoLinha;
  final String codigoParada;

  final _homeController = GetIt.instance<HomeController>();

  HorariosScreen({Key key, this.codigoLinha, this.codigoParada})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List paradas = _homeController.horarios[codigoLinha].keys.toList();
    paradas.sort((a, b) => int.parse(a).compareTo(int.parse(b)));
    return Scaffold(
      appBar: AppBar(
        title: Text("Horários de ${codigoLinha} em ${codigoParada}"),
        actions: <Widget>[
          Observer(
            builder: (_) {
              String mensagem = _homeController.horarios[codigoLinha]
                          [codigoParada]['metricas']
                      .replaceAll("       ", "\n")
                      .replaceAll("      ", "\n") +
                  "\n\nÚltima atualização: ${_homeController.horarios[codigoLinha][codigoParada]['ultima_atualizacao']}";
              return IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  dialogAlert(context,
                      title: "Mais Informações", message: mensagem);
                },
              );
            },
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          String horarios =
              _homeController.horarios[codigoLinha][codigoParada]['horarios'];
          horarios = horarios.replaceAll("[", "");
          horarios = horarios.replaceAll("]", "");
          horarios = horarios.replaceAll("'", "");
          horarios = horarios.replaceAll(" ", "");

          List<String> listHorarios = horarios.split(",");

          return ListView(
            children: listHorarios.map((e) => HorarioTile(horario: e)).toList(),
          );
        },
      ),
    );
  }
}
