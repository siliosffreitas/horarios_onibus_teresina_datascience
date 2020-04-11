import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/map/map_screen.dart';

void main() {
  _registrarDependencias();
  runApp(MyApp());
}

void _registrarDependencias() {
  GetIt.instance.registerSingleton<HomeController>(HomeController());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Horários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: Home(),
      home: MapScreen(),
    );
  }
}
