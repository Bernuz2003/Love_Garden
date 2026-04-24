import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/emotion_plant.dart';
import '../../domain/entities/emotion_type.dart';
import '../../domain/providers/garden_provider.dart';
import '../widgets/sky_widget.dart';
import '../widgets/ground_widget.dart';
import '../widgets/timer_widget.dart';
import '../widgets/bee_widget.dart';
import '../widgets/add_emotion_sheet.dart';
import '../widgets/sky_plants_layer.dart';
import '../widgets/emotion_toolbar.dart';
import 'diary_screen.dart';

class GardenScreen extends ConsumerStatefulWidget {
  const GardenScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GardenScreen> createState() => _GardenScreenState();
}

class _GardenScreenState extends ConsumerState<GardenScreen> {
  static const double _groundTopFraction = 0.45;
  EmotionType _selectedEmotion = EmotionType.happiness;

  @override
  Widget build(BuildContext context) {
    final isMagicDay = DateTime.now().day == 4;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Sky layer (full width, top portion — tappable for 💧)
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapUp: (details) {
              final relX = details.localPosition.dx / MediaQuery.of(context).size.width;
              final relY = details.localPosition.dy / (screenHeight * _groundTopFraction);
              _handleAreaTap(relX, relY.clamp(0.0, 1.0), isSkyZone: true);
            },
            child: const SkyWidget(),
          ),

          // 1b. Sky plants layer (💧 drops in the sky)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * _groundTopFraction,
            child: const SkyPlantsLayer(),
          ),

          // 2. Ground layer
          Positioned.fill(
            top: screenHeight * _groundTopFraction,
            child: GroundWidget(
              onGroundTap: (x, y) {
                _handleAreaTap(x, y, isSkyZone: false);
              },
            ),
          ),

          // 3. Timer — top center, near the edge
          const Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(child: SafeArea(child: TimerWidget())),
          ),

          // 4. Magic Flower (Only on the 4th of the month)
          if (isMagicDay)
            Positioned(
              bottom: 120, // Moved up to not overlap toolbar
              right: 30,
              child: GestureDetector(
                onTap: () => _showMagicMessage(context),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 2),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Text('✨💖✨', style: TextStyle(fontSize: 36)),
                  ),
                ),
              ),
            ),

          // 5. The affectionate bee
          const BeeWidget(),

          // 6. Emotion Toolbar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: EmotionToolbar(
                selectedType: _selectedEmotion,
                onSelect: (type) => setState(() => _selectedEmotion = type),
                onOpenDiary: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DiaryScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAreaTap(double x, double y, {required bool isSkyZone}) {
    if (_selectedEmotion.isSkyElement && !isSkyZone) {
      _showZoneError(context, '☁️', 'Le gocce vanno in cielo, scemetta!');
      return;
    }
    if (!_selectedEmotion.isSkyElement && isSkyZone) {
      _showZoneError(context, '🌱', 'Non puoi piantare in cielo, scemetta!');
      return;
    }

    // Zone is valid, proceed to ask for note
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: AddEmotionSheet(
            onSave: (note) {
              final newPlant = EmotionPlant(
                id: const Uuid().v4(),
                type: _selectedEmotion,
                note: note,
                createdAt: DateTime.now(),
                x: x,
                y: y,
              );
              ref.read(gardenProvider.notifier).addPlant(newPlant);
              return true;
            },
          ),
        );
      },
    );
  }

  void _showZoneError(BuildContext context, String emoji, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (ctx) => _ZoneErrorDialog(emoji: emoji, message: message),
    );
  }

  void _showMagicMessage(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFF8E1), Color(0xFFFCE4EC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.amber.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.amber.withOpacity(0.2),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('✨', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 16),
              const Text(
                'Buon mesiversario,\namore mio!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFAD1457),
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              const Text('💖', style: TextStyle(fontSize: 28)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _ZoneErrorDialog — cute animated popup for wrong zone placement
// ---------------------------------------------------------------------------
class _ZoneErrorDialog extends StatefulWidget {
  final String emoji;
  final String message;

  const _ZoneErrorDialog({required this.emoji, required this.message});

  @override
  State<_ZoneErrorDialog> createState() => _ZoneErrorDialogState();
}

class _ZoneErrorDialogState extends State<_ZoneErrorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFF8E1), Color(0xFFFFF3E0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFFFCC80),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Big emoji
                Text(widget.emoji, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 16),
                // Message
                Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF5D4037),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // Dismiss button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE0B2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFCC80),
                      ),
                    ),
                    child: const Text(
                      'Ho capito! 😄',
                      style: TextStyle(
                        color: Color(0xFF5D4037),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

