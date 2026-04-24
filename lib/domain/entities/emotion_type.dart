enum EmotionType {
  happiness,
  anger,
  sadness,
  love,
}

extension EmotionTypeExtension on EmotionType {
  String get label {
    switch (this) {
      case EmotionType.happiness: return 'Felicità';
      case EmotionType.anger: return 'Rabbia';
      case EmotionType.sadness: return 'Tristezza';
      case EmotionType.love: return 'Amore';
    }
  }

  String get emoji {
    switch (this) {
      case EmotionType.happiness: return '🌻';
      case EmotionType.anger: return '🌵';
      case EmotionType.sadness: return '💧';
      case EmotionType.love: return '🌹';
    }
  }

  /// Sadness (💧) belongs to the sky; all others belong to the ground.
  bool get isSkyElement {
    return this == EmotionType.sadness;
  }


}
