import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

class MeditationPage extends StatefulWidget {
  const MeditationPage({super.key});

  @override
  State<MeditationPage> createState() => _MeditationPageState();
}

class _MeditationPageState extends State<MeditationPage> with SingleTickerProviderStateMixin {
  int _selectedDuration = 5; // Default 5 minutes
  bool _isPlaying = false;
  int _remainingSeconds = 0;
  Timer? _timer;
  late AnimationController _animationController;
  bool _isBreathingIn = true;
  int _breathCycle = 0;

  final List<int> _durations = [5, 10, 15, 20, 30];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  void _startTimer() {
    setState(() {
      _isPlaying = true;
      _remainingSeconds = _selectedDuration * 60;
      _breathCycle = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _breathCycle++;

          // Animate breathing
          if (_breathCycle % 4 == 0) {
            _isBreathingIn = true;
            _animationController.forward(from: 0.0);
          } else if (_breathCycle % 4 == 2) {
            _isBreathingIn = false;
            _animationController.reverse(from: 1.0);
          }
        } else {
          _timer?.cancel();
          _isPlaying = false;
          _animationController.stop();
        }
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      _isPlaying = false;
    });
    _timer?.cancel();
    _animationController.stop();
  }

  void _resetTimer() {
    setState(() {
      _isPlaying = false;
      _remainingSeconds = 0;
      _breathCycle = 0;
    });
    _timer?.cancel();
    _animationController.reset();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Focused Breathing',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Follow the breathing animation',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(
                              color: Colors.blue.shade300,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              _formatTime(_remainingSeconds),
                              style: GoogleFonts.poppins(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                            border: Border.all(
                              color: Colors.blue.shade300,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Lottie.asset(
                              'lib/animation/breathing_animation.json',
                              controller: _animationController,
                              width: 250,
                              height: 250,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _isBreathingIn ? 'Breathe In' : 'Breathe Out',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _isPlaying ? _pauseTimer : _startTimer,
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      IconButton(
                        onPressed: _resetTimer,
                        icon: Icon(
                          Icons.refresh,
                          size: 40,
                          color: Colors.blue.shade900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Select Duration',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _durations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text('${_durations[index]} min'),
                            selected: _selectedDuration == _durations[index],
                            onSelected: (selected) {
                              setState(() {
                                _selectedDuration = _durations[index];
                              });
                            },
                            backgroundColor: Colors.white,
                            selectedColor: Colors.blue.shade200,
                            labelStyle: TextStyle(
                              color: _selectedDuration == _durations[index]
                                  ? Colors.blue.shade900
                                  : Colors.blue.shade700,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
