import 'package:carroeletrico/model/eletropost_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaEletroposto extends StatefulWidget {
  @override
  _MapaEletropostoState createState() => _MapaEletropostoState();

  final Eletroposto eletroposto;
  const MapaEletroposto({required this.eletroposto});
}

class _MapaEletropostoState extends State<MapaEletroposto> {
  late GoogleMapController mapController;
  final Set<Marker> markers = new Set();

  // Marcador, target/marker
  static const LatLng MarkerEletroposto =
      const LatLng(-23.54635103931, -46.638679418682806);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localização dos Eletropostos"),
      ),
      body: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: MarkerEletroposto,
          zoom: 18.0,
        ),
        markers: getmarkers(),
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }

  Set<Marker> getmarkers() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(widget.eletroposto.id.toString()),
        position: MarkerEletroposto,
        infoWindow: InfoWindow(
          title: widget.eletroposto.nome,
          snippet: widget.eletroposto.telefone != ""
              ? "Telefone: " + widget.eletroposto.telefone
              : "sem telefone",
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));
    });
    return markers;
  }
}
