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

    return data
        .map((item) => Workout.fromMap(jsonDecode(item)))
        .toList();
  }
}