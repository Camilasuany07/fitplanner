import 'package:flutter/material.dart';
import '../../workout/pages/workout_page.dart';
import '../../workout/data/workout_data.dart';
import '../../workout/widgets/workout_card.dart';
import '../../workout/widgets/progress_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'FitPlanner',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 20),

            // Card resumo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00C853), Color(0xFF64DD17)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Treinos hoje',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Calorias', style: TextStyle(color: Colors.white)),
                      SizedBox(height: 8),
                      Text(
                        '520 kcal',
                        style: TextStyle(
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

            // Botão iniciar treino
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Treino iniciado 💪')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Iniciar treino',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Treinos de hoje',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // Gráfico de progresso
            const SizedBox(height: 20),

            const Text(
              'Seu progresso 📊',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ProgressChart(workouts: workouts),

            // Lista de treinos
            Expanded(
              child: ListView.builder(
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];

                  return WorkoutCard(
                    title: workout.name,
                    duration: workout.duration,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWorkoutCard(BuildContext context, String title, String duration) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: Colors.green.withValues(alpha: 0.2),
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    WorkoutPage(title: title, duration: duration),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              const begin = Offset(1.0, 0.0); // vem da direita
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              final tween = Tween(
                begin: begin,
                end: end,
              ).chain(CurveTween(curve: curve));

              final offsetAnimation = animation.drive(tween);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: offsetAnimation, child: child),
              );
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Row(
          children: [
            const Icon(Icons.fitness_center, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(duration),
          ],
        ),
      ),
    );
  }
}
