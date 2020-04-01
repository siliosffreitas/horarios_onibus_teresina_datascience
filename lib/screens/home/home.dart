import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/screens/home/error_message_screen.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/linha_tile.dart';
import 'package:horariosonibusapp/screens/home/loader.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Linhas"),
          actions: <Widget>[
            Observer(
              builder: (_) {
                switch (_homeController.stateRecuperarHorarios) {
                  case RequestState.LOADING:
                    return Container();
                  default:
                    return IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        _homeController.recuperarHorarios();
                      },
                    );
                }
              },
            )
          ],
        ),
        body: Observer(
          builder: (_) {
            switch (_homeController.stateRecuperarHorarios) {
              case RequestState.LOADING:
                return Loader();
              case RequestState.FAIL:
                return ErrorMessageScreen();
              case RequestState.SUCCESS:
                return ListView(
                  children: _homeController.horarios.keys
                      .map((horarioKey) => LinhaTile(codigoLinha: horarioKey))
                      .toList(),
                );
              default:
                return Container();
            }
          },
        ));
  }
}
