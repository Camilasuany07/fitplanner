import 'package:flutter/material.dart';


class WorkoutPage extends StatelessWidget {
  final String title;
  final String duration;

  const WorkoutPage({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Treino: $title\nDuração: $duration',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}