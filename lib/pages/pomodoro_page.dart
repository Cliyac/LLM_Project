import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:main_project/models/pomodoro_session..dart';
import 'package:shared_preferences/shared_preferences.dart';


class PomodoroPage extends StatefulWidget {
  const PomodoroPage({super.key});

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> with SingleTickerProviderStateMixin {
  int _workDuration = 25 * 60; // 25 minutes in seconds
  int _breakDuration = 5 * 60; // 5 minutes in seconds
  int _remainingTime = 25 * 60;
  bool _isWorking = true;
  bool _isRunning = false;
  Timer? _timer;
  late AnimationController _animationController;
  final TextEditingController _titleController = TextEditingController();
  List<PomodoroSession> _sessions = [];
  DateTime? _sessionStartTime;
  bool _isAudioReady = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = prefs.getStringList('pomodoro_sessions') ?? [];
    setState(() {
      _sessions = sessionsJson
          .map((json) => PomodoroSession.fromMap(jsonDecode(json)))
          .toList();
    });
  }


  Future<void> _saveSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionsJson = _sessions
        .map((session) => jsonEncode(session.toMap()))
        .toList();
    await prefs.setStringList('pomodoro_sessions', sessionsJson);
  }

  void _startTimer() {
    _sessionStartTime = DateTime.now();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isWorking = !_isWorking;
          _remainingTime = _isWorking ? _workDuration : _breakDuration;
          if (!_isWorking) {
            _saveSession(true);
          }
        }
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
      _isWorking = true;
      _remainingTime = _workDuration;
    });
  }

  void _updateWorkDuration(int minutes) {
    setState(() {
      _workDuration = minutes * 60;
      if (_isWorking) {
        _remainingTime = _workDuration;
      }
    });
  }

  void _updateBreakDuration(int minutes) {
    setState(() {
      _breakDuration = minutes * 60;
      if (!_isWorking) {
        _remainingTime = _breakDuration;
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _saveSession(bool completed) {
    if (_sessionStartTime != null) {
      final session = PomodoroSession(
        title: _titleController.text.isEmpty ? 'Untitled' : _titleController.text,
        startTime: _sessionStartTime!,
        endTime: DateTime.now(),
        workDuration: _workDuration,
        breakDuration: _breakDuration,
        isCompleted: completed,
      );
      setState(() {
        _sessions.add(session);
      });
      _saveSessions();
    }
  }
  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => _showHistory(),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Session Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text('Work Duration (min)'),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '${_workDuration ~/ 60}',
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _updateWorkDuration(int.parse(value));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('Break Duration (min)'),
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '${_breakDuration ~/ 60}',
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _updateBreakDuration(int.parse(value));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isRunning
                      ? 1.0 + (_animationController.value * 0.1)
                      : 1.0,
                  child: Text(
                    _formatTime(_remainingTime),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        itemCount: _sessions.length,
        itemBuilder: (context, index) {
          final session = _sessions[_sessions.length - 1 - index];
          return ListTile(
            title: Text(session.title),
            subtitle: Text(
              'Work: ${session.workDuration ~/ 60}min, Break: ${session.breakDuration ~/ 60}min\n'
                  '${session.startTime.toString().substring(0, 16)}',
            ),
            trailing: Icon(
              session.isCompleted ? Icons.check_circle : Icons.cancel,
              color: session.isCompleted ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}