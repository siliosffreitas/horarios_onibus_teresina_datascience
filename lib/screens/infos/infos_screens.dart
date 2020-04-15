import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class InfosScreen extends StatefulWidget {
  @override
  _InfosScreenState createState() => _InfosScreenState();
}

class _InfosScreenState extends State<InfosScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informações"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Aplicativo que exibe os resultados do artigo 'Criação de um Sistema de Previsão de Chegada de um Ônibus em uma Parada de Teresina'",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Silio Silvestre",
              textAlign: TextAlign.center,
            ),
//          SizedBox(height: 8,),
            Text(
              "siliosffreitas@gmail.com",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Versão ${_packageInfo.version}",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
