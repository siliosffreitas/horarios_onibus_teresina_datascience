import 'dart:async';
/**
 * Classe que gerencia o accessToken da aplicacao. O accessToken vai ser salvo
 * localmente para ser utilizados nas requisicoes futuras e evitar de exibir
 * a tela de login toda vez que o app é aberto.
 *
 * @author Silio Silvestre
 * @date 2020-03-09
 * */

import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<File> _getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File("${directory.path}/termos_pref.json");
}

Future<File> saveTermos(String sort) async {
  final file = await _getFile();
  return file.writeAsString(sort);
}

Future<String> readTermos() async {
  try {
    final file = await _getFile();
    if (await file.exists()) {
      return file.readAsString();
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<FileSystemEntity> deleteTermos() async {
  final file = await _getFile();
  return file.delete();
}
