import '../models/workout_model.dart';
import '../models/workout_exercise_model.dart';

final List<Workout> workouts = [
  Workout(
    name: 'Peito e Tríceps',
    duration: '45 min',
    calories: 320,
    exercises: [
      WorkoutExercise(
        exercise: 'Supino reto',
        sets: 3,
        repetitions: 10,
        weight: 20,
      ),
      WorkoutExercise(
        exercise: 'Crucifixo',
        sets: 3,
        repetitions: 12,
        weight: 10,
      ),
      WorkoutExercise(
        exercise: 'Tríceps corda',
        sets: 3,
        repetitions: 12,
        weight: 15,
      ),
    ],
    date: DateTime.now(),
  ),
  Workout(
    name: 'Cardio',
    duration: '30 min',
    calories: 200,
    exercises: [
      WorkoutExercise(
        exercise: 'Esteira',
        sets: 1,
        repetitions: 1,
        weight: 0,
      ),
      WorkoutExercise(
        exercise: 'Bike',
        sets: 1,
        repetitions: 1,
        weight: 0,
      ),
    ],
    date: DateTime.now(),
  ),
];