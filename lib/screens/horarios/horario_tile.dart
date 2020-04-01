import 'package:flutter/material.dart';

class HorarioTile extends StatelessWidget {
  final String horario;

  const HorarioTile({Key key, this.horario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(horario),
    );
  }
}
