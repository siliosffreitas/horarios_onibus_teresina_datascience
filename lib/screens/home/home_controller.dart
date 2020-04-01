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

    Future.delayed(const Duration(seconds: 5))
        .then((value) => stateRecuperarHorarios = RequestState.SUCCESS);
  }
}
