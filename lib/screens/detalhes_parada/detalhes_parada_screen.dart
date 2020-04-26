import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/screens/detalhes_parada/linha_tile.dart';
import 'package:horariosonibusapp/screens/map/components/loader.dart';
import 'package:horariosonibusapp/screens/horarios/horarios_screen.dart';
import 'package:horariosonibusapp/utils/sort.dart';

class DetalheParadaScreen extends StatelessWidget {
  final _homeController = GetIt.instance<HomeController>();

  final String codigoParada;

  DetalheParadaScreen({Key key, this.codigoParada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalhes de ${codigoParada}"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Observer(
                builder: (_) {
                  return Column(
                    children: <Widget>[
                      Divider(
                        height: 1,
                      ),
                      Container(
                        height: 200,
                        child: _homeController.paradas.isEmpty
                            ? Loader()
                            : GoogleMap(
                                mapType: MapType.normal,
                                myLocationButtonEnabled: false,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                      _homeController.paradas[codigoParada]
                                          ['lat'],
                                      _homeController.paradas[codigoParada]
                                          ['long']),
                                  zoom: 14,
                                ),
                                markers: <Marker>[
                                  Marker(
                                    markerId:
                                        MarkerId("parada_${codigoParada}"),
                                    position: LatLng(
                                      _homeController.paradas[codigoParada]
                                          ['lat'],
                                      _homeController.paradas[codigoParada]
                                          ['long'],
                                    ),
                                  )
                                ].toSet(),
                              ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text(_homeController.paradas[codigoParada]
                            ['denominacao']),
                        //Text("Endereço"),
                        subtitle: Text(
                            _homeController.paradas[codigoParada]['endereco']),
                      ),
                      Divider(
                        height: 1,
                      ),
                      ListTile(
                        title: Text(
                            "LINHAS (${_homeController.previsoes[codigoParada] == null ? 0 : _homeController.previsoes[codigoParada].keys.toList().length})"),
                      ),
                    ],
                  );
                },
              ),
              Observer(
                builder: (_) {
                  if (_homeController.previsoes[codigoParada] == null) {
                    return Container(
                      child: Text("Nenhuma Linha Encontrada"),
                    );
                  }
                  List linhas =
                      _homeController.previsoes[codigoParada].keys.toList();
                  if (_homeController.sortOption == SortOption.ASK) {
                    linhas.sort((a, b) => a.compareTo(b));
                  } else {
                    linhas.sort((a, b) => b.compareTo(a));
                  }

                  return Column(
                    children: linhas
                        .map((linhaKey) => LinhaTile(
                              codigoLinha: linhaKey,
                              codigoParada: codigoParada,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => HorariosScreen(
                                          codigoLinha: linhaKey,
                                          codigoParada: codigoParada,
                                        )));
                              },
                            ))
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
