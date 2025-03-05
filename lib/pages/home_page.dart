import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:main_project/pages/modules.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<Modules> appModules =  [
     Modules("lib/icons/diary.png","Journaling"),
     Modules("lib/icons/stones.png","Meditation"),
     Modules("lib/icons/pomodoro apple.png","Pomodoro"),
     Modules("lib/icons/to-do-list.png","TO DO List"),
     Modules("lib/icons/Habit Tracker.png","Habit Tracker")
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMoodDialog();
    });
  }

  void _showMoodDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('How do you feel today?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Select your current mood:'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 40),
                  Icon(Icons.sentiment_satisfied, color: Colors.blue, size: 40),
                  Icon(Icons.sentiment_neutral, color: Colors.grey, size: 40),
                  Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 40),
                  Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 40),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    final String formattedDay = DateFormat('EEEE').format(now);

    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDay,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.notifications, size: 40, color: Colors.black),
                ],
              ),
            ),
            
            SizedBox(
              height: 250,
              child: ScrollSnapList(
              itemCount: appModules.length,
              itemBuilder: _buildListItem,
              itemSize: 150,
              onItemFocus: (index){},
              dynamicItemSize: true,
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          // Chat
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Panda',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Profile',
          ),
        ],
      ),
    );
    }

      Widget _buildListItem(BuildContext context,int index){
        Modules modules =  appModules[index];
        return SizedBox(
          width: 150,
          height: 300,
          child: Card(
            elevation: 12,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Column(
                children: [
                  Image.asset(
                    modules.imagePath,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 180,
                ),
                const SizedBox(
                  height: 10,
                  ),
                Text(
                  modules.title,
                  style: const TextStyle(fontSize: 15),
                  ),

            ],
        ),
        ),
        ),
        );
   }





  }

