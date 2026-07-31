import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../services/storage_service.dart';
import '../data/workout_data.dart';

class EditWorkoutPage extends StatefulWidget {
  final Workout workout;
  final int index;

  const EditWorkoutPage({
    super.key,
    required this.workout,
    required this.index,
  });

  @override
  State<EditWorkoutPage> createState() => _EditWorkoutPageState();
}

class _EditWorkoutPageState extends State<EditWorkoutPage> {
  late TextEditingController nameController;
  late TextEditingController durationController;
  late TextEditingController caloriesController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.workout.name);
    durationController = TextEditingController(text: widget.workout.duration);
    caloriesController =
        TextEditingController(text: widget.workout.calories.toString());
  }

  Future saveEdit() async {
    final updatedWorkout = Workout(
      name: nameController.text,
      duration: durationController.text,
      calories: int.tryParse(caloriesController.text) ?? 0,
      exercises: widget.workout.exercises,
      date: widget.workout.date,
    );

    setState(() {
      workouts[widget.index] = updatedWorkout;
    });

    await StorageService.saveWorkouts(workouts);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar treino')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duração'),
            ),
            TextField(
              controller: caloriesController,
              decoration: const InputDecoration(labelText: 'Calorias'),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveEdit,
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}