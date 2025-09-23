import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:doalink/theme/app_colors.dart';
import 'package:doalink/config/app_config.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapState();
}

class _MapState extends State<MapScreen> {
  GoogleMapController? _mapController;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  Set<Marker> _markers = {};
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(-23.5505, -46.6333),
    zoom: 12,
  );
  @override
  void initState() {
    customMarker();
    super.initState();
    _checkApiKeyConfiguration();
    _setInitialPosition();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void customMarker() {
    BitmapDescriptor.asset(
      const ImageConfiguration(),
      "assets/images/marker.png",
    ).then((icon) {
      setState(() {
        customIcon = icon;
      });
    });
  }

  void _checkApiKeyConfiguration() {
    if (!AppConfig.isConfigValid) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Chave da API do Google Maps não configurada'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      });
    }
  }

  Future<Position> _goToMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Future.error("Serviço de localização desativado");
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error("Permissão de localização negada");
        }
        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              "Permissão de localização negada permanentemente");
        }
        Position position = await Geolocator.getCurrentPosition();
        return position;
      } else if (permission == LocationPermission.deniedForever) {
        return Future.error("Permissão de localização negada permanentemente");
      } else if (permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        return position;
      } else {
        Position position = await Geolocator.getCurrentPosition();
        return position;
      }
    } catch (e) {
      throw Future.error("Erro ao obter localização: $e");
    }
  }

  void _setInitialPosition() async {
    try {
      Position position = await _goToMyLocation();
      setState(() {
        _initialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );
        _markers.addAll([
          Marker(
            markerId: const MarkerId('my_location'),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(
              title: 'Minha Localização',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
          ),
          Marker(
            markerId: const MarkerId('donation_point_1'),
            position: LatLng(position.latitude - 1, position.longitude - 1),
            infoWindow: const InfoWindow(
              title: 'Centro de Doações - Centro',
              snippet: 'Aberto: Seg-Sex 8h-18h',
            ),
            icon: customIcon,
          ),
        ]);
      });

      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 15,
            ),
          ),
        );
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Mapa
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
          markers: _markers,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          trafficEnabled: false,
          buildingsEnabled: true,
          indoorViewEnabled: true,
          mapType: MapType.normal,
        ),

        Positioned(
          right: 20,
          bottom: 80,
          child: FloatingActionButton(
            onPressed: () async {
              Position? pos = await _goToMyLocation();
              return _mapController?.animateCamera(
                CameraUpdate.newCameraPosition(CameraPosition(
                    target: LatLng(pos.latitude, pos.longitude), zoom: 15)),
              );
            },
            backgroundColor: Colors.white,
            foregroundColor: AppColors.blue_400,
            child: const Icon(
              Icons.my_location,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}
