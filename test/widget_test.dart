// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:fitness_workout_planner/main.dart';
import 'package:fitness_workout_planner/providers/app_state.dart';

void main() {
  testWidgets('shows the fitness dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: const FitnessApp(),
      ),
    );

    expect(find.text('Fitness Planner'), findsOneWidget);
    expect(find.text('Workouts'), findsOneWidget);
  });
}
