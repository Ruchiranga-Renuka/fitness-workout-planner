import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/exercise.dart';
import '../providers/app_state.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;
  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero banner ──────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 64,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    exercise.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(exercise.category),
                    backgroundColor: colorScheme.primary,
                    labelStyle: TextStyle(color: colorScheme.onPrimary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Quick stats ──────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.timer_outlined,
                    label: 'Duration',
                    value: '${exercise.duration} min',
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.local_fire_department_outlined,
                    label: 'Calories',
                    value: '${exercise.calories} kcal',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ── Description ──────────────────────────────────────
            const Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              exercise.description,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),

            const SizedBox(height: 20),

            // ── Instructions ─────────────────────────────────────
            const Text(
              'Instructions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...exercise.instructions.split('\n').map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle,
                        size: 20, color: colorScheme.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(step, style: const TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),

      // ── Complete button ──────────────────────────────────────────
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: FilledButton.icon(
          icon: const Icon(Icons.check_circle_outline),
          label: const Text(
            'Mark as Complete',
            style: TextStyle(fontSize: 16),
          ),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            await context.read<AppState>().completeExercise(exercise);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('✅ ${exercise.name} completed!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(label, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
