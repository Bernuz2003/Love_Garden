import 'package:sqflite/sqflite.dart';
import '../../domain/entities/emotion_plant.dart';
import '../local/database_helper.dart';

class EmotionRepository {
  Future<List<EmotionPlant>> getAllEmotions() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('emotions');
    return result.map((json) => EmotionPlant.fromMap(json)).toList();
  }

  Future<void> addEmotion(EmotionPlant emotion) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('emotions', emotion.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteEmotion(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('emotions', where: 'id = ?', whereArgs: [id]);
  }
}
