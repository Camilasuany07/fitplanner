import 'package:flutter/material.dart';
import '../../workout/data/workout_data.dart';
import '../../workout/widgets/workout_card.dart';
import '../../workout/widgets/progress_chart.dart';
import '../../workout/pages/add_workout_page.dart';
import '../../workout/services/storage_service.dart';
import '../../workout/pages/edit_workout_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final savedWorkouts = await StorageService.loadWorkouts();

    setState(() {
      workouts.clear();
      workouts.addAll(savedWorkouts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddWorkoutPage()),
          );

          await loadData();
        },
        backgroundColor: const Color.fromARGB(255, 54, 41, 158),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 246),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 23, 18, 61),
        title: const Text(
          'FitPlanner',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Camila 👋',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 20),

            // 🔥 CARD DINÂMICO
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 57, 46, 209),
                    Color.fromARGB(255, 43, 41, 112),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Treinos hoje',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${workouts.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Calorias',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${workouts.fold(0, (sum, w) => sum + w.calories)} kcal',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BOTÃO
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Treino iniciado 💪')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 23, 18, 61),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Iniciar treino',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Treinos de hoje',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              'Seu progresso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 160, // 👈 controla o tamanho
              child: ProgressChart(workouts: workouts),
            ),

            const SizedBox(height: 20),

            // 🔥 LISTA
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Dismissible(
                    key: Key('$index-${workout.name}'),

                    direction: DismissDirection.endToStart,

                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Excluir treino'),
                              content: const Text('Tem certeza?'),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Excluir'),
                                ),
                              ],
                            ),
                      );
                    },

                    onDismissed: (direction) async {
                      final removedWorkout = workout;

                      setState(() {
                        workouts.removeAt(index);
                      });

                      await StorageService.saveWorkouts(workouts);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${removedWorkout.name} removido'),
                        ),
                      );
                    },

                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: WorkoutCard(
                      title: workout.name,
                      duration: workout.duration,

                      // 👉 clique no card inteiro
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Abrindo ${workout.name}')),
                        );
                      },

                      // 👉 botão de editar ✏️
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => EditWorkoutPage(
                                  workout: workout,
                                  index: index,
                                ),
                          ),
                        ).then((_) => loadData());
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
