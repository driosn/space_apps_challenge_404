import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';
import 'package:lottie/lottie.dart' as lt;


class MapaPage extends StatefulWidget {
  MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();

}

class _MapaPageState extends State<MapaPage>with SingleTickerProviderStateMixin {
  late Animation<double> astronautAnimation;
  late AnimationController astronautAnimationController;

  var geolocator = Geolocator();
  Completer<GoogleMapController> _controladorMapa = Completer();

  MapType tipoMapa = MapType.normal;
  double valorZoom = 1;

  bool animacionTerminada = false;

  late Set<Marker> markers;
  late Position position;

  @override
  void initState() {
    super.initState();
    astronautAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    astronautAnimation = Tween(
      begin: 0.0,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: astronautAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    astronautAnimationController.forward();

    markers = Set<Marker>();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      var permisoMapa = await Permission.location.status;
      if (permisoMapa.isGranted) {
        await iniciarLocalizacion();
      } else {
        permisoMapa = await Permission.location.request();
        if (permisoMapa.isGranted) {
          await iniciarLocalizacion();
        } else {
          Navigator.pop(context);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Es necesario que acepte los permisos de GPS para entrar a mapa"),
                  actions: [
                    TextButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),

                  ],
                );
              }
          );
        }
      }
    });

  }

  Future<void> iniciarLocalizacion() async {
    try {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    } catch (error) {
      if (error.toString().contains("location") && error.toString().contains("disabled")) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Es necesario que se habilite el GPS para ingresar a mapa"),
                actions: [
                  TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            }
        );
      }
      print("ERROR:");
      print(error);
    }
    if (position != null) {
      Marker marker = new Marker(
        markerId: MarkerId("Id"),
        position: LatLng(position.latitude, position.longitude),
      );
      markers.add(marker);

      setState(() { animacionTerminada = true; });

      final GoogleMapController controladorGoogle = await _controladorMapa.future;
      controladorGoogle.animateCamera(
          CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 18
              )
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: animacionTerminada
            ? Stack(
          children: [
            const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
            Positioned(
              top: -60,
              right: -60,
              child: Hero(
                tag: AssetProvider.pJupiter,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(AssetProvider.pJupiter),
                ),
              ),
            ),
            Positioned.fill(
              bottom: -80,
              left: -350,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 400,
                  width: 400,
                  child: AnimatedBuilder(
                    animation: astronautAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(astronautAnimation.value, 0.0),
                        child: lt.Lottie.asset(AssetProvider.astronaut),
                      );
                    },
                  ),
                ),
              ),
            ),
            GoogleMap(
              mapType: tipoMapa,
              initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 0
              ),
              markers: getmarkers(),
              onMapCreated: (GoogleMapController controlador) async {
                _controladorMapa.complete(controlador);
              },
            ),

            Positioned(
                top: 12,
                right: 12,
                child: _botonCambiarTipoMapa()
            ),

            Positioned(
              top: 60,
              right: 12,
              child: _botonUbicacionActual(),
            )
          ],
        )
            : Container()
    );
  }



  Widget _botonCambiarTipoMapa() {
    return GestureDetector(
      onTap: () {
        if (tipoMapa == MapType.hybrid) {
          setState(() {
            tipoMapa = MapType.normal;
          });
        } else {
          setState(() {
            tipoMapa = MapType.hybrid;
          });
        }
      },
      child: Container(
        height: 40,
        width: 40,
        child: Icon(
          Icons.swap_horizontal_circle_sharp,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 2
              )
            ]
        ),
      ),
    );
  }

  Widget _botonUbicacionActual() {
    return GestureDetector(
      onTap: () async {
        await _focusUbicacionActual();
      },
      child: Container(
        height: 40,
        width: 40,
        child: Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange,
            boxShadow: [
              BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 2
              )
            ]
        ),
      ),
    );
  }

  Future<void> _focusUbicacionActual() async {
    Position ubicacionActual = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    Position ubicacionActual1 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    Position ubicacionActual2 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    Position ubicacionActual3 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    Position ubicacionActual4 = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation,);
    double latProm = (ubicacionActual.latitude+ ubicacionActual1.latitude+ ubicacionActual2.latitude+ ubicacionActual3.latitude+ ubicacionActual4.latitude)/5;
    double longProm = (ubicacionActual.longitude+ ubicacionActual1.longitude+ ubicacionActual2.longitude+ ubicacionActual3.longitude+ ubicacionActual4.longitude)/5;
    final GoogleMapController controladorGoogle = await _controladorMapa.future;
    controladorGoogle.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: LatLng(ubicacionActual.latitude, ubicacionActual.longitude),
                zoom: 18
            )
        )
    );
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('mkr'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(latProm, longProm),
      )
      );
    });
  }


  Set<Marker> getmarkers() {

    setState(() {
    });
    return markers;
  }

}