import 'package:firebase_database/firebase_database.dart';
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
  void recuperarHorarios() {
    stateRecuperarHorarios = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _horariosRef = FirebaseDatabase.instance.reference().child('horarios');
    _horariosRef.keepSynced(true);
    _horariosRef.onValue.listen((event) {
      horarios = event.snapshot.value;
      stateRecuperarHorarios = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarHorarios = RequestState.FAIL;
    });



//    Future.delayed(const Duration(seconds: 5))
//        .then((value) => stateRecuperarHorarios = RequestState.SUCCESS);
  }
}
