import 'package:flutter/material.dart';

class FullWidthCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const FullWidthCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1E22),

        borderRadius: BorderRadius.circular(18),

        // Subtle edge definition (important in dark mode)
        border: Border.all(
          color: const Color(0xFF242A30),
          width: 1,
        ),

        // Subtle depth (premium, not Material-heavy)
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000), // ~8% black
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
