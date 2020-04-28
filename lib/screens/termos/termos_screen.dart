import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:horariosonibusapp/data/sharedprefs/termos_pref.dart';
import 'package:horariosonibusapp/screens/map/map_screen.dart';
import 'package:horariosonibusapp/screens/termos/stores/termos_store.dart';

class TermosScreen extends StatefulWidget {
  @override
  _TermosScreenState createState() => _TermosScreenState();
}

class _TermosScreenState extends State<TermosScreen> {
  TermosStore store = TermosStore();

  @override
  void initState() {
    super.initState();
    store.recuperarTermos();
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
            if (store.termos.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Text(
              store.termos,
              textAlign: TextAlign.justify,
            );
          },
        ),
      ),
      floatingActionButton: Observer(
        builder: (_) {
          if (store.termos.isEmpty) {
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => MapScreen()));
//    saveTermos("TERMOS_ACEITOS").then((value) {
//      Navigator.of(context).pushReplacement(
//          MaterialPageRoute(builder: (context) => MapScreen()));
//    });
  }
}
