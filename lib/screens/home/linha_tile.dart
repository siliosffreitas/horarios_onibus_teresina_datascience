import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.directions_bus),
      ),
      title: Text(codigoLinha),
      subtitle: Observer(
        builder: (_) {
          if (!_homeController.linhas.containsKey(codigoLinha)) {
            return Container();
          } else {
            return Text(
              _homeController.linhas[codigoLinha]['denominacao'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
          }
        },
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
