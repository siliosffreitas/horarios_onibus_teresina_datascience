import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/data/sharedprefs/termos_pref.dart';
import 'package:horariosonibusapp/screens/map/map_screen.dart';
import 'package:horariosonibusapp/screens/termos/stores/termos_store.dart';

class TermosScreen extends StatefulWidget {
  @override
  _TermosScreenState createState() => _TermosScreenState();
}

class _TermosScreenState extends State<TermosScreen> {
  final _termosController = GetIt.instance<TermosStore>();

  @override
  void initState() {
    super.initState();
    _termosController.recuperarTermos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Termos"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Observer(
          builder: (_) {
            if (_termosController.termos.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Text(
              _termosController.termos,
              textAlign: TextAlign.justify,
            );
          },
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) {
          if (_termosController.termos.isEmpty) {
            return Container();
          }
          return FloatingActionButton.extended(
            onPressed: _aceitarTermos,
            label: Text("Aceitar"),
          );
        },
      ),
    );
  }

  _aceitarTermos() {
    _termosController.aceitarOsTermos();
  }
}
