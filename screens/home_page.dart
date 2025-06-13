import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../utils/category_utils.dart';

class HomePage extends StatelessWidget {
  final List<Workout> workouts;

  const HomePage({super.key, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Workouts'), elevation: 0),
      body: workouts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.fitness_center, size: 80, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    'No workouts logged yet!',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add your first workout to get started',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 12),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: CategoryUtils.getCategoryColor(
                        workout.category,
                      ),
                      child: Icon(
                        CategoryUtils.getCategoryIcon(workout.category),
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      workout.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        Text(
                          workout.category,
                          style: TextStyle(
                            color: CategoryUtils.getCategoryColor(
                              workout.category,
                            ),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${workout.duration} minutes',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '${workout.date.day}/${workout.date.month}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
