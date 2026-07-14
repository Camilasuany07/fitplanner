import 'package:flutter/material.dart';
import '../pages/workout_page.dart';

class WorkoutCard extends StatefulWidget {
  final String title;
  final String duration;

  const WorkoutCard({
    super.key,
    required this.title,
    required this.duration,
  });

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  double _scale = 1.0;
  double _elevation = 6;

  void _onTapDown(_) {
    setState(() {
      _scale = 0.96;
      _elevation = 2;
    });
  }

  void _onTapUp(_) {
    setState(() {
      _scale = 1.0;
      _elevation = 6;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _elevation = 6;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WorkoutPage(
              title: widget.title,
              duration: widget.duration,
            ),
          ),
        );
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: _elevation,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.fitness_center, color: Colors.green),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Text(widget.duration),
            ],
          ),
        ),
      ),
    );
  }
}