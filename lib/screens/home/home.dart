import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/screens/home/custom_drawer.dart';
import 'package:horariosonibusapp/screens/home/delegate/line_search.dart';
import 'package:horariosonibusapp/screens/home/error_message_screen.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/linha_tile.dart';
import 'package:horariosonibusapp/screens/home/loader.dart';
import 'package:horariosonibusapp/screens/paradas/paradas_da_linha_screen.dart';
import 'package:horariosonibusapp/utils/sort.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeController = GetIt.instance<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.recuperarHorarios();
  }

  _callSearch(String term) async {
    String result =
    await showSearch(context: context, delegate: LineSearch(), query: term);

    if (result != null) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ParadasDaLinhaScreen(codigoLinha: result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Linhas"),
          actions: <Widget>[
            IconButton(
              icon: Observer(
                builder: (_) {
                  switch (_homeController.sortOption) {
                    case SortOption.ASK:
                      return Icon(Icons.arrow_drop_up);
                    default:
                      return Icon(Icons.arrow_drop_down);
                  }
                },
              ),
              onPressed: () {
                _homeController.mudarOrdenacao();
              },
              tooltip: "Modificar Ordenação",
            ),
            Observer(
              builder: (_) {
                switch (_homeController.stateRecuperarHorarios) {
                  case RequestState.LOADING:
                    return Container();
                  default:
                    return IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        _callSearch(null);
                      },
                      tooltip: "Pesquisar linha",
                    );
                }
              },
            )
          ],
        ),
        drawer: CustomDrawer(),
        body: Observer(
          builder: (_) {
            switch (_homeController.stateRecuperarHorarios) {
              case RequestState.LOADING:
                return Loader();
              case RequestState.FAIL:
                return ErrorMessageScreen();
              case RequestState.SUCCESS:
                List linhas = _homeController.horarios.keys.toList();
                if (_homeController.sortOption == SortOption.ASK) {
                  linhas.sort((a, b) => a.compareTo(b));
                } else {
                  linhas.sort((a, b) => b.compareTo(a));
                }

                return RefreshIndicator(
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: linhas
                        .map((horarioKey) => LinhaTile(
                              codigoLinha: horarioKey,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ParadasDaLinhaScreen(
                                        codigoLinha: horarioKey)));
                              },
                            ))
                        .toList(),
                  ),
                  onRefresh: _handleRefresh,
                );

              default:
                return Container();
            }
          },
        ));
  }

  Future<Null> _handleRefresh() async {
    _homeController.recuperarHorarios();

    return null;
  }
}
