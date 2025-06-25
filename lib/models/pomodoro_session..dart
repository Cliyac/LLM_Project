/// A model class representing a single Pomodoro session
class PomodoroSession {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int workDuration;
  final int breakDuration;
  final bool isCompleted;

  PomodoroSession({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.workDuration,
    required this.breakDuration,
    required this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'workDuration': workDuration,
      'breakDuration': breakDuration,
      'isCompleted': isCompleted,
    };
  }

  factory PomodoroSession.fromMap(Map<String, dynamic> map) {
    return PomodoroSession(
      title: map['title'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      workDuration: map['workDuration'],
      breakDuration: map['breakDuration'],
      isCompleted: map['isCompleted'],
    );
  }

  @override
  String toString() {
    return 'PomodoroSession{title: $title, startTime: $startTime, endTime: $endTime, '
        'workDuration: $workDuration, breakDuration: $breakDuration, isCompleted: $isCompleted}';
  }

  /// Calculate the total duration of the session in minutes
  int get totalDuration => (endTime.difference(startTime).inSeconds / 60).round();

  /// Check if the session was completed within the expected time
  bool get isOnSchedule {
    final expectedDuration = workDuration + breakDuration;
    final actualDuration = endTime.difference(startTime).inSeconds;
    return actualDuration <= expectedDuration;
  }
}