import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: -60,
            right: -60,
            child: Hero(
              tag: AssetProvider.pUranus,
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(AssetProvider.pUranus),
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
}
