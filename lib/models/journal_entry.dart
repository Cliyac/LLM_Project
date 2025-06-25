import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 2)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String content;

  @HiveField(2)
  final DateTime dateCreated;

  @HiveField(3)
  final String? mood;

  JournalEntry({
    required this.title,
    required this.content,
    required this.dateCreated,
    this.mood,
  });
}