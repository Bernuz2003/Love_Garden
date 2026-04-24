import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/emotion_repository.dart';
import '../entities/emotion_plant.dart';

final emotionRepositoryProvider = Provider((ref) => EmotionRepository());

final gardenProvider = StateNotifierProvider<GardenNotifier, List<EmotionPlant>>((ref) {
  final repo = ref.watch(emotionRepositoryProvider);
  return GardenNotifier(repo)..loadEmotions();
});

class GardenNotifier extends StateNotifier<List<EmotionPlant>> {
  final EmotionRepository _repository;

  GardenNotifier(this._repository) : super([]);

  Future<void> loadEmotions() async {
    state = await _repository.getAllEmotions();
  }

  Future<void> addPlant(EmotionPlant plant) async {
    await _repository.addEmotion(plant);
    state = [...state, plant];
  }

  Future<void> removePlant(String id) async {
    await _repository.deleteEmotion(id);
    state = state.where((p) => p.id != id).toList();
  }
}
