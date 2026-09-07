import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${appState.totalWorkouts}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const Text('workouts completed'),
            const SizedBox(height: 16),
            Text('${appState.totalCalories} kcal burned'),
            Text('${appState.streak} day streak'),
          ],
        ),
      ),
    );
  }
}
