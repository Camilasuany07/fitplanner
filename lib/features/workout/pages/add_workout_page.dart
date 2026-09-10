import 'package:flutter/material.dart';
import '../models/workout_model.dart';
import '../models/workout_exercise_model.dart';
import '../data/workout_data.dart';
import '../services/storage_service.dart';


class AddWorkoutPage extends StatefulWidget {
  const AddWorkoutPage({super.key});

  @override
  State<AddWorkoutPage> createState() => _AddWorkoutPageState();
}

class _AddWorkoutPageState extends State<AddWorkoutPage> {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final caloriesController = TextEditingController();
  final List<WorkoutExercise> exercises = [];

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    caloriesController.dispose();
    super.dispose();
  }

  Future<void> addExercise() async {
    final exerciseController = TextEditingController();
    final setsController = TextEditingController();
    final repetitionsController = TextEditingController();

    final result = await showDialog<WorkoutExercise>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar exercício'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Ex: Agachamento'),
              ),
              TextField(
                controller: setsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Séries'),
              ),
              TextField(
                controller: repetitionsController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Repetições'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final exercise = exerciseController.text.trim();
                if (exercise.isEmpty) return;

                Navigator.pop(
                  dialogContext,
                  WorkoutExercise(
                    exercise: exercise,
                    sets: int.tryParse(setsController.text) ?? 0,
                    repetitions: int.tryParse(repetitionsController.text) ?? 0,
                  ),
                );
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );

    exerciseController.dispose();
    setsController.dispose();
    repetitionsController.dispose();

    if (result != null) {
      setState(() {
        exercises.add(result);
      });
    }
  }

  void removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  Future<void> saveWorkout() async {
    final name = nameController.text.trim();
    final duration = durationController.text.trim();
    final caloriesText = caloriesController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Digite o nome do treino.')));
      return;
    }

    if (duration.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite a duração do treino.')),
      );
      return;
    }

    final newWorkout = Workout(
      name: name,
      duration: duration,
      calories: int.tryParse(caloriesText) ?? 0,
      exercises: exercises,
      date: DateTime.now(),
    );

    workouts.add(newWorkout);

    await StorageService.saveWorkouts(workouts);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF17123D),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Novo Treino',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Criar treino',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Configure seu treino e adicione os exercícios.',
              style: TextStyle(color: Colors.white60, fontSize: 15),
            ),

            const SizedBox(height: 28),

            // NOME
            _buildLabel('Nome do treino'),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              textCapitalization: TextCapitalization.sentences,
              decoration: _inputDecoration(
                hintText: 'Ex: Pernas',
                icon: Icons.fitness_center,
              ),
            ),

            const SizedBox(height: 20),

            // DURAÇÃO
            _buildLabel('Duração'),

            const SizedBox(height: 8),

            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                hintText: 'Ex: 20',
                icon: Icons.timer_outlined,
                suffixText: 'min',
              ),
            ),

            const SizedBox(height: 20),

            // CALORIAS
            _buildLabel('Calorias estimadas'),

            const SizedBox(height: 8),

            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                hintText: 'Ex: 250',
                icon: Icons.local_fire_department_outlined,
                suffixText: 'kcal',
              ),
            ),

            const SizedBox(height: 30),

            // EXERCÍCIOS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exercícios',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton.icon(
                  onPressed: addExercise,
                  icon: const Icon(Icons.add, color: Color(0xFF6366F1)),
                  label: const Text(
                    'Adicionar',
                    style: TextStyle(
                      color: Color(0xFF6366F1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // LISTA DE EXERCÍCIOS
            if (exercises.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C2E),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: Color(0xFF6366F1),
                      size: 36,
                    ),

                    SizedBox(height: 10),

                    Text(
                      'Nenhum exercício adicionado',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Toque em "Adicionar" para incluir exercícios.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white60, fontSize: 13),
                    ),
                  ],
                ),
              )
            else
              Column(
                children: List.generate(exercises.length, (index) {
                  final exercise = exercises[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C2E),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF6366F1,
                          ).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.fitness_center,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                      title: Text(
                        exercise.exercise,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        '${exercise.sets} séries • ${exercise.repetitions} repetições',
                        style: const TextStyle(color: Colors.white54),
                      ),
                      trailing: IconButton(
                        onPressed: () => removeExercise(index),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  );
                }),
              ),

            const SizedBox(height: 30),

            // SALVAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: saveWorkout,
                icon: const Icon(Icons.save_outlined, color: Colors.white),
                label: const Text(
                  'Salvar treino',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    String? suffixText,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white38),
      prefixIcon: Icon(icon, color: const Color(0xFF6366F1)),
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.white60),
      filled: true,
      fillColor: const Color(0xFF1C1C2E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}
