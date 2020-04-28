// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'termos_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TermosStore on _TermosStore, Store {
  final _$termosAtom = Atom(name: '_TermosStore.termos');

  @override
  String get termos {
    _$termosAtom.context.enforceReadPolicy(_$termosAtom);
    _$termosAtom.reportObserved();
    return super.termos;
  }

  @override
  set termos(String value) {
    _$termosAtom.context.conditionallyRunInAction(() {
      super.termos = value;
      _$termosAtom.reportChanged();
    }, _$termosAtom, name: '${_$termosAtom.name}_set');
  }

  final _$stateRecuperarTermosAtom =
      Atom(name: '_TermosStore.stateRecuperarTermos');

  @override
  RequestState get stateRecuperarTermos {
    _$stateRecuperarTermosAtom.context
        .enforceReadPolicy(_$stateRecuperarTermosAtom);
    _$stateRecuperarTermosAtom.reportObserved();
    return super.stateRecuperarTermos;
  }

  @override
  set stateRecuperarTermos(RequestState value) {
    _$stateRecuperarTermosAtom.context.conditionallyRunInAction(() {
      super.stateRecuperarTermos = value;
      _$stateRecuperarTermosAtom.reportChanged();
    }, _$stateRecuperarTermosAtom,
        name: '${_$stateRecuperarTermosAtom.name}_set');
  }

  final _$_TermosStoreActionController = ActionController(name: '_TermosStore');

  @override
  void recuperarTermos() {
    final _$actionInfo = _$_TermosStoreActionController.startAction();
    try {
      return super.recuperarTermos();
    } finally {
      _$_TermosStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'termos: ${termos.toString()},stateRecuperarTermos: ${stateRecuperarTermos.toString()}';
    return '{$string}';
  }
}
