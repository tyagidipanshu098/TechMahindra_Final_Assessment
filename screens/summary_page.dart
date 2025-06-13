import 'package:flutter/material.dart';
import '../models/workout.dart';

class SummaryPage extends StatelessWidget {
  final List<Workout> workouts;

  const SummaryPage({super.key, required this.workouts});

  Map<String, int> _getCategoryCounts() {
    Map<String, int> counts = {};
    for (var workout in workouts) {
      counts[workout.category] = (counts[workout.category] ?? 0) + 1;
    }
    return counts;
  }

  int _getTotalDuration() {
    return workouts.fold(0, (sum, workout) => sum + workout.duration);
  }

  int _getWeeklyCount() {
    DateTime now = DateTime.now();
    DateTime weekStart = now.subtract(Duration(days: 7));
    return workouts.where((w) => w.date.isAfter(weekStart)).length;
  }

  @override
  Widget build(BuildContext context) {
    final categoryCounts = _getCategoryCounts();
    final totalDuration = _getTotalDuration();
    final weeklyCount = _getWeeklyCount();

    return Scaffold(
      appBar: AppBar(title: Text('Summary'), elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overview Cards
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 32,
                            color: Colors.blue,
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${workouts.length}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Total Workouts'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.timer, size: 32, color: Colors.green),
                          SizedBox(height: 8),
                          Text(
                            '$totalDuration',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Total Minutes'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(Icons.date_range, size: 32, color: Colors.orange),
                    SizedBox(height: 8),
                    Text(
                      '$weeklyCount',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('This Week'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Category Breakdown
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workouts by Category',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    if (categoryCounts.isEmpty)
                      Center(
                        child: Text(
                          'No workouts logged yet',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      )
                    else
                      ...categoryCounts.entries.map(
                        (entry) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(entry.key, style: TextStyle(fontSize: 16)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${entry.value}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
