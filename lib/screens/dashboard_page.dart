import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Fitness Planner",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              "Hello, ${appState.userProfile.name} 👋",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Let's achieve your fitness goals today!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 25),


            Row(
              children: [

                Expanded(
                  child: StatCard(
                    title: "Workouts",
                    value: appState.totalWorkouts.toString(),
                    icon: Icons.fitness_center,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatCard(
                    title: "Calories",
                    value: appState.totalCalories.toString(),
                    icon: Icons.local_fire_department,
                    color: Colors.orange,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: StatCard(
                    title: "Streak",
                    value: "${appState.streak} 🔥",
                    icon: Icons.calendar_today,
                    color: Colors.red,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: StatCard(
                    title: "BMI",
                    value: appState.userProfile.bmi
                        .toStringAsFixed(1),
                    icon: Icons.monitor_weight,
                    color: Colors.green,
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Today's Motivation",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: const [

                    Icon(
                      Icons.format_quote,
                      size: 35,
                      color: Colors.green,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "The only bad workout is the one that didn't happen.",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
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


class StatCard extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return Card(

      elevation: 3,

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Icon(
              icon,
              size: 30,
              color: color,
            ),

            const SizedBox(height: 10),

            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(title),

          ],
        ),
      ),
    );
  }
}