import 'package:firebase_database/firebase_database.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/data/sharedprefs/termos_pref.dart';
import 'package:mobx/mobx.dart';

part 'termos_store.g.dart';

// This is the class used by rest of your codebase
class TermosStore = _TermosStore with _$TermosStore;

// The store-class
abstract class _TermosStore with Store {
  @observable
  String termos = "";

  @observable
  bool aceitouOsTermos;

  @observable
  RequestState stateRecuperarTermos;

  @action
  void aceitarOsTermos() {
    saveTermos("TERMOS_ACEITOS");
    aceitouOsTermos = true;
  }

  @action
  void verificarSeAceitouOsTermos() {
    readTermos().then((termos) {
      if (termos == null) {
        aceitouOsTermos = false;
      } else if (termos == 'TERMOS_ACEITOS') {
        aceitouOsTermos = true;
      } else {
        aceitouOsTermos = false;
      }
    });
  }

  @action
  void recuperarTermos() {
    stateRecuperarTermos = RequestState.LOADING;

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);

    DatabaseReference _termosRef =
        FirebaseDatabase.instance.reference().child('termos');
    _termosRef.keepSynced(true);
    _termosRef.onValue.listen((event) {
      termos = event.snapshot.value;

      stateRecuperarTermos = RequestState.SUCCESS;
    }, onError: (Object o) {
      stateRecuperarTermos = RequestState.FAIL;
    });
  }
}
