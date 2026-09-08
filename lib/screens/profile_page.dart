import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final profile = appState.userProfile;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: colorScheme.primaryContainer,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit),
        label: const Text('Edit Profile'),
        onPressed: () => _showEditDialog(context, appState),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Avatar + name header ─────────────────────────────
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(
                    Icons.person,
                    size: 48,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${profile.goal}  •  ${profile.level}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Info tiles ───────────────────────────────────────
          _InfoTile(icon: Icons.flag, label: 'Goal', value: profile.goal),
          _InfoTile(
              icon: Icons.speed, label: 'Fitness Level', value: profile.level),
          _InfoTile(
            icon: Icons.height,
            label: 'Height',
            value: '${profile.height.toStringAsFixed(0)} cm',
          ),
          _InfoTile(
            icon: Icons.monitor_weight,
            label: 'Weight',
            value: '${profile.weight.toStringAsFixed(0)} kg',
          ),
          _InfoTile(
            icon: Icons.calculate,
            label: 'BMI',
            value:
                '${profile.bmi.toStringAsFixed(1)}  (${profile.bmiCategory})',
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, AppState appState) {
    final profile = appState.userProfile;
    final nameCtrl = TextEditingController(text: profile.name);
    final heightCtrl =
        TextEditingController(text: profile.height.toStringAsFixed(0));
    final weightCtrl =
        TextEditingController(text: profile.weight.toStringAsFixed(0));

    String selectedGoal = profile.goal;
    String selectedLevel = profile.level;

    const goals = ['Weight Loss', 'Muscle Gain', 'Endurance', 'Flexibility', 'General Fitness'];
    const levels = ['Beginner', 'Intermediate', 'Advanced'];

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),

                // Goal dropdown
                DropdownButtonFormField<String>(
                  initialValue: selectedGoal,
                  decoration: const InputDecoration(
                    labelText: 'Goal',
                    prefixIcon: Icon(Icons.flag),
                    border: OutlineInputBorder(),
                  ),
                  items: goals
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedGoal = v!),
                ),
                const SizedBox(height: 14),

                // Level dropdown
                DropdownButtonFormField<String>(
                  initialValue: selectedLevel,
                  decoration: const InputDecoration(
                    labelText: 'Fitness Level',
                    prefixIcon: Icon(Icons.speed),
                    border: OutlineInputBorder(),
                  ),
                  items: levels
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (v) => setState(() => selectedLevel = v!),
                ),
                const SizedBox(height: 14),

                // Height
                TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Height (cm)',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),

                // Weight
                TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Weight (kg)',
                    prefixIcon: Icon(Icons.monitor_weight),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () async {
                final height = double.tryParse(heightCtrl.text) ?? profile.height;
                final weight = double.tryParse(weightCtrl.text) ?? profile.weight;
                await appState.updateProfile(
                  name: nameCtrl.text.trim().isEmpty
                      ? profile.name
                      : nameCtrl.text.trim(),
                  goal: selectedGoal,
                  level: selectedLevel,
                  height: height,
                  weight: weight,
                );
                if (ctx.mounted) Navigator.of(ctx).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.grey)),
        subtitle: Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
