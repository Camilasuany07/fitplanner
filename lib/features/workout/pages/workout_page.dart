import 'dart:async';

import 'package:flutter/material.dart';

class WorkoutPage extends StatefulWidget {
  final String title;
  final String duration;

  const WorkoutPage({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  Timer? _timer;

  int _remainingSeconds = 0;

  bool _isRunning = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();

    _remainingSeconds = _durationInSeconds();
  }

  int _durationInSeconds() {
    final minutes = int.tryParse(widget.duration) ?? 0;
    return minutes * 60;
  }

  void _startWorkout() {
    if (_remainingSeconds <= 0) {
      return;
    }

    setState(() {
      _isRunning = true;
      _isFinished = false;
    });

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingSeconds <= 1) {
          timer.cancel();

          setState(() {
            _remainingSeconds = 0;
            _isRunning = false;
            _isFinished = true;
          });

          _showFinishedMessage();

          return;
        }

        setState(() {
          _remainingSeconds--;
        });
      },
    );
  }

  void _pauseWorkout() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
    });
  }

  void _finishWorkout() {
    _timer?.cancel();

    setState(() {
      _isRunning = false;
      _isFinished = true;
    });

    _showFinishedMessage();
  }

  void _showFinishedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Treino concluído! 💪🔥'),
      ),
    );
  }

  void _resetWorkout() {
    _timer?.cancel();

    setState(() {
      _remainingSeconds = _durationInSeconds();
      _isRunning = false;
      _isFinished = false;
    });
  }

  String _formatTime() {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF17123D),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Detalhes do treino',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 24),

            // CARD DE INFORMAÇÕES
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF392ED1),
                    Color(0xFF2B2970),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Expanded(
                    child: _InfoItem(
                      icon: Icons.timer_outlined,
                      label: 'Duração',
                      value: widget.duration,
                    ),
                  ),

                  Container(
                    width: 1,
                    height: 45,
                    color: Colors.white24,
                  ),

                  Expanded(
                    child: _InfoItem(
                      icon: Icons.fitness_center,
                      label: 'Treino',
                      value: _isFinished
                          ? 'Concluído'
                          : _isRunning
                              ? 'Em andamento'
                              : 'Ativo',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // CRONÔMETRO
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C2E),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const Text(
                    'Tempo restante',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    _formatTime(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _isFinished
                        ? 'Treino concluído! 🎉'
                        : _isRunning
                            ? 'Treino em andamento 💪'
                            : 'Pronto para começar',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // SEÇÃO EXERCÍCIOS
            const Text(
              'Exercícios',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

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
                    size: 40,
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Nenhum exercício cadastrado',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'Em breve você poderá adicionar exercícios a este treino.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BOTÕES
            if (!_isRunning && !_isFinished)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _startWorkout,

                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Iniciar treino',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

            if (_isRunning)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _pauseWorkout,

                      icon: const Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),

                      label: const Text(
                        'Pausar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _finishWorkout,

                      icon: const Icon(
                        Icons.stop,
                        color: Colors.white,
                      ),

                      label: const Text(
                        'Finalizar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            if (!_isRunning && _isFinished)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _resetWorkout,

                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),

                  label: const Text(
                    'Treinar novamente',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    padding: const EdgeInsets.symmetric(
                      vertical: 17,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


// WIDGET PARA AS INFORMAÇÕES DO TREINO
class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),

        const SizedBox(height: 8),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}