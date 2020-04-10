import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/data/sharedprefs/sort_pref.dart';
import 'package:horariosonibusapp/models/parada.dart';
import 'package:horariosonibusapp/utils/sort.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

// This is the class used by rest of your codebase
class HomeController = _HomeController with _$HomeController;

// The store-class
abstract class _HomeController with Store {
  @observable
  Map horarios = {};

  @observable
  List<Parada> paradas = [];

  @observable
  SortOption sortOption = SortOption.ASK;

  @observable
  RequestState stateRecuperarHorarios;

  @observable
  RequestState stateRecuperarParadas;

  _HomeController() {
    readSort().then((sort) {
//      print(sort);
//      if (sort == null) {
//        sortOption = SortOption.ASK;
//      } else {
//        try {
//          SortOption.values.firstWhere((s) => s.toString() == sort);
//        } catch (e) {
//          sortOption = SortOption.ASK;
//        }
//      }
    }).catchError((err) {
      sortOption = SortOption.ASK;
    });
  }

  @action
  void mudarOrdenacao() {
    if (sortOption == SortOption.ASK) {
      sortOption = SortOption.DESK;
    } else {
      sortOption = SortOption.ASK;
    }
//    print(sortOption.toString());
    saveSort(sortOption.toString()).then((value) => print(value));
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
//      print(event.snapshot.value);
      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });

//    Future.delayed(const Duration(seconds: 5))
//        .then((value) => stateRecuperarHorarios = RequestState.SUCCESS);
  }

  @action
  void recuperarParadas() {
    stateRecuperarParadas = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _paradasRef =
        FirebaseDatabase.instance.reference().child('paradas');
    _paradasRef.keepSynced(true);

//    _paradasRef.once().then((DataSnapshot snapshot) {
//      print("A");
//      print('Connected to second database and read ${snapshot.value}');
//      print("B");
//      stateRecuperarParadas = RequestState.SUCCESS;
//    }).catchError((Object o) {
//      print("Erro $o");
//      stateRecuperarParadas = RequestState.FAIL;
//    });

    _paradasRef.onValue.listen((event) {
      print("A");
//      print(event.snapshot.value);
      print('-------');
//      print('Connected to second database and read ${snapshot.value}');

      for (Map parada in event.snapshot.value) {
        if (parada != null) {
          Parada p = Parada(
              codigoParada: parada['codigo'],
              lat: parada['lat'],
              long: parada['long'],
              endereco: parada['endereco'],
              denominacao: parada['denominacao']);

          paradas.add(p);
        }
      }
      print(paradas.length);
      stateRecuperarParadas = RequestState.SUCCESS;
      print("B");
    }, onError: (Object o) {
      print("Erro $o");
      stateRecuperarParadas = RequestState.FAIL;
    });
  }
}
