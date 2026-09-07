class UserProfile {
  String name;
  String goal;
  String level;
  double height;
  double weight;

  UserProfile({
    this.name = "Fitness Enthusiast",
    this.goal = "Weight Loss",
    this.level = "Beginner",
    this.height = 170,
    this.weight = 70,
  });

  double get bmi {
    double heightInMeters = height / 100;

    return weight / (heightInMeters * heightInMeters);
  }

  String get bmiCategory {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 25) {
      return "Normal";
    } else if (bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }
}