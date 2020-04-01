import 'package:flutter/material.dart';
import 'package:horariosonibusapp/screens/paradas/paradas_da_linha_screen.dart';

class LinhaTile extends StatelessWidget {
  final String codigoLinha;

  const LinhaTile({Key key, this.codigoLinha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.directions_bus),
      title: Text(codigoLinha),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ParadasDaLinhaScreen(codigoLinha: codigoLinha)));
      },
    );
  }
}
