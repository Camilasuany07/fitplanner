class Workout {
  final String name;
  final String duration;
  final int calories;
  final List<String> exercises;
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
      'exercises': exercises,
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      name: map['name'] ?? '',
      duration: map['duration'] ?? '',
      calories: map['calories'] ?? 0,
      exercises: List<String>.from(map['exercises'] ?? []),
      date: DateTime.parse(
        map['date'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}