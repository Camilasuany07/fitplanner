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

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'calories': calories,
      'exercises': exercises
          .map((exercise) => exercise.toMap())
          .toList(),
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      duration: map['duration'] ?? '',
      calories: map['calories'] ?? 0,
      exercises: (map['exercises'] as List<dynamic>? ?? []).map((exercise) {
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
      date: DateTime.parse(
        map['date'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}