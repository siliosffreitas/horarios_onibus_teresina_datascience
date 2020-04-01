import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

// This is the class used by rest of your codebase
class HomeController = _HomeController with _$HomeController;

// The store-class
abstract class _HomeController with Store {
  @observable
  Map horarios = {};

  @observable
  RequestState stateRecuperarHorarios;

  @action
  void ordenarLinhas({@required ask = true}) {
    if (horarios != null && horarios.isNotEmpty) {
      if (ask) {
        horarios.keys.toList().sort((a, b) => a.compareTo(b));
      } else {
        horarios.keys.toList().sort((a, b) => b.compareTo(a));
      }
      print(horarios.keys);
    }
  }

  @action
  void recuperarHorarios() {
    stateRecuperarHorarios = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _horariosRef =
        FirebaseDatabase.instance.reference().child('horarios');
    _horariosRef.keepSynced(true);
    _horariosRef.onValue.listen((event) {
      horarios = event.snapshot.value;
      ordenarLinhas();
      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });

//    Future.delayed(const Duration(seconds: 5))
//        .then((value) => stateRecuperarHorarios = RequestState.SUCCESS);
  }
}
