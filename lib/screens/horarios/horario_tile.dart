import 'package:flutter/material.dart';

class HorarioTile extends StatelessWidget {
  final String horario;

  const HorarioTile({Key key, this.horario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.access_time),
        ),
        title: Text(horario),
      ),
    );
  }
}
