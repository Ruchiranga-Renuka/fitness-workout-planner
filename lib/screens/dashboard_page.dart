import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

const _quotes = [
  "The only bad workout is the one that didn't happen.",
  "Push yourself, because no one else is going to do it for you.",
  "Success starts with self-discipline.",
  "Your body can stand almost anything. It's your mind you have to convince.",
  "Don't limit your challenges, challenge your limits.",
];

class DashboardPage extends StatelessWidget {
  final VoidCallback? onGoToWorkout;
  const DashboardPage({super.key, this.onGoToWorkout});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final todayQuote = _quotes[DateTime.now().day % _quotes.length];
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning, ${appState.userProfile.name}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'A small session today keeps your momentum going.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 20),

            Card(
              color: colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ready for your next win?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${appState.streak} day streak  |  ${appState.userProfile.goal}',
                            style: TextStyle(
                              color: colorScheme.onPrimary.withAlpha(210),
                            ),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            onPressed: onGoToWorkout,
                            style: FilledButton.styleFrom(
                              backgroundColor: colorScheme.onPrimary,
                              foregroundColor: colorScheme.primary,
                            ),
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Start workout'),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.directions_run_rounded,
                      size: 72,
                      color: colorScheme.onPrimary.withAlpha(210),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Your overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.55,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _StatCard(
                  title: 'Workouts',
                  value: appState.totalWorkouts.toString(),
                  icon: Icons.fitness_center,
                  color: Colors.blue,
                ),
                _StatCard(
                  title: 'Calories',
                  value: appState.totalCalories.toString(),
                  icon: Icons.local_fire_department,
                  color: Colors.orange,
                ),
                _StatCard(
                  title: 'Streak',
                  value: '${appState.streak} days',
                  icon: Icons.local_fire_department,
                  color: Colors.red,
                ),
                _StatCard(
                  title: 'BMI',
                  value: appState.userProfile.bmi.toStringAsFixed(1),
                  icon: Icons.monitor_weight,
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'Daily motivation',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Card(
              color: colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.format_quote_rounded,
                      size: 36,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      todayQuote,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 24, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}