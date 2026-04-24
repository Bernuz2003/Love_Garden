import 'package:flutter/material.dart';
import '../../domain/entities/emotion_type.dart';

class PlantWidget extends StatelessWidget {
  final EmotionType type;
  final bool isBloomed;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const PlantWidget({
    Key? key,
    required this.type,
    required this.isBloomed,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: Text(
          isBloomed ? type.emoji : '🌱', // Bud emoji or bloomed emoji
          key: ValueKey(isBloomed),
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
