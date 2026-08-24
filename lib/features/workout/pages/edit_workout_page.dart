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
  late TextEditingController exerciseController;

  late List<String> exercises;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.workout.name);

    durationController = TextEditingController(text: widget.workout.duration);

    caloriesController = TextEditingController(
      text: widget.workout.calories.toString(),
    );

    exerciseController = TextEditingController();

    exercises = List<String>.from(widget.workout.exercises);
  }

  @override
  void dispose() {
    nameController.dispose();
    durationController.dispose();
    caloriesController.dispose();
    exerciseController.dispose();
    super.dispose();
  }

  Future<void> addExercise() async {
    exerciseController.clear();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar exercício'),
          content: TextField(
            controller: exerciseController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Ex: Agachamento'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final exercise = exerciseController.text.trim();

      if (exercise.isNotEmpty) {
        setState(() {
          exercises.add(exercise);
        });
      }
    }

    exerciseController.clear();
  }

  Future<void> editExercise(int index) async {
    if (index < 0 || index >= exercises.length) return;

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return _EditExerciseDialog(
          initialValue: exercises[index],
        );
      },
    );

    if (!mounted) return;

    if (result != null && result.isNotEmpty && index < exercises.length) {
      setState(() {
        exercises[index] = result;
      });
    }
  }

  void removeExercise(int index) {
    setState(() {
      exercises.removeAt(index);
    });
  }

  Future<void> saveEdit() async {
    if (isSaving) return;

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

    final updatedWorkout = Workout(
      name: name,
      duration: duration,
      calories: int.tryParse(caloriesText) ?? 0,
      exercises: List<String>.from(exercises),
      date: widget.workout.date,
    );

    if (widget.index < 0 || widget.index >= workouts.length) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível localizar o treino.')),
      );
      return;
    }

    setState(() {
      isSaving = true;
      workouts[widget.index] = updatedWorkout;
    });

    try {
      await StorageService.saveWorkouts(workouts);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao salvar as alterações.')),
      );
      return;
    }

    if (!mounted) return;

    setState(() {
      isSaving = false;
    });

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
          'Editar Treino',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar treino',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Atualize as informações do seu treino.',
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
                      'Nenhum exercício cadastrado',
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
                        exercise,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      subtitle: Text(
                        'Exercício ${index + 1}',
                        style: const TextStyle(color: Colors.white54),
                      ),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () => editExercise(index),
                            icon: const Icon(
                              Icons.edit_outlined,
                              color: Color(0xFF6366F1),
                            ),
                          ),

                          IconButton(
                            onPressed: () => removeExercise(index),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
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
                onPressed: isSaving ? null : saveEdit,
                icon: const Icon(Icons.save_outlined, color: Colors.white),
                label: const Text(
                  'Salvar alterações',
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

class _EditExerciseDialog extends StatefulWidget {
  final String initialValue;

  const _EditExerciseDialog({required this.initialValue});

  @override
  State<_EditExerciseDialog> createState() => _EditExerciseDialogState();
}

class _EditExerciseDialogState extends State<_EditExerciseDialog> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void save() {
    final exercise = value.trim();
    if (exercise.isNotEmpty) {
      Navigator.pop(context, exercise);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar exercício'),
      content: TextFormField(
        initialValue: widget.initialValue,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(hintText: 'Nome do exercício'),
        onChanged: (newValue) => value = newValue,
        onSubmitted: (_) => save(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: save,
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
