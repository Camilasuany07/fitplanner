import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout_completion_model.dart';
import '../models/workout_model.dart';

class StorageService {
  static const String key = 'workouts';
  static const String completionKey = 'workout_completions';

  // SALVAR
  static Future<void> saveWorkouts(List<Workout> workouts) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data =
        workouts.map((w) => jsonEncode(w.toMap())).toList();

    await prefs.setStringList(key, data);
  }

  // CARREGAR
  static Future<List<Workout>> loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((item) {
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
        })
        .whereType<Workout>()
        .toList();
  }

  static Future<void> recordWorkoutCompletion(
    WorkoutCompletion completion,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final completions = prefs.getStringList(completionKey) ?? [];
    completions.add(jsonEncode(completion.toMap()));
    final saved = await prefs.setStringList(completionKey, completions);
    if (!saved) {
      throw StateError('Não foi possível salvar a conclusão do treino.');
    }
  }

  static Future<List<WorkoutCompletion>> loadWorkoutCompletions() async {
    final prefs = await SharedPreferences.getInstance();
    final completions = prefs.getStringList(completionKey) ?? [];

    return completions
        .map((value) {
          try {
            final decoded = jsonDecode(value);
            if (decoded is Map) {
              return WorkoutCompletion.fromMap(
                Map<String, dynamic>.from(decoded),
              );
            }
            if (decoded is String) {
              final legacyDate = DateTime.tryParse(decoded);
              if (legacyDate != null) {
                return WorkoutCompletion(
                  workoutName: 'Treino concluído',
                  completedAt: legacyDate,
                );
              }
            }
            return null;
          } on FormatException {
            final legacyDate = DateTime.tryParse(value);
            if (legacyDate == null) return null;
            return WorkoutCompletion(
              workoutName: 'Treino concluído',
              completedAt: legacyDate,
            );
          } on TypeError {
            return null;
          }
        })
        .whereType<WorkoutCompletion>()
        .toList();
  }
}
