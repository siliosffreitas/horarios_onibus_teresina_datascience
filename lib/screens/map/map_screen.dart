import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/screens/home/custom_drawer.dart';
import 'package:horariosonibusapp/screens/home/error_message_screen.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/loader.dart';
import 'package:horariosonibusapp/screens/paradas/parada_tile.dart';
import 'package:horariosonibusapp/utils/sort.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _homeController = GetIt.instance<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.recuperarHorarios();
    _homeController.recuperarLinhas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paradas"),
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
              List paradas = _homeController.previsoes.keys.toList();
              if (_homeController.sortOption == SortOption.ASK) {
                paradas.sort((a, b) => a.compareTo(b));
              } else {
                paradas.sort((a, b) => b.compareTo(a));
              }

              return RefreshIndicator(
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: paradas
                      .map((paradaKey) => ParadaTile(
                            codigoParada: paradaKey,
//                      onTap: () {
//                        Navigator.of(context).push(MaterialPageRoute(
//                            builder: (context) => ParadasDaLinhaScreen(
//                                codigoLinha: horarioKey)));
//                      },
                          ))
                      .toList(),
                ),
                onRefresh: _handleRefresh,
              );

            default:
              return Container();
          }
        },
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    _homeController.recuperarHorarios();

    return null;
  }
}
