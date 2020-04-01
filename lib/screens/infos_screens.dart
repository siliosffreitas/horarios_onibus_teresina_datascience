import 'package:flutter/material.dart';

class InfosScreen extends StatelessWidget {
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
              "Versão 1.0.0",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
