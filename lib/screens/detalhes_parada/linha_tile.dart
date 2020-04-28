import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/horarios/horarios_screen.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/utils/utils.dart';

class LinhaTile extends StatefulWidget {
  final String codigoLinha;
  final String codigoParada;

  LinhaTile({Key key, @required this.codigoLinha, @required this.codigoParada})
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
    calcularProximo(
            _homeController.previsoes[widget.codigoParada][widget.codigoLinha])
        .then((p) => setState(() {
              proximo = p;
            }));
  }

  @override
  Widget build(BuildContext context) {
    _calcularProximo();

    return Card(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.directions_bus),
              ),
            ],
          ),
          title: Text(widget.codigoLinha),
          subtitle: Observer(
            builder: (_) {
              if (!_homeController.linhas.containsKey(widget.codigoLinha)) {
                return Container();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _homeController.linhas[widget.codigoLinha]['denominacao'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        "${formatarProximo(proximo) ?? "..."}",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                );
              }
            },
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//              Padding(
//                padding: const EdgeInsets.all(8.0),
//                child:
              Icon(Icons.chevron_right),
//              ),
            ],
          ),

//          Icon(Icons.chevron_right),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HorariosScreen(
                      codigoLinha: widget.codigoLinha,
                      codigoParada: widget.codigoParada,
                      proximo: proximo,
                    )));
          }),
    );
  }
}
