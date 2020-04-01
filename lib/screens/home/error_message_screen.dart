import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';

class ErrorMessageScreen extends StatelessWidget {
  final _homeController = GetIt.instance<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "Algum erro ao tentar recuperar horários",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
            child: Text("Tentar novamente"),
            onPressed: () {
              _homeController.recuperarHorarios();
            },
          ),
        ],
      ),
    );
  }
}
