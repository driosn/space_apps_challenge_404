import 'package:flutter/material.dart';

class AnimatedCancellableImage extends StatefulWidget {
  const AnimatedCancellableImage({
    required this.imagePath,
    this.height = 140.0,
    this.width = 140.0,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final double height;
  final double width;

  @override
  State<AnimatedCancellableImage> createState() =>
      _AnimatedCancellableImageState();
}

class _AnimatedCancellableImageState extends State<AnimatedCancellableImage>
    with SingleTickerProviderStateMixin {
  late Animation<double> expansionAnimation;
  late AnimationController expansionAnimationController;

  ValueNotifier<bool> isCancelledNotifier = ValueNotifier<bool>(false);

  void expansionAnimationListener() {
    if (expansionAnimationController.status == AnimationStatus.completed) {
      expansionAnimationController.reverse();
    }
  }

  @override
  void initState() {
    super.initState();

    expansionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    expansionAnimation = Tween(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(
        parent: expansionAnimationController,
        curve: Curves.bounceIn,
      ),
    );

    expansionAnimationController.addListener(expansionAnimationListener);
  }

  @override
  void dispose() {
    super.dispose();

    expansionAnimationController.addListener(expansionAnimationListener);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        expansionAnimationController.forward();
        isCancelledNotifier.value = !isCancelledNotifier.value;
      },
      child: AnimatedBuilder(
        animation: expansionAnimation,
        builder: (context, child) {
          return ValueListenableBuilder<bool>(
            valueListenable: isCancelledNotifier,
            builder: (context, isCancelled, child) {
              return Stack(
                children: [
                  Transform.scale(
                    scale: expansionAnimation.value,
                    child: SizedBox(
                      height: widget.height,
                      width: widget.width,
                      child: Image.asset(
                        widget.imagePath,
                        colorBlendMode:
                            isCancelled ? BlendMode.saturation : null,
                        color: isCancelled ? Colors.grey : null,
                      ),
                    ),
                  ),
                  isCancelled
                      ? Positioned.fill(
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.red.shade900,
                              size: 64,
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
