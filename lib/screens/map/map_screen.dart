import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:horariosonibusapp/data/network/request_state.dart';
import 'package:horariosonibusapp/screens/detalhes_parada/detalhes_parada_screen.dart';
import 'package:horariosonibusapp/screens/map/components/custom_drawer.dart';
import 'package:horariosonibusapp/screens/map/components/error_message_screen.dart';
import 'package:horariosonibusapp/screens/map/controllers/home_controller.dart';
import 'package:horariosonibusapp/screens/map/components/loader.dart';
import 'package:horariosonibusapp/utils/sort.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _homeController = GetIt.instance<HomeController>();

  String paradaSelecionada;

  @override
  void initState() {
    super.initState();
    _homeController.recuperarHorarios();
    _homeController.recuperarLinhas();
    _homeController.recuperarParadas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paradas"),
        ),
        drawer: CustomDrawer(),
        body: Observer(
          builder: (_) {
            switch (_homeController.stateRecuperarHorarios) {
              case RequestState.LOADING:
                return Loader();
              case RequestState.FAIL:
                return ErrorMessageScreen();
              case RequestState.SUCCESS:
                List paradas = _homeController.previsoes.keys.toList();
                if (_homeController.sortOption == SortOption.ASK) {
                  paradas.sort((a, b) => a.compareTo(b));
                } else {
                  paradas.sort((a, b) => b.compareTo(a));
                }

                return GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _homeController.cameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    _homeController.controller.complete(controller);
                    _homeController
                        .filtrarParadas(_homeController.cameraPosition.target);
                  },
                  onCameraMove: (position) {
                    _homeController.filtrarParadas(position.target);
                  },
                  markers: _criarMarkersSetParadasProximas(
                      paradas: _homeController.paradasProximas),
                  circles: _homeController.circles,
                );

              default:
                return Container();
            }
          },
        ),
        floatingActionButton: paradaSelecionada == null
            ? null
            : FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                  _onMarkerTapped(paradaSelecionada);
                },
                label: Text('Detalhes de $paradaSelecionada'),
                icon: Icon(Icons.chevron_right),
              ));
  }

  _criarMarkersSetParadasProximas({@required Map paradas}) {
    Set<Marker> markers = Set<Marker>();
    if (paradas != null) {
      paradas.keys.forEach((paradaKey) {
        final MarkerId markerId = MarkerId("parada_$paradaKey");

        Marker markerParada = Marker(
          markerId: markerId,
          position: LatLng(
            paradas[paradaKey]['lat'],
            paradas[paradaKey]['long'],
          ),
          onTap: () {
            setState(() {
              paradaSelecionada = paradaKey;
            });
          },
          infoWindow: InfoWindow(
            title: "Parada ${paradaKey} • ${paradas[paradaKey]['denominacao']}",
            snippet: "${paradas[paradaKey]['endereco']}",
            onTap: () {
              _onMarkerTapped(paradaKey);
            },
          ),
        );
        markers.add(markerParada);
      });
    }
    return markers;
  }

  _onMarkerTapped(String paradaKey) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetalheParadaScreen(codigoParada: paradaKey)));
  }
}
