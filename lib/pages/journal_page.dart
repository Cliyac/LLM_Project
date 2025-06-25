import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/journal_entry.dart';
import 'package:intl/intl.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedMood;
  late Box<JournalEntry> _journalBox;

  final List<String> _moods = [
    '😊 Happy',
    '😔 Sad',
    '😌 Calm',
    '😤 Angry',
    '😴 Tired',
    '🤔 Thoughtful'
  ];

  @override
  void initState() {
    super.initState();
    _journalBox = Hive.box<JournalEntry>('journal_entries');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addJournalEntry() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final entry = JournalEntry(
      title: _titleController.text,
      content: _contentController.text,
      dateCreated: DateTime.now(),
      mood: _selectedMood,
    );

    _journalBox.add(entry);
    _clearInputs();
    Navigator.pop(context);
  }

  void _clearInputs() {
    _titleController.clear();
    _contentController.clear();
    setState(() {
      _selectedMood = null;
    });
  }

  void _showAddEntryDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Write your thoughts...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMood,
                decoration: const InputDecoration(
                  labelText: 'How are you feeling?',
                  border: OutlineInputBorder(),
                ),
                items: _moods.map((String mood) {
                  return DropdownMenuItem(
                    value: mood,
                    child: Text(mood),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMood = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _addJournalEntry,
                child: const Text('Save Entry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      body: ValueListenableBuilder(
        valueListenable: _journalBox.listenable(),
        builder: (context, Box<JournalEntry> box, _) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No journal entries yet. Start writing!'),
            );
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final entry = box.getAt(box.length - 1 - index);
              return Dismissible(
                key: Key(entry!.dateCreated.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  entry.delete();
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(entry.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('MMM dd, yyyy - HH:mm')
                              .format(entry.dateCreated),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        if (entry.mood != null)
                          Text(
                            'Mood: ${entry.mood}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(entry.title),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(entry.content),
                                const SizedBox(height: 8),
                                if (entry.mood != null)
                                  Text(
                                    'Mood: ${entry.mood}',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEntryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}