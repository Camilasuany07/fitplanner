import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../data/workout_data.dart';
import '../../workout/services/storage_service.dart';

class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final caloriesController = TextEditingController();

   Future<void> saveWorkout() async {
    final newWorkout = Workout(
      name: nameController.text,
      duration: durationController.text,
      calories: int.tryParse(caloriesController.text) ?? 0,
      exercises: [],
    );

    workouts.add(newWorkout);
    
    await StorageService.saveWorkouts(workouts);
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Treino')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nome do treino'),
            ),
            TextField(
              controller: durationController,
              decoration: const InputDecoration(labelText: 'Duração'),
            ),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Calorias'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveWorkout,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}