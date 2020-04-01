import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/screens/home/error_message_screen.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
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
        ),
        body: Observer(
          builder: (_) {
            switch (_homeController.stateRecuperarHorarios) {
              case RequestState.LOADING:
                return Loader();
              case RequestState.FAIL:
                return ErrorMessageScreen();
              case RequestState.SUCCESS:
                return Container(
                  child: Center(
                    child: Text("Tudo certo!"),
                  ),
                );
              default:
                return Container();
            }
          },
        ));
  }
}
