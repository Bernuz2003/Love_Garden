import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/emotion_type.dart';
import '../../domain/providers/garden_provider.dart';
import 'plant_widget.dart';
import 'memory_dialog.dart';

/// Renders sky-bound plants (💧 sadness drops) positioned in the sky area.
class SkyPlantsLayer extends ConsumerWidget {
  const SkyPlantsLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skyPlants = ref.watch(gardenProvider)
        .where((p) => p.type.isSkyElement)
        .toList();

    if (skyPlants.isEmpty) return const SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: skyPlants.map((plant) {
            return Positioned(
              left: plant.x * constraints.maxWidth - 16,
              top: plant.y * constraints.maxHeight - 16,
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
          }).toList(),
        );
      },
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, dynamic plant) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFF9F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('💧', style: TextStyle(fontSize: 24)),
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
          'Vuoi davvero togliere questa goccia dal cielo?',
          style:
              TextStyle(color: Color(0xFF795548), fontSize: 15, height: 1.4),
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
              backgroundColor: const Color(0xFFE3F2FD),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Rimuovi',
                style: TextStyle(
                    color: Color(0xFF5C6BC0),
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
