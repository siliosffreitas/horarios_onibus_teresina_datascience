import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class LinhaTile extends StatefulWidget {
  final String codigoLinha;
  final String codigoParada;
  final GestureTapCallback onTap;

  LinhaTile(
      {Key key,
      @required this.codigoLinha,
      @required this.onTap,
      @required this.codigoParada})
      : super(key: key);

  @override
  _LinhaTileState createState() => _LinhaTileState();
}

class _LinhaTileState extends State<LinhaTile> {
  final _homeController = GetIt.instance<HomeController>();

  DateTime proximo = null;

  @override
  void initState() {
    super.initState();
//    _calcularProximo();
  }

  _calcularProximo() {
    calcularProximo().then((p) {
      setState(() {
        DateTime now = DateTime.now();
        if (p.isAfter(now)) {
          proximo = p;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _calcularProximo();

    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.directions_bus),
      ),
      title: Text(widget.codigoLinha),
      subtitle: Observer(
        builder: (_) {
          if (!_homeController.linhas.containsKey(widget.codigoLinha)) {
            return Container();
          } else {
            return Text(
              _homeController.linhas[widget.codigoLinha]['denominacao'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          proximo != null ? Text(formatarProximo(proximo)) : Container(),
          Icon(Icons.chevron_right),
        ],
      ),
      onTap: widget.onTap,
    );
  }
}
