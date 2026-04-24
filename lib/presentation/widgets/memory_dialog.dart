import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/emotion_plant.dart';
import '../../domain/entities/emotion_type.dart';

class MemoryDialog extends StatefulWidget {
  final EmotionPlant plant;

  const MemoryDialog({Key? key, required this.plant}) : super(key: key);

  @override
  State<MemoryDialog> createState() => _MemoryDialogState();
}

class _MemoryDialogState extends State<MemoryDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plant = widget.plant;
    final colors = _emotionColors(plant.type);
    final dateStr = DateFormat('d MMMM yyyy', 'it').format(plant.createdAt);
    final timeStr = DateFormat('HH:mm').format(plant.createdAt);

    return FadeTransition(
      opacity: _fadeAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colors.$1.withOpacity(0.15),
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: colors.$1.withOpacity(0.25),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: colors.$1.withOpacity(0.15),
                  offset: const Offset(0, 10),
                  blurRadius: 30,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top accent bar
                Container(
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [colors.$1, colors.$2]),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(4),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Emoji with glow
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.$1.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                        color: colors.$1.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    plant.isBloomed ? plant.type.emoji : '🌱',
                    style: const TextStyle(fontSize: 36),
                  ),
                ),

                const SizedBox(height: 16),

                // Emotion label
                Text(
                  plant.type.label,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.$1,
                    letterSpacing: 0.5,
                  ),
                ),



                const SizedBox(height: 20),

                // Date and time
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 8),
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.access_time_rounded,
                          size: 14, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Note content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    plant.note,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF37474F),
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Status indicator
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: plant.isBloomed
                              ? const Color(0xFF66BB6A)
                              : const Color(0xFFFFB74D),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        plant.isBloomed ? 'Sbocciato' : 'In crescita...',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Close button
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 10),
                    decoration: BoxDecoration(
                      color: colors.$1.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Chiudi',
                      style: TextStyle(
                        color: colors.$1,
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

  /// Returns (primary, secondary) colors for each emotion type.
  (Color, Color) _emotionColors(EmotionType type) {
    switch (type) {
      case EmotionType.happiness:
        return (const Color(0xFFF9A825), const Color(0xFFFFD54F));
      case EmotionType.anger:
        return (const Color(0xFF8D6E63), const Color(0xFFBCAAA4));
      case EmotionType.sadness:
        return (const Color(0xFF5C6BC0), const Color(0xFF9FA8DA));
      case EmotionType.love:
        return (const Color(0xFFEC407A), const Color(0xFFF48FB1));
    }
  }
}
