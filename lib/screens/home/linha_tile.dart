import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';

class LinhaTile extends StatelessWidget {
  final _homeController = GetIt.instance<HomeController>();
  final String codigoLinha;
  final GestureTapCallback onTap;

  LinhaTile({Key key, @required this.codigoLinha, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.directions_bus),
      title: Text(codigoLinha),
      subtitle: Observer(
        builder: (_) {
          return Text(
              "${_homeController.horarios[codigoLinha].keys.length} paradas");
        },
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
