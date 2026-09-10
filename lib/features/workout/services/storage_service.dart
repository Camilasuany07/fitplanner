import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_model.dart';

class StorageService {
  static const String key = 'workouts';

  // SALVAR
  static Future<void> saveWorkouts(List<Workout> workouts) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = workouts
        .map((w) => jsonEncode(w.toMap()))
        .toList();

    await prefs.setStringList(key, data);
  }


  // CARREGAR
  static Future<List<Workout>> loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data == null) return [];

    return data.map((item) {
      try {
        dynamic decoded = jsonDecode(item);

        if (decoded is String) {
          decoded = jsonDecode(decoded);
        }

        if (decoded is! Map) return null;

        return Workout.fromMap(Map<String, dynamic>.from(decoded));
      } on FormatException {
        return null;
      } on TypeError {
        return null;
      }
    }).whereType<Workout>().toList();
  }
}