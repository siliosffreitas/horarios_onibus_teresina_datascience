import 'package:flutter/material.dart';
import 'package:horariosonibusapp/screens/infos_screens.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime firstDateInActualMonth = DateTime(now.year, now.month);

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Horários"),
            accountEmail: Text("dos ônibus"),
            currentAccountPicture: GestureDetector(
              onTap: () => print('clicou na imagem de perfil'),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    ""),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Informações"),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => InfosScreen()));
            },
          )
        ],
      ),
    );
  }
}
