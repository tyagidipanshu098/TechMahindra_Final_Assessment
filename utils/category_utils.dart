import 'package:flutter/material.dart';

class CategoryUtils {
  static IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'cardio':
        return Icons.favorite;
      case 'strength':
        return Icons.fitness_center;
      case 'yoga':
        return Icons.self_improvement;
      case 'running':
        return Icons.directions_run;
      default:
        return Icons.sports_gymnastics;
    }
  }

  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'cardio':
        return Colors.red;
      case 'strength':
        return Colors.orange;
      case 'yoga':
        return Colors.green;
      case 'running':
        return Colors.blue;
      default:
        return Colors.purple;
    }
  }

  static List<String> getCategories() {
    return [
      'Cardio',
      'Strength',
      'Yoga',
      'Running',
      'Swimming',
      'Cycling',
      'Other',
    ];
  }
}
