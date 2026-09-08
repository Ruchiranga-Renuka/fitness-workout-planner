import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class BmiPage extends StatelessWidget {
  const BmiPage({super.key});

  Color _bmiColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }

  /// Returns a 0.0 – 1.0 value clamped to a visual range of 10–40 BMI
  double _gaugeValue(double bmi) => ((bmi - 10) / 30).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().userProfile;
    final bmi = profile.bmi;
    final color = _bmiColor(bmi);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── BMI Value Circle ─────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: color.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withAlpha(60), width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    bmi.toStringAsFixed(1),
                    style: TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    profile.bmiCategory,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${profile.height.toStringAsFixed(0)} cm  •  ${profile.weight.toStringAsFixed(0)} kg',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Gauge bar ────────────────────────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'BMI Scale',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: _gaugeValue(bmi),
                minHeight: 20,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('10', style: TextStyle(fontSize: 11)),
                Text('18.5', style: TextStyle(fontSize: 11)),
                Text('25', style: TextStyle(fontSize: 11)),
                Text('30', style: TextStyle(fontSize: 11)),
                Text('40+', style: TextStyle(fontSize: 11)),
              ],
            ),

            const SizedBox(height: 28),

            // ── Reference table ──────────────────────────────────
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'BMI Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            _ReferenceTable(currentCategory: profile.bmiCategory),
          ],
        ),
      ),
    );
  }
}

class _ReferenceTable extends StatelessWidget {
  final String currentCategory;
  const _ReferenceTable({required this.currentCategory});

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('< 18.5', 'Underweight', Colors.blue),
      ('18.5 – 24.9', 'Normal', Colors.green),
      ('25 – 29.9', 'Overweight', Colors.orange),
      ('≥ 30', 'Obese', Colors.red),
    ];

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: rows.map((r) {
          final (range, category, color) = r;
          final isActive = category == currentCategory;
          return Container(
            decoration: BoxDecoration(
              color: isActive ? color.withAlpha(25) : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color.withAlpha(50),
                child: Icon(Icons.circle, size: 14, color: color),
              ),
              title: Text(
                category,
                style: TextStyle(
                  fontWeight:
                      isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? color : null,
                ),
              ),
              trailing: Text(
                range,
                style: TextStyle(color: Colors.grey[600]),
              ),
              dense: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
