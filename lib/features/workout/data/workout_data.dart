import '../models/workout_model.dart';

final List<Workout> workouts = [
  Workout(
    name: 'Peito e Tríceps',
    duration: '45 min',
    calories: 320,
    exercises: [
      'Supino reto',
      'Crucifixo',
      'Tríceps corda',
    ],
  ),
  Workout(
    name: 'Cardio',
    duration: '30 min',
    calories: 200,
    exercises: [
      'Esteira',
      'Bike',
    ],
  ),
];