import 'package:flutter/material.dart';
import 'package:horariosonibusapp/screens/horarios/horarios_screen.dart';

class ParadaTile extends StatelessWidget {
  final String codigoParada;
  final String codigoLinha;

  const ParadaTile({Key key, @required this.codigoParada, @required this.codigoLinha})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.flag),
      title: Text(codigoParada),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HorariosScreen(
                codigoLinha: codigoLinha, codigoParada: codigoParada)));
      },
    );
  }
}
