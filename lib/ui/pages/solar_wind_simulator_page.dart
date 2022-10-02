import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import 'package:space_apps_404_name_not_found/ui/painter/cone_painter.dart';
import 'package:space_apps_404_name_not_found/ui/resources/nasa_colors.dart';
import 'package:space_apps_404_name_not_found/ui/widgets/animated_cancellable_image.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

class SolarWindSimulatorPage extends StatefulWidget {
  const SolarWindSimulatorPage({super.key});

  @override
  State<SolarWindSimulatorPage> createState() => _SolarWindSimulatorPageState();
}

class _SolarWindSimulatorPageState extends State<SolarWindSimulatorPage>
    with TickerProviderStateMixin {
  late Animation<double> astronautAnimation;
  late AnimationController astronautAnimationController;

  late Animation<double> coneAnimationPositive;
  late AnimationController coneAnimationPositiveController;
  late Animation<double> coneAnimationNegative;
  late AnimationController coneAnimationNegativeController;

  ValueNotifier<double> densityValueNotifier = ValueNotifier<double>(1.0);
  ValueNotifier<double> velocityValueNotifier = ValueNotifier<double>(200.0);
  ValueNotifier<double> temperatureValueNotifier = ValueNotifier<double>(1.0);

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

    //
    // Cone Animation
    //
    coneAnimationPositiveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    coneAnimationPositive = Tween(begin: 0.0, end: 0.25 * math.pi)
        .animate(coneAnimationPositiveController);

    coneAnimationNegativeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    coneAnimationNegative = Tween(begin: 0.0, end: -0.25 * math.pi)
        .animate(coneAnimationNegativeController);

    astronautAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  SizedBox(
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: densityValueNotifier,
                          builder: (context, double value, child) {
                            final scaledDensity = convertRange(
                              value,
                              1.0,
                              100.0,
                              1.0,
                              220.0,
                            );
                            return Positioned.fill(
                              left: 70,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ValueListenableBuilder(
                                  valueListenable: velocityValueNotifier,
                                  builder: (context, double value, child) {
                                    final scaledVelocity = convertRange(
                                      value,
                                      200.0,
                                      1200.0,
                                      3500,
                                      200,
                                    );
                                    return LoopAnimationBuilder(
                                      builder: (context, double value, child) {
                                        return Transform.scale(
                                          scale: value,
                                          child: CustomPaint(
                                            painter: ConePainter(),
                                            size: Size(
                                                scaledDensity, scaledDensity),
                                          ),
                                        );
                                      },
                                      tween: Tween<double>(
                                        begin: 1.0,
                                        end: 1.15,
                                      ),
                                      duration: Duration(
                                        milliseconds: scaledVelocity.toInt(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        ValueListenableBuilder(
                            valueListenable: temperatureValueNotifier,
                            builder: (context, double value, child) {
                              return Positioned.fill(
                                bottom: temperatureValueNotifier.value,
                                left: 50,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Transform.scale(
                                    scale: convertRange(
                                      temperatureValueNotifier.value,
                                      1.0,
                                      100.0,
                                      0.0,
                                      3.0,
                                    ),
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Lottie.asset(AssetProvider.fire),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Center(
                          child: Row(
                            children: [
                              Container(
                                height: 180,
                                width: 180,
                                child: Lottie.asset(AssetProvider.sun),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 220,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<double>(
                            valueListenable: densityValueNotifier,
                            builder: (context, double value, child) {
                              return _parameterSlider(
                                parameterName: 'Densidad',
                                parameterValuesIn: '1/cm3',
                                minValue: 1.0,
                                maxValue: 100.0,
                                value: value,
                                onChanged: (value) {
                                  densityValueNotifier.value = value;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: velocityValueNotifier,
                            builder: (context, double value, child) {
                              return _parameterSlider(
                                parameterName: 'Velocidad',
                                parameterValuesIn: 'Km/s',
                                minValue: 200.0,
                                maxValue: 1200.0,
                                value: value,
                                onChanged: (value) {
                                  velocityValueNotifier.value = value;
                                },
                              );
                            },
                          ),
                          ValueListenableBuilder(
                            valueListenable: temperatureValueNotifier,
                            builder: (context, double value, child) {
                              return _parameterSlider(
                                parameterName: 'Temperatura',
                                parameterValuesIn: 'Kelvin',
                                minValue: 1.0,
                                maxValue: 100.0,
                                value: value,
                                onChanged: (value) {
                                  temperatureValueNotifier.value = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                top: 80,
                left: 30,
                child: AnimatedCancellableImage(
                  imagePath: AssetProvider.satelite,
                ),
              ),
              Positioned(
                top: 140,
                left: 180,
                child: AnimatedCancellableImage(
                  imagePath: AssetProvider.astronautObj,
                ),
              ),
              Positioned(
                top: 400,
                left: 270,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: AnimatedCancellableImage(
                    imagePath: AssetProvider.map,
                  ),
                ),
              ),
              Positioned(
                top: 280,
                left: 230,
                child: AnimatedCancellableImage(
                  imagePath: AssetProvider.lightbulb,
                ),
              ),
            ],
          ),
          Positioned(
            top: -60,
            right: -60,
            child: Hero(
              tag: AssetProvider.pJupiter,
              child: SizedBox(
                height: 200,
                width: 200,
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

  //
  // Density 1 - 100
  // Velocity 200 - 1200
  // Temperature 1 - 100
  //
  bool turnOnSatelite() {
    final density = densityValueNotifier.value;
    final velocity = velocityValueNotifier.value;
    final temperature = temperatureValueNotifier.value;

    return (density < 60 && velocity < 30 && temperature < 50);
  }

  bool turnOnAstronaut() {
    final density = densityValueNotifier.value;
    final velocity = velocityValueNotifier.value;
    final temperature = temperatureValueNotifier.value;

    return (density < 80 && velocity < 40 && temperature < 40);
  }

  bool turnOnLightbulb() {
    final density = densityValueNotifier.value;
    final velocity = velocityValueNotifier.value;
    final temperature = temperatureValueNotifier.value;

    return (density < 20 && velocity < 80 && temperature < 70);
  }

  bool turnOnMap() {
    final density = densityValueNotifier.value;
    final velocity = velocityValueNotifier.value;
    final temperature = temperatureValueNotifier.value;

    return (density < 40 && velocity < 50 && temperature < 60);
  }

  double convertRange(double value, double oldRangeMIN, double oldRangeMAX,
      double newRangeMIN, double newRangeMAX) {
    return ((value - oldRangeMIN) * (newRangeMAX - newRangeMIN)) /
            (oldRangeMAX - oldRangeMIN) +
        newRangeMIN;
  }

  Widget _parameterSlider({
    required String parameterName,
    required String parameterValuesIn,
    required double minValue,
    required double maxValue,
    required double value,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$parameterName $parameterValuesIn',
          style: const TextStyle(
            color: NasaColors.primaryLightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          min: minValue,
          max: maxValue,
          value: value,
          thumbColor: Colors.lightBlueAccent.shade100,
          activeColor: Colors.lightBlueAccent.shade100,
          inactiveColor: NasaColors.primaryLightColor,
          onChanged: onChanged,
        )
      ],
    );
  }
}
