class WorkoutCompletion {
  const WorkoutCompletion({
    required this.workoutName,
    required this.completedAt,
    this.duration = '',
    this.calories = 0,
  });

  final String workoutName;
  final DateTime completedAt;
  final String duration;
  final int calories;

  Map<String, dynamic> toMap() => {
    'workoutName': workoutName,
    'completedAt': completedAt.toIso8601String(),
    'duration': duration,
    'calories': calories,
  };

  factory WorkoutCompletion.fromMap(Map<String, dynamic> map) {
    return WorkoutCompletion(
      workoutName: map['workoutName'] as String? ?? 'Treino concluído',
      completedAt: DateTime.parse(map['completedAt'] as String),
      duration: map['duration'] as String? ?? '',
      calories: map['calories'] as int? ?? 0,
    );
  }
}
