import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';
import 'package:lottie/lottie.dart' as lt;
import 'dart:collection';

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

  Set<Circle> circles = Set.from([

    //la paz
    Circle(
      circleId: CircleId("lp1"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,

      radius: 2000,
    ),

    Circle(
      circleId: CircleId("lp2"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("lp3"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red,
      strokeColor: Colors.red,
      radius: 500,
    ),



    Circle(
      circleId: CircleId("lp4"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,

      radius: 2000,
    ),

    Circle(
      circleId: CircleId("lp5"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("lp6"),
      center: LatLng(-16.489689, -68.119293),
      fillColor: Colors.red,
      strokeColor: Colors.red,
      radius: 500,
    ),

    //Santa Cruz
    Circle(
      circleId: CircleId("bol1"),
      center: LatLng(-17.7892,	-63.1975),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,

      radius: 4000,
    ),

    Circle(
      circleId: CircleId("bol2"),
      center: LatLng(-17.7892, -63.1975),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("bol3"),
      center: LatLng(-17.7892,	-63.1975),
      fillColor: Colors.red,
      strokeColor: Colors.red,
      radius: 500,
    ),

    Circle(
      circleId: CircleId("bol4"),
      center: LatLng(-17.7892,	-63.1975),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.amber.shade100,

      radius: 4000,
    ),

    Circle(
      circleId: CircleId("bol5"),
      center: LatLng(-17.7892, -63.1975),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.amber.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("bol6"),
      center: LatLng(-17.7892,	-63.1975),
      fillColor: Colors.red,
      strokeColor: Colors.red,
      radius: 500,
    ),

    //     -17.5103	-63.1647
    //     -19.5833	-65.7500
    //     -21.5317	-64.7311
    //     -17.4042	-66.0408
    // -17.7892	-63.1975
    //     -16.4942	-68.1475
    //     -17.3935	-66.1570
    //     -19.0431	-65.2592
    //     -17.9667	-67.1167
    //amber
    //     -17.9800	-67.1300
    //     -17.3975	-66.2817
    //     -17.3333	-63.3833
    //     -14.8333	-64.9000
    //     -10.9830	-66.1000
    //     -16.9725	-65.4200
    //     -16.8667	-64.7831
    //     -11.0183	-68.7537
    //     -21.2647	-63.4586
    //     -10.8267	-65.3567
    //     -20.1000	-63.5333
    //     -17.3381	-66.2189
    //     -16.6333	-68.2833
    //     -22.7322	-64.3425
    //     -18.4231	-66.5856
    //     -22.0910	-65.5960
    //     -20.0500	-63.5200
    //     -20.4627	-66.8240
    //     -14.8583	-66.7475
    //     -16.3667	-60.9500
    //     -21.4423	-65.7190




    //latam
    Circle(
      circleId: CircleId("ltm1"),
      center: LatLng(-34.5997,	-58.3819),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,
      radius: 2000,
    ),

    Circle(
      circleId: CircleId("ltm2"),
      center: LatLng(-34.5997,	-58.3819),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("ltm3"),
      center: LatLng(-31.4167,	-64.1833),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,
      radius: 2000,
    ),

    Circle(
      circleId: CircleId("ltm4"),
      center: LatLng(-32.9575,	-60.6394),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("ltm5"),
      center: LatLng(-45.8667,	-67.5000),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,
      radius: 2000,
    ),

    Circle(
      circleId: CircleId("ltm6"),
      center: LatLng(-26.8167,	-65.2167),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),

    Circle(
      circleId: CircleId("ltm7"),
      center: LatLng(-26.8167,	-65.2167),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,
      radius: 2000,
    ),

    Circle(
      circleId: CircleId("ltm8"),
      center: LatLng(-38.0000,	-57.5500),
      fillColor: Colors.red.shade200,
      strokeColor: Colors.red.shade200,
      radius: 1500,
    ),


    Circle(
      circleId: CircleId("ltm9"),
      center: LatLng(-38.0000,	-57.5500),
      fillColor: Colors.red.shade100,
      strokeColor: Colors.red.shade100,
      radius: 2000,
    ),

    Circle(
      circleId: CircleId("ltm10"),
      center: LatLng(-24.7883,	-65.4106),
      fillColor: Colors.amber.shade200,
      strokeColor: Colors.amber.shade200,
      radius: 1500,
    ),


    Circle(
      circleId: CircleId("ltm11"),
      center: LatLng(-31.5375,	-68.5364),
      fillColor: Colors.amber.shade200,
      strokeColor: Colors.amber.shade200,
      radius: 1500,
    ),


    Circle(
      circleId: CircleId("ltm12"),
      center: LatLng(-31.5375,	-68.5364),
      fillColor: Colors.amber.shade200,
      strokeColor: Colors.amber.shade200,
      radius: 800,
    ),



    Circle(
      circleId: CircleId("ltm13"),
      center: LatLng(-31.5375,	-68.5364),
      fillColor: Colors.amber.shade200,
      strokeColor: Colors.amber.shade200,
      radius: 800,
    ),


  ]);

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

              circles: circles,
            ),


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