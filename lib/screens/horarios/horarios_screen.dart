import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/horarios/horario_tile.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class HorariosScreen extends StatefulWidget {
  final String codigoLinha;
  final String codigoParada;

  HorariosScreen({Key key, this.codigoLinha, this.codigoParada})
      : super(key: key);

  @override
  _HorariosScreenState createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen>
    with SingleTickerProviderStateMixin {
  final _homeController = GetIt.instance<HomeController>();

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        List tabKeys = _homeController
            .horarios[widget.codigoLinha][widget.codigoParada].keys
            .toList();

        List<Tab> myTabs = <Tab>[];
        for (String periodo in tabKeys) {
          myTabs.add(Tab(text: periodo.toUpperCase()));
        }

        _tabController = TabController(vsync: this, length: tabKeys.length);

        return Scaffold(
            appBar: AppBar(
              title: Text(
                  "Horários de ${widget.codigoLinha} em ${widget.codigoParada}"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.info),
                  tooltip: "Mais Informações",
                  onPressed: () {
                    String tab = tabKeys.elementAt(_tabController.index);
                    String mensagem = _homeController
                            .horarios[widget.codigoLinha][widget.codigoParada]
                                [tab]['metricas']
                            .replaceAll("       ", "\n")
                            .replaceAll("      ", "\n") +
                        "\n\nÚltima atualização: ${_homeController.horarios[widget.codigoLinha][widget.codigoParada][tab]['ultima_atualizacao']}";

                    dialogAlert(context,
                        title: "Mais Informações", message: mensagem);
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: myTabs,
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: myTabs.map((Tab tab) {
                final String label = tab.text.toLowerCase();

                String horarios = _homeController.horarios[widget.codigoLinha]
                    [widget.codigoParada][label]['horarios'];
                horarios = horarios.replaceAll("[", "");
                horarios = horarios.replaceAll("]", "");
                horarios = horarios.replaceAll("'", "");
                horarios = horarios.replaceAll(" ", "");

                List<String> listHorarios = horarios.split(",");

                return ListView(
                  children:
                      listHorarios.map((e) => HorarioTile(horario: e)).toList(),
                );
              }).toList(),
            ));
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
