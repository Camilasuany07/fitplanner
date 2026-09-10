class WorkoutExercise {
  final String exercise;
  final int sets;
  final int repetitions;
  final double weight;

  WorkoutExercise({
    required this.exercise,
    required this.sets,
    required this.repetitions,
    this.weight = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise,
      'sets': sets,
      'repetitions': repetitions,
      'weight': weight,
    };
  }

  factory WorkoutExercise.fromMap(Map<String, dynamic> map) {
    return WorkoutExercise(
      exercise: map['exercise'] ?? '',
      sets: map['sets'] ?? 0,
      repetitions: map['repetitions'] ?? 0,
      weight: (map['weight'] ?? 0).toDouble(),
    );
  }
}