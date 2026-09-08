import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/exercise.dart';
import '../models/user_profile.dart';

class AppState extends ChangeNotifier {
  UserProfile userProfile = UserProfile();
  List<Exercise> completedExercises = [];
  int streak = 0;
  int totalCalories = 0;
  int totalWorkouts = 0;

  // Keys for SharedPreferences
  static const _kName = 'profile_name';
  static const _kGoal = 'profile_goal';
  static const _kLevel = 'profile_level';
  static const _kHeight = 'profile_height';
  static const _kWeight = 'profile_weight';
  static const _kCalories = 'total_calories';
  static const _kWorkouts = 'total_workouts';
  static const _kStreak = 'streak';
  static const _kLastWorkout = 'last_workout_date';

  /// Call once at startup to restore persisted data.
  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    userProfile = UserProfile(
      name: prefs.getString(_kName) ?? 'Fitness Enthusiast',
      goal: prefs.getString(_kGoal) ?? 'Weight Loss',
      level: prefs.getString(_kLevel) ?? 'Beginner',
      height: prefs.getDouble(_kHeight) ?? 170,
      weight: prefs.getDouble(_kWeight) ?? 70,
    );
    totalCalories = prefs.getInt(_kCalories) ?? 0;
    totalWorkouts = prefs.getInt(_kWorkouts) ?? 0;
    streak = prefs.getInt(_kStreak) ?? 0;
    notifyListeners();
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kName, userProfile.name);
    await prefs.setString(_kGoal, userProfile.goal);
    await prefs.setString(_kLevel, userProfile.level);
    await prefs.setDouble(_kHeight, userProfile.height);
    await prefs.setDouble(_kWeight, userProfile.weight);
    await prefs.setInt(_kCalories, totalCalories);
    await prefs.setInt(_kWorkouts, totalWorkouts);
    await prefs.setInt(_kStreak, streak);
  }

  /// Marks an exercise as completed, updates streak, and persists.
  Future<void> completeExercise(Exercise exercise) async {
    completedExercises.add(exercise);
    totalCalories += exercise.calories;
    totalWorkouts++;
    _updateStreak();
    notifyListeners();
    await _persist();
  }

  void _updateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString(_kLastWorkout);
    final today = _dateOnly(DateTime.now());

    if (lastDateStr != null) {
      final last = DateTime.parse(lastDateStr);
      final diff = today.difference(last).inDays;
      if (diff == 0) {
        // Already worked out today — streak unchanged
      } else if (diff == 1) {
        // Consecutive day — increment
        streak++;
      } else {
        // Missed a day — reset
        streak = 1;
      }
    } else {
      // First ever workout
      streak = 1;
    }

    await prefs.setString(_kLastWorkout, today.toIso8601String());
    await prefs.setInt(_kStreak, streak);
  }

  /// Updates user profile and persists.
  Future<void> updateProfile({
    required String name,
    required String goal,
    required String level,
    required double height,
    required double weight,
  }) async {
    userProfile.name = name;
    userProfile.goal = goal;
    userProfile.level = level;
    userProfile.height = height;
    userProfile.weight = weight;
    notifyListeners();
    await _persist();
  }

  /// Strips the time component from a DateTime.
  DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);
}