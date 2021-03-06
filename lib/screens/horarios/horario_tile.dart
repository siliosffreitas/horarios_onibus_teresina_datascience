import 'package:flutter/material.dart';
import 'package:horariosonibusapp/utils/periods.dart';

class HorarioTile extends StatelessWidget {
  final String horario;
  final Periods period;
  DateTime proximo;

  HorarioTile({Key key, @required this.horario, this.proximo, this.period})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool ehOProximo = proximo == null ? false : _verificaSeEhOProximo();
    return Card(
      color: ehOProximo ? Theme.of(context).primaryColor : null,
      child: Container(
        height: 50,
        child: ListTile(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.access_time,
              color: ehOProximo ? Colors.white : null,
            ),
          ),
          title: Text(
            horario,
            style: TextStyle(
              color: ehOProximo ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }

  _verificaSeEhOProximo() {
    Periods periodoDoProximo = getPeriodFromWeekday(proximo.weekday);

    if (periodoDoProximo != period) {
      return false;
    }
    List times = horario.split(":");

    return int.parse(times[0]) == proximo.hour &&
        int.parse(times[1]) == proximo.minute;
  }
}
