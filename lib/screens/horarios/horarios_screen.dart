import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/screens/map/components/loader.dart';
import 'package:horariosonibusapp/screens/horarios/horario_tile.dart';
import 'package:horariosonibusapp/utils/periods.dart';
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
    DateTime proximo = _calcularProximaHora();

    return Observer(
      builder: (_) {
        if (_homeController.previsoes.isEmpty) {
          return Loader();
        }

        List<Periods> keyEnums = [];
        _homeController.previsoes[widget.codigoParada][widget.codigoLinha].keys
            .forEach((key) {
          keyEnums.add(fromStringEnum(Periods.values, key));
        });

        keyEnums.sort((Periods a, Periods b) {
          return a.index.compareTo(b.index);
        });

        List tabKeys = [];
        keyEnums.forEach((Periods element) {
          tabKeys.add(enumToString(Periods.values, element));
        });

        List<Tab> myTabs = <Tab>[];
        for (String periodo in tabKeys) {
          bool b = _verificaSeEhOProximo(proximo) ==
              fromStringEnum(Periods.values, periodo);
          myTabs.add(
            Tab(
              text: "${periodo.toUpperCase()}${b ? " •" : ""}",
            ),
          );
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
              final String label = tab.text.toLowerCase().replaceAll(" •", "");

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
                  return HorarioTile(
                      horario: item,
                      proximo: proximo,
                      period: fromStringEnum(Periods.values, label));
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  DateTime _calcularProximaHora() {
    print("Determinando qual periodo usar primeiramente");

    DateTime now = DateTime.now();
    switch (now.weekday) {
      case 6:
        print("Domingo");
        break;
      case 5:
        print("Sábado");
        break;
      case 4:
        print("Sexta");
        break;
      default:
        print("Seg-Qui");
    }

    return DateTime(2020, 04, 18, 10, 33, 59);
  }

  _verificaSeEhOProximo(DateTime proximo) {
    Periods periodoDoProximo;
    switch (proximo.weekday) {
      case 7:
        periodoDoProximo = Periods.domingo;
        break;
      case 6:
        periodoDoProximo = Periods.sabado;        break;
      default:
        periodoDoProximo = Periods.semana;
    }

    return periodoDoProximo;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
