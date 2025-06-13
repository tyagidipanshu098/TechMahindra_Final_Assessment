class Workout {
  final String title;
  final String category;
  final int duration;
  final DateTime date;

  Workout({
    required this.title,
    required this.category,
    required this.duration,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'duration': duration,
      'date': date.toIso8601String(),
    };
  }

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      title: json['title'],
      category: json['category'],
      duration: json['duration'],
      date: DateTime.parse(json['date']),
    );
  }
}
