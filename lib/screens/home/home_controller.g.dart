// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeController, Store {
  final _$horariosAtom = Atom(name: '_HomeController.horarios');

  @override
  Map<dynamic, dynamic> get horarios {
    _$horariosAtom.context.enforceReadPolicy(_$horariosAtom);
    _$horariosAtom.reportObserved();
    return super.horarios;
  }

  @override
  set horarios(Map<dynamic, dynamic> value) {
    _$horariosAtom.context.conditionallyRunInAction(() {
      super.horarios = value;
      _$horariosAtom.reportChanged();
    }, _$horariosAtom, name: '${_$horariosAtom.name}_set');
  }

  final _$stateLoginAtom = Atom(name: '_HomeController.stateLogin');

  @override
  RequestState get stateRecuperarHorarios {
    _$stateLoginAtom.context.enforceReadPolicy(_$stateLoginAtom);
    _$stateLoginAtom.reportObserved();
    return super.stateRecuperarHorarios;
  }

  @override
  set stateRecuperarHorarios(RequestState value) {
    _$stateLoginAtom.context.conditionallyRunInAction(() {
      super.stateRecuperarHorarios = value;
      _$stateLoginAtom.reportChanged();
    }, _$stateLoginAtom, name: '${_$stateLoginAtom.name}_set');
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  void recuperarHorarios() {
    final _$actionInfo = _$_HomeControllerActionController.startAction();
    try {
      return super.recuperarHorarios();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'horarios: ${horarios.toString()},stateLogin: ${stateRecuperarHorarios.toString()}';
    return '{$string}';
  }
}
