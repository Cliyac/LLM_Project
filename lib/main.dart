import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/consts.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:main_project/pages/habit_tracker_page.dart';
import 'package:main_project/pages/journal_page.dart';
import 'package:main_project/pages/llama_chat_page.dart';
import 'package:main_project/pages/meditation_page.dart';


import 'package:main_project/pages/pomodoro_page.dart';
import 'package:main_project/pages/profile_page.dart';
import 'pages/chat_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/auth_page.dart';
import 'package:main_project/models/journal_entry.dart';





void main() async{
  //intialize hive

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(2)) {  // Use same typeId as in journal_entry.dart
    Hive.registerAdapter(JournalEntryAdapter());
  }

  await Hive.openBox<JournalEntry>('journal_entries');
  //open a box
  await Hive.openBox("Habit_DataBase");
  await Hive.initFlutter();
  await Hive.openBox('mindmaps');


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );

  Gemini.init(
    apiKey: GEMINI_API_KEY,
    enableDebugging: true, // Remove this in production
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: AuthPage(), // This determines the starting page.
    );
  }
}


