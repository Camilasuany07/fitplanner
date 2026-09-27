import 'workout_exercise_model.dart';

class Workout {
  final String name;
  final String duration;
  final int calories;
  final List<WorkoutExercise> exercises;
  final DateTime date;

  Workout({
    required this.name,
    required this.duration,
    required this.calories,
    required this.exercises,
    required this.date,
  });

  static int? parseDurationMinutes(String value) {
    final match = RegExp(
      r'^\s*(\d+)\s*(?:min(?:uto(?:s)?)?)?\s*$',
      caseSensitive: false,
    ).firstMatch(value);
    return match == null ? null : int.tryParse(match.group(1)!);
  }

  static String normalizeDuration(String value) {
    final minutes = parseDurationMinutes(value);
    return minutes?.toString() ?? value.trim();
  }

  int? get durationMinutes => parseDurationMinutes(duration);

  String get formattedDuration {
    final minutes = durationMinutes;
    return minutes == null ? duration : '$minutes min';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'calories': calories,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      duration: normalizeDuration(map['duration']?.toString() ?? ''),
      calories: map['calories'] ?? 0,
      exercises:
          (map['exercises'] as List<dynamic>? ?? []).map((exercise) {
            if (exercise is String) {
              return WorkoutExercise(
                exercise: exercise,
                sets: 0,
                repetitions: 0,
              );
            }

            if (exercise is Map) {
              return WorkoutExercise.fromMap(
                Map<String, dynamic>.from(exercise),
              );
            }

            return WorkoutExercise(
              exercise: exercise.toString(),
              sets: 0,
              repetitions: 0,
            );
          }).toList(),
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
    );
  }
}
