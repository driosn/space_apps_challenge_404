import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class NasaColors {
  static const Color primaryColor = Color(0xff11122D);
  static const Color accentColor = Color(0xffCC90CB);
  static const Color primaryLightColor = Color(0xffffffff);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primaryColor: NasaColors.primaryColor,
        accentColor: NasaColors.accentColor,
        primaryColorLight: NasaColors.primaryLightColor,
        scaffoldBackgroundColor: NasaColors.primaryColor,
        textTheme: GoogleFonts.spaceMonoTextTheme(textTheme),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Nombre de la app',
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Center(
            child: Text(
          'Hola Mundo',
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        )),
      ),
    );
  }
}
