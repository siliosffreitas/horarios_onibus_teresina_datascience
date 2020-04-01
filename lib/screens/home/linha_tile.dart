import 'package:flutter/material.dart';

class LinhaTile extends StatelessWidget {
  final String codigoLinha;

  const LinhaTile({Key key, this.codigoLinha}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.directions_bus),
      title: Text(codigoLinha),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
