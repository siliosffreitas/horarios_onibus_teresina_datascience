import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/screens/map/components/loader.dart';
import 'package:horariosonibusapp/screens/horarios/horario_tile.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class HorariosScreen extends StatefulWidget {
  final String codigoLinha;
  final String codigoParada;

  HorariosScreen(
      {Key key, @required this.codigoLinha, @required this.codigoParada})
      : super(key: key);

  @override
  _HorariosScreenState createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen>
    with TickerProviderStateMixin {
  final _homeController = GetIt.instance<HomeController>();

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (_homeController.previsoes.isEmpty) {
          return Loader();
        }
        List tabKeys = _homeController
            .previsoes[widget.codigoParada][widget.codigoLinha].keys
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
                icon: Icon(Icons.info_outline),
                tooltip: "Mais Informações",
                onPressed: () {
                  String tab = tabKeys.elementAt(_tabController.index);
                  String mensagem = _homeController
                          .previsoes[widget.codigoParada][widget.codigoLinha]
                              [tab]['metricas']
                          .replaceAll("       ", "\n")
                          .replaceAll("      ", "\n") +
                      "\n\nÚltima atualização: ${_homeController.previsoes[widget.codigoParada][widget.codigoLinha][tab]['ultima_atualizacao']}";

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

              String horarios = _homeController.previsoes[widget.codigoParada]
                  [widget.codigoLinha][label]['horarios'];
              horarios = horarios.replaceAll("[", "");
              horarios = horarios.replaceAll("]", "");
              horarios = horarios.replaceAll("'", "");
              horarios = horarios.replaceAll(" ", "");

              List<String> listHorarios = horarios.split(",");

              var _crossAxisSpacing = 8;
              var _screenWidth = MediaQuery.of(context).size.width;
              var _crossAxisCount = 2;
              var _width =
                  (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
                      _crossAxisCount;
              var cellHeight = 60;
              var _aspectRatio = _width / cellHeight;

              return GridView.builder(
                padding:
                    EdgeInsets.only(left: 5.0, right: 5.0, top: 10, bottom: 10),
                shrinkWrap: false,
                itemCount: listHorarios.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _crossAxisCount,
                    childAspectRatio: _aspectRatio),
                itemBuilder: (context, index) {
                  final item = listHorarios[index];
                  return HorarioTile(horario: item);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
