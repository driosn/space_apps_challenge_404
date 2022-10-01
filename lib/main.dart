import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:space_apps_404_name_not_found/ui/pages/start_page.dart';
import 'package:space_apps_404_name_not_found/ui/resources/nasa_colors.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

void main() => runApp(MyApp());

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
        home: const StartPage());
  }
}
