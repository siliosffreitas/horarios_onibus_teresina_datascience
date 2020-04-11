import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horariosonibusapp/screens/home/home_controller.dart';
import 'package:horariosonibusapp/screens/home/linha_tile.dart';
import 'package:horariosonibusapp/screens/home/loader.dart';
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
      body: Observer(
        builder: (_) {
          List linhas = _homeController.previsoes[codigoParada].keys.toList();
          if (_homeController.sortOption == SortOption.ASK) {
            linhas.sort((a, b) => a.compareTo(b));
          } else {
            linhas.sort((a, b) => b.compareTo(a));
          }

          return ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                height: 200,
                child: _homeController.paradas.isEmpty
                    ? Loader()
                    : GoogleMap(
                        mapType: MapType.normal,
                        myLocationButtonEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              _homeController.paradas[codigoParada]['lat'],
                              _homeController.paradas[codigoParada]['long']),
                          zoom: 14,
                        ),
//            onMapCreated: (GoogleMapController controller) {
//              _homeController.controller.complete(controller);
//            },
                        markers: <Marker>[
                          Marker(
                            markerId: MarkerId("parada_${codigoParada}"),
                            position: LatLng(
                              _homeController.paradas[codigoParada]['lat'],
                              _homeController.paradas[codigoParada]['long'],
                            ),
////              infoWindow: InfoWindow(
////                title: "Parada ${parada.codigo} • ${parada.denominacao}",
////                snippet: parada.endereco,
//////                  onTap: () {
//////                    _onMarkerTapped(markerId);
//////                  },
////              ),
                          )
                        ].toSet(),
                      ),
              ),
              ListTile(
                title:
                    Text(_homeController.paradas[codigoParada]['denominacao']),
                //Text("Endereço"),
                subtitle:
                    Text(_homeController.paradas[codigoParada]['endereco']),
              ),
              ListTile(
                title: Text("LINHAS"),
              ),
            ]..addAll(linhas
                .map((linhaKey) => LinhaTile(
                      codigoLinha: linhaKey,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HorariosScreen(
                                  codigoLinha: linhaKey,
                                  codigoParada: codigoParada,
                                )));
                      },
                    ))
                .toList()),
          );
        },
      ),
    );
  }
}
