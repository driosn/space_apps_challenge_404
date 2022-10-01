import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_apps_404_name_not_found/ui/resources/nasa_colors.dart';
import 'package:space_apps_404_name_not_found/ui/widgets/main_button.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> astronautAnimation;
  late AnimationController astronautAnimationController;

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
                child: Image.asset(imagePath),
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
              Lottie.asset('assets/stars.json'),
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
                  imagePath: 'assets/planets/earth.png',
                ),
              ),
              divider,
              MainButton(
                onTap: () {},
                child: _buttonContent(
                  buttonLabel: 'Cuida tu salud',
                  textColor: Colors.orangeAccent,
                  imagePath: 'assets/planets/jupiter.png',
                ),
              ),
              divider,
              MainButton(
                onTap: () {},
                child: _buttonContent(
                  buttonLabel: 'test',
                  textColor: Colors.lightBlueAccent,
                  imagePath: 'assets/planets/uranus.png',
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
                    return Transform.translate(
                      offset: Offset(astronautAnimation.value, 0.0),
                      child: Lottie.asset(AssetProvider.astronaut),
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
}
