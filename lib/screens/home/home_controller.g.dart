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

  final _$previsoesAtom = Atom(name: '_HomeController.previsoes');

  @override
  Map<dynamic, dynamic> get previsoes {
    _$previsoesAtom.context.enforceReadPolicy(_$previsoesAtom);
    _$previsoesAtom.reportObserved();
    return super.previsoes;
  }

  @override
  set previsoes(Map<dynamic, dynamic> value) {
    _$previsoesAtom.context.conditionallyRunInAction(() {
      super.previsoes = value;
      _$previsoesAtom.reportChanged();
    }, _$previsoesAtom, name: '${_$previsoesAtom.name}_set');
  }

  final _$linhasAtom = Atom(name: '_HomeController.linhas');

  @override
  Map<dynamic, dynamic> get linhas {
    _$linhasAtom.context.enforceReadPolicy(_$linhasAtom);
    _$linhasAtom.reportObserved();
    return super.linhas;
  }

  @override
  set linhas(Map<dynamic, dynamic> value) {
    _$linhasAtom.context.conditionallyRunInAction(() {
      super.linhas = value;
      _$linhasAtom.reportChanged();
    }, _$linhasAtom, name: '${_$linhasAtom.name}_set');
  }

  final _$paradasAtom = Atom(name: '_HomeController.paradas');

  @override
  Map<dynamic, dynamic> get paradas {
    _$paradasAtom.context.enforceReadPolicy(_$paradasAtom);
    _$paradasAtom.reportObserved();
    return super.paradas;
  }

  @override
  set paradas(Map<dynamic, dynamic> value) {
    _$paradasAtom.context.conditionallyRunInAction(() {
      super.paradas = value;
      _$paradasAtom.reportChanged();
    }, _$paradasAtom, name: '${_$paradasAtom.name}_set');
  }

  final _$cameraPositionAtom = Atom(name: '_HomeController.cameraPosition');

  @override
  CameraPosition get cameraPosition {
    _$cameraPositionAtom.context.enforceReadPolicy(_$cameraPositionAtom);
    _$cameraPositionAtom.reportObserved();
    return super.cameraPosition;
  }

  @override
  set cameraPosition(CameraPosition value) {
    _$cameraPositionAtom.context.conditionallyRunInAction(() {
      super.cameraPosition = value;
      _$cameraPositionAtom.reportChanged();
    }, _$cameraPositionAtom, name: '${_$cameraPositionAtom.name}_set');
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

  final _$stateRecuperarParadasAtom =
      Atom(name: '_HomeController.stateRecuperarParadas');

  @override
  RequestState get stateRecuperarParadas {
    _$stateRecuperarParadasAtom.context
        .enforceReadPolicy(_$stateRecuperarParadasAtom);
    _$stateRecuperarParadasAtom.reportObserved();
    return super.stateRecuperarParadas;
  }

  @override
  set stateRecuperarParadas(RequestState value) {
    _$stateRecuperarParadasAtom.context.conditionallyRunInAction(() {
      super.stateRecuperarParadas = value;
      _$stateRecuperarParadasAtom.reportChanged();
    }, _$stateRecuperarParadasAtom,
        name: '${_$stateRecuperarParadasAtom.name}_set');
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
  void recuperarLinhas() {
    final _$actionInfo = _$_HomeControllerActionController.startAction();
    try {
      return super.recuperarLinhas();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void recuperarParadas() {
    final _$actionInfo = _$_HomeControllerActionController.startAction();
    try {
      return super.recuperarParadas();
    } finally {
      _$_HomeControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'horarios: ${horarios.toString()},previsoes: ${previsoes.toString()},linhas: ${linhas.toString()},paradas: ${paradas.toString()},cameraPosition: ${cameraPosition.toString()},sortOption: ${sortOption.toString()},stateRecuperarHorarios: ${stateRecuperarHorarios.toString()},stateRecuperarParadas: ${stateRecuperarParadas.toString()}';
    return '{$string}';
  }
}
