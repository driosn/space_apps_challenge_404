import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_apps_404_name_not_found/ui/pages/solar_wind_simulator_page.dart';
import 'package:space_apps_404_name_not_found/ui/pages/test_page.dart';
import 'package:space_apps_404_name_not_found/ui/resources/nasa_colors.dart';
import 'package:space_apps_404_name_not_found/ui/widgets/main_button.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage>
    with TickerProviderStateMixin {
  late Animation<double> astronautAnimation;
  late AnimationController astronautAnimationController;

  late Animation<double> astronautAnimationForward;
  late AnimationController astronautAnimationForwardController;

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

    astronautAnimationForwardController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    astronautAnimationForward = Tween(
      begin: 0.0,
      end: 500.0,
    ).animate(CurvedAnimation(
      parent: astronautAnimationForwardController,
      curve: Curves.easeInOutBack,
    ));

    astronautAnimationController.forward();
  }

  Widget get divider => const SizedBox(height: 16);

  Widget _buttonContent({
    required String buttonLabel,
    required Color textColor,
    String? imagePath,
    double width = 200,
  }) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: Text(
            buttonLabel,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        imagePath != null
            ? SizedBox(
                height: 50,
                width: 50,
                child: Hero(
                  tag: imagePath,
                  child: Image.asset(imagePath),
                ),
              )
            : const SizedBox()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Lottie.asset(AssetProvider.stars),
              const SizedBox(
                width: double.infinity,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: NasaColors.primaryLightColor,
                ),
                child: const Text(
                  'Nasa App',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(
                height: 72,
              ),
              MainButton(
                onTap: () {},
                child: _buttonContent(
                  buttonLabel: 'Sliders',
                  textColor: Colors.greenAccent,
                  imagePath: AssetProvider.pEarth,
                ),
              ),
              divider,
              MainButton(
                onTap: _goToSolarWindSimulatorPage,
                child: _buttonContent(
                  buttonLabel: 'Simulador Viento Solar',
                  textColor: Colors.orangeAccent,
                  imagePath: AssetProvider.pJupiter,
                ),
              ),
              divider,
              MainButton(
                onTap: _goToTestPage,
                child: _buttonContent(
                  buttonLabel: 'test',
                  textColor: Colors.lightBlueAccent,
                  imagePath: AssetProvider.pUranus,
                ),
              ),
            ],
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
                    return AnimatedBuilder(
                      animation: astronautAnimationForward,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                              astronautAnimation.value +
                                  astronautAnimationForward.value,
                              0.0),
                          child: Lottie.asset(AssetProvider.astronaut),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _goToSolarWindSimulatorPage() async {
    astronautAnimationForwardController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) => const SolarWindSimulatorPage(),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    astronautAnimationForwardController.reset();
  }

  void _goToTestPage() async {
    astronautAnimationForwardController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        pageBuilder: (_, __, ___) => const TestPage(),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 500));
    astronautAnimationForwardController.reset();
  }
}
