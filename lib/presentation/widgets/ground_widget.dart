import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/emotion_plant.dart';
import '../../domain/entities/emotion_type.dart';
import '../../domain/providers/garden_provider.dart';
import 'plant_widget.dart';
import 'memory_dialog.dart';

class GroundWidget extends ConsumerWidget {
  final Function(double x, double y) onGroundTap;

  const GroundWidget({Key? key, required this.onGroundTap}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plants = ref.watch(gardenProvider)
        .where((p) => !p.type.isSkyElement)
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapUp: (details) {
            double relativeX = details.localPosition.dx / constraints.maxWidth;
            double relativeY = details.localPosition.dy / constraints.maxHeight;
            onGroundTap(relativeX, relativeY);
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background gradient — flat top edge
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.3, 0.7, 1.0],
                    colors: [
                      Color(0xFF9CCC65),
                      Color(0xFF7CB342),
                      Color(0xFF558B2F),
                      Color(0xFF33691E),
                    ],
                  ),
                ),
              ),

              // Decorative grass tufts along the horizon (static widgets)
              ..._buildGrassTufts(constraints),

              // Scattered field decorations (tiny dots / daisies)
              ..._buildFieldDecorations(constraints),

              // Plants layer
              ...plants.map((plant) {
                return Positioned(
                  left: plant.x * constraints.maxWidth - 20,
                  top: plant.y * constraints.maxHeight - 40,
                  child: PlantWidget(
                    type: plant.type,
                    isBloomed: plant.isBloomed,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black38,
                        builder: (_) => MemoryDialog(plant: plant),
                      );
                    },
                    onLongPress: () {
                      _showDeleteConfirmation(context, ref, plant);
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  /// Builds small grass tuft emoji/icons along the top edge of the ground.
  /// Uses a seeded Random for deterministic positions.
  List<Widget> _buildGrassTufts(BoxConstraints constraints) {
    final rng = Random(42);
    final tufts = <Widget>[];

    final int count = 20;
    final double segmentWidth = constraints.maxWidth / count;

    for (int i = 0; i < count; i++) {
      // Uniform distribution across segments with slight random jitter
      final jitter = (rng.nextDouble() * 0.4 - 0.2) * segmentWidth;
      final x = (i * segmentWidth) + (segmentWidth / 2) + jitter;
      final size = 12.0 + rng.nextDouble() * 10.0;
      final opacity = 0.3 + rng.nextDouble() * 0.4;

      tufts.add(
        Positioned(
          left: x,
          top: -size * 0.6, // Move higher up the horizon
          child: Opacity(
            opacity: opacity,
            child: Text(
              '🌿',
              style: TextStyle(fontSize: size),
            ),
          ),
        ),
      );
    }
    return tufts;
  }

  List<Widget> _buildFieldDecorations(BoxConstraints constraints) {
    final rng = Random(99);
    final decorations = <Widget>[];
    const fieldEmojis = ['🌼', '🍀', '·'];

    final int cols = 5;
    final int rows = 4;
    final cellWidth = constraints.maxWidth / cols;
    final cellHeight = constraints.maxHeight / rows;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        // Skip some cells to keep it feeling natural rather than too dense
        if (rng.nextDouble() > 0.7) continue;

        // Spread them out using the grid with internal jitter
        final x = c * cellWidth + 10.0 + rng.nextDouble() * (cellWidth - 20.0);
        final y = r * cellHeight + 15.0 + rng.nextDouble() * (cellHeight - 30.0);
        
        final emoji = fieldEmojis[rng.nextInt(fieldEmojis.length)];
        final size = emoji == '·' ? (6.0 + rng.nextDouble() * 4.0) : (8.0 + rng.nextDouble() * 6.0);
        final opacity = 0.15 + rng.nextDouble() * 0.25;

        decorations.add(
          Positioned(
            left: x,
            top: y,
            child: Opacity(
              opacity: opacity,
              child: Text(
                emoji,
                style: TextStyle(fontSize: size),
              ),
            ),
          ),
        );
      }
    }
    return decorations;
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, EmotionPlant plant) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF9F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('🌿', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text(
              'Rimuovere?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        content: const Text(
          'Vuoi davvero togliere questo fiore dal giardino?',
          style: TextStyle(color: Color(0xFF795548), fontSize: 15, height: 1.4),
        ),
        actionsPadding: const EdgeInsets.only(right: 16, bottom: 12),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Annulla',
                style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14)),
          ),
          TextButton(
            onPressed: () {
              ref.read(gardenProvider.notifier).removePlant(plant.id);
              Navigator.of(ctx).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFFFEBEE),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Rimuovi',
                style: TextStyle(
                    color: Color(0xFFE57373),
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
