import 'package:flutter/material.dart';
import 'package:horariosonibusapp/screens/infos/infos_screens.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Horários"),
            accountEmail: Text("dos ônibus"),
            currentAccountPicture: GestureDetector(
              onTap: () => print('clicou na imagem de perfil'),
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://raw.githubusercontent.com/siliosffreitas/horarios_onibus_teresina_datascience/master/android/app/src/main/res/playstore-icon.png"),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Informações"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => InfosScreen()));
            },
          )
        ],
      ),
    );
  }
}
