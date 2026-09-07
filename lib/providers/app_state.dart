import 'package:flutter/material.dart';

import '../models/exercise.dart';
import '../models/user_profile.dart';

class AppState extends ChangeNotifier {

  UserProfile userProfile = UserProfile();

  List<Exercise> completedExercises = [];

  int streak = 0;

  int totalCalories = 0;

  int totalWorkouts = 0;


  void completeExercise(Exercise exercise) {

    completedExercises.add(exercise);

    totalCalories += exercise.calories;

    totalWorkouts++;

    notifyListeners();
  }


  void updateProfile({
    required String name,
    required String goal,
    required String level,
    required double height,
    required double weight,
  }) {

    userProfile.name = name;
    userProfile.goal = goal;
    userProfile.level = level;
    userProfile.height = height;
    userProfile.weight = weight;

    notifyListeners();
  }


  void increaseStreak() {

    streak++;

    notifyListeners();
  }
}