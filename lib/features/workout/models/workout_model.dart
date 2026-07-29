class Workout {
  final String name;
  final String duration;
  final int calories;
  final List<String> exercises;

  Workout({
    required this.name,
    required this.duration,
    required this.calories,
    required this.exercises,
  });

  // 🔥 converter para Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'calories': calories,
      'exercises': exercises,
    };
  }

  // 🔥 criar a partir do Map
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      duration: map['duration'] ?? '',
      calories: map['calories'] ?? 0,
      exercises: List<String>.from(map['exercises'] ?? []),
    );
  }
}
