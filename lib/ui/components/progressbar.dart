
import 'package:flutter/material.dart';

class GradientProgressBar extends StatelessWidget {
  final double value;
  final Color startColor;
  final Color endColor;
  final double height;
  final Widget? headline;

  const GradientProgressBar({
    required this.value,
    required this.startColor,
    required this.endColor,
    this.height = 10,
    this.headline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, 
      children:[
        if(headline != null) headline!,
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 4),
          child: Stack(
            children: [
              Container(
                height: height,
                color: scheme.surfaceContainerHighest,
              ),

              FractionallySizedBox(
                widthFactor: value.clamp(0.0, 1.0),
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [startColor, endColor],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]);
  }
}
