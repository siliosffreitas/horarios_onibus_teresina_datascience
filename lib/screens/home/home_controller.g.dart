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

  final _$sortOptionAtom = Atom(name: '_HomeController.sortOption');

  @override
  SortOption get sortOption {
    _$sortOptionAtom.context.enforceReadPolicy(_$sortOptionAtom);
    _$sortOptionAtom.reportObserved();
    return super.sortOption;
  }

  @override
  set sortOption(SortOption value) {
    _$sortOptionAtom.context.conditionallyRunInAction(() {
      super.sortOption = value;
      _$sortOptionAtom.reportChanged();
    }, _$sortOptionAtom, name: '${_$sortOptionAtom.name}_set');
  }

  final _$stateRecuperarHorariosAtom =
      Atom(name: '_HomeController.stateRecuperarHorarios');

  @override
  RequestState get stateRecuperarHorarios {
    _$stateRecuperarHorariosAtom.context
        .enforceReadPolicy(_$stateRecuperarHorariosAtom);
    _$stateRecuperarHorariosAtom.reportObserved();
    return super.stateRecuperarHorarios;
  }

  @override
  set stateRecuperarHorarios(RequestState value) {
    _$stateRecuperarHorariosAtom.context.conditionallyRunInAction(() {
      super.stateRecuperarHorarios = value;
      _$stateRecuperarHorariosAtom.reportChanged();
    }, _$stateRecuperarHorariosAtom,
        name: '${_$stateRecuperarHorariosAtom.name}_set');
  }

  final _$_HomeControllerActionController =
      ActionController(name: '_HomeController');

  @override
  void mudarOrdenacao() {
    final _$actionInfo = _$_HomeControllerActionController.startAction();
    try {
      return super.mudarOrdenacao();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

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
        'horarios: ${horarios.toString()},sortOption: ${sortOption.toString()},stateRecuperarHorarios: ${stateRecuperarHorarios.toString()}';
    return '{$string}';
  }
}
