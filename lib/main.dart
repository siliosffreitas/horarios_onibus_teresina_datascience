import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/screens/map/map_screen.dart';
import 'package:horariosonibusapp/screens/termos/stores/termos_store.dart';
import 'package:horariosonibusapp/screens/termos/termos_screen.dart';

void main() {
  _registrarDependencias();
  runApp(MyApp());
}

void _registrarDependencias() {
  GetIt.instance.registerSingleton<HomeController>(HomeController());
  GetIt.instance.registerSingleton<TermosStore>(TermosStore());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _termosController = GetIt.instance<TermosStore>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _termosController.verificarSeAceitouOsTermos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Horários',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Observer(
          builder: (_) {
            if (_termosController.aceitouOsTermos == null)
              return Scaffold(
                appBar: AppBar(),
                body: Container(),
              );
            if (!_termosController.aceitouOsTermos) return TermosScreen();
            return MapScreen();
          },
        ));
  }
}
