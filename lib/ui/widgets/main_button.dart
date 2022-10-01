import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.child,
    required this.onTap,
    this.height,
    this.width,
    this.padding,
    this.backgroundColor,
    super.key,
  });

  final Widget child;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(1, 1),
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          height: height,
          width: width,
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 16.0,
              ),
          child: child,
        ),
      ),
    );
  }
}
