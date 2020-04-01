import 'package:flutter/material.dart';
import 'package:horariosonibusapp/screens/paradas/paradas_da_linha_screen.dart';

class ParadaTile extends StatelessWidget {
  final String codigoParada;

  const ParadaTile({Key key, this.codigoParada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.flag),
      title: Text(codigoParada),
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
