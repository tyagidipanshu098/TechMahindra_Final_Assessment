import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/workout.dart';

class StorageService {
  static const String _workoutsKey = 'workouts';

  // Load workouts from shared preferences
  static Future<List<Workout>> loadWorkouts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? workoutsJson = prefs.getString(_workoutsKey);
    if (workoutsJson != null) {
      List<dynamic> workoutsList = json.decode(workoutsJson);
      return workoutsList.map((w) => Workout.fromJson(w)).toList();
    }
    return [];
  }

  // Save workouts to shared preferences
  static Future<void> saveWorkouts(List<Workout> workouts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String workoutsJson = json.encode(workouts.map((w) => w.toJson()).toList());
    await prefs.setString(_workoutsKey, workoutsJson);
  }
}
