import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:space_apps_404_name_not_found/ui/pages/main_menu_page.dart';
import 'package:space_apps_404_name_not_found/ui/resources/nasa_colors.dart';
import 'package:space_apps_404_name_not_found/utils/asset_provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>
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
      end: 400.0,
    ).animate(
      CurvedAnimation(
        parent: astronautAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: kToolbarHeight + 48,
                width: double.infinity,
              ),
              SizedBox(
                height: 100,
                child: Image.asset(AssetProvider.nasaHorizontalLight),
              ),
              const SizedBox(
                height: 60,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(400),
                child: SizedBox(
                  height: 170,
                  width: 170,
                  child: Lottie.asset(AssetProvider.earth),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(NasaColors.accentColor)),
                onPressed: () async {
                  astronautAnimationController.forward();
                  await Future.delayed(const Duration(seconds: 3));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenuPage()),
                  );
                },
                child: const SizedBox(
                  width: 180,
                  height: 80,
                  child: Center(
                    child: Text(
                      'Start!',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 48,
              )
            ],
          ),
          Positioned.fill(
            bottom: -80,
            left: -100,
            child: Align(
              alignment: Alignment.centerLeft,
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
