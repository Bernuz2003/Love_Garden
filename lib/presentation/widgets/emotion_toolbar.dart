import 'package:flutter/material.dart';
import '../../domain/entities/emotion_type.dart';

class EmotionToolbar extends StatelessWidget {
  final EmotionType selectedType;
  final ValueChanged<EmotionType> onSelect;
  final VoidCallback onOpenDiary;

  const EmotionToolbar({
    Key? key,
    required this.selectedType,
    required this.onSelect,
    required this.onOpenDiary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Emotion Buttons
          ...EmotionType.values.map((type) {
            final isSelected = type == selectedType;
            final colors = _emotionAccent(type);
            return GestureDetector(
              onTap: () => onSelect(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? colors.$1.withOpacity(0.15) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? colors.$1 : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: AnimatedScale(
                  scale: isSelected ? 1.2 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    type.emoji,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
            );
          }).toList(),
          
          // Divider
          Container(
            width: 1,
            height: 32,
            color: Colors.grey.withOpacity(0.3),
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),

          // Diary Button
          GestureDetector(
            onTap: onOpenDiary,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF8D6E63).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.book_rounded,
                color: Color(0xFF8D6E63),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  (Color, Color) _emotionAccent(EmotionType type) {
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
