import 'emotion_type.dart';

class EmotionPlant {
  final String id;
  final EmotionType type;
  final String note;
  final DateTime createdAt;
  final double x;
  final double y;

  EmotionPlant({
    required this.id,
    required this.type,
    required this.note,
    required this.createdAt,
    required this.x,
    required this.y,
  });

  bool get isBloomed {
    // Sky elements (💧) appear immediately — no bud phase.
    if (type.isSkyElement) return true;
    // Ground plants need 4 hours to bloom.
    return DateTime.now().difference(createdAt).inHours >= 4;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'note': note,
      'createdAt': createdAt.toIso8601String(),
      'x': x,
      'y': y,
    };
  }

  factory EmotionPlant.fromMap(Map<String, dynamic> map) {
    return EmotionPlant(
      id: map['id'],
      type: EmotionType.values[map['type']],
      note: map['note'],
      createdAt: DateTime.parse(map['createdAt']),
      x: map['x'],
      y: map['y'],
    );
  }
}
