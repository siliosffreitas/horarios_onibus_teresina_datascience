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
  Map previsoes = {};

  @observable
  Map linhas = {};

  @observable
  Map paradas = {};

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
      _convertendoMapaParaKeyDeParada();

      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });
  }

  @action
  void recuperarLinhas() {
    stateRecuperarHorarios = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _horariosRef =
        FirebaseDatabase.instance.reference().child('linhas');
    _horariosRef.keepSynced(true);
    _horariosRef.onValue.listen((event) {
      linhas = event.snapshot.value;

      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });
  }

  @action
  void recuperarParadas() {
    stateRecuperarHorarios = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _horariosRef =
        FirebaseDatabase.instance.reference().child('paradas');
    _horariosRef.keepSynced(true);
    _horariosRef.onValue.listen((event) {
      List paradasList = event.snapshot.value;
      paradasList.forEach((paradaJson) {
        if (!paradas.containsKey(paradaJson['codigo'])) {
          paradas[paradaJson['codigo']] = {};
        }
        paradas[paradaJson['codigo']] = paradaJson;
      });
      print(paradas);

      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });
  }

  _convertendoMapaParaKeyDeParada() {
    horarios.keys.forEach((linhaKey) {
      horarios[linhaKey].keys.forEach((paradaKey) {
        if (!previsoes.containsKey(paradaKey)) {
          previsoes[paradaKey] = {};
        }
        if (!previsoes[paradaKey].containsKey(linhaKey)) {
          previsoes[paradaKey][linhaKey] = {};
        }
        previsoes[paradaKey][linhaKey] = horarios[linhaKey][paradaKey];
      });
    });
  }
}
