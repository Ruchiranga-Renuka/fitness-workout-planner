import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_state.dart';

class BmiPage extends StatelessWidget {
  const BmiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().userProfile;
    return Scaffold(
      appBar: AppBar(title: const Text('BMI')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              profile.bmi.toStringAsFixed(1),
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(profile.bmiCategory),
            Text(
              '${profile.height.toStringAsFixed(0)} cm, ${profile.weight.toStringAsFixed(0)} kg',
            ),
          ],
        ),
      ),
    );
  }
}
