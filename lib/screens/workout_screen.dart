import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/exercise_data.dart';
import '../providers/app_state.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workouts')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return Card(
            child: ListTile(
              title: Text(exercise.name),
              subtitle: Text(
                '${exercise.description}\n${exercise.duration} min - ${exercise.calories} kcal',
              ),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Icons.check_circle_outline),
                tooltip: 'Complete workout',
                onPressed: () {
                  context.read<AppState>().completeExercise(exercise);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${exercise.name} completed')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
