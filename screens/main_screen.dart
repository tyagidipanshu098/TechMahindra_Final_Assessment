import 'package:flutter/material.dart';
import 'package:newanimation/services/storage_services.dart';
import '../models/workout.dart';
import '../services/storage_service.dart';
import 'home_page.dart';
import 'add_workout_page.dart';
import 'summary_page.dart';
import 'bmi_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  _loadWorkouts() async {
    List<Workout> loadedWorkouts = await StorageService.loadWorkouts();
    setState(() {
      workouts = loadedWorkouts;
    });
  }

  void _addWorkout(Workout workout) {
    setState(() {
      workouts.add(workout);
    });
    StorageService.saveWorkouts(workouts);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(workouts: workouts),
      AddWorkoutPage(onAddWorkout: _addWorkout),
      SummaryPage(workouts: workouts),
      BMIPage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Workout'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Summary',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'BMI'),
        ],
      ),
    );
  }
}
