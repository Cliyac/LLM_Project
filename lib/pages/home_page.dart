import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:main_project/pages/modules.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//    List<Modules> appModules =  [
//      Modules("lib/icons/diary.png","Journaling"),
//      Modules("lib/icons/stones.png","Meditation"),
//      Modules("lib/icons/pomodoro apple.png","Pomodoro"),
//      Modules("lib/icons/to-do-list.png","TO DO List"),
//      Modules("lib/icons/Habit Tracker.png","Habit Tracker")
//   ];
//
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _showMoodDialog();
//     });
//   }
//
//   void _showMoodDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('How do you feel today?'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Text('Select your current mood:'),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 40),
//                   Icon(Icons.sentiment_satisfied, color: Colors.blue, size: 40),
//                   Icon(Icons.sentiment_neutral, color: Colors.grey, size: 40),
//                   Icon(Icons.sentiment_dissatisfied, color: Colors.orange, size: 40),
//                   Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 40),
//                 ],
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     final DateTime now = DateTime.now();
//     final String formattedDate = DateFormat('dd-MM-yyyy').format(now);
//     final String formattedDay = DateFormat('EEEE').format(now);
//
//     return Scaffold(
//       backgroundColor: Colors.amber[100],
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     formattedDay,
//                     style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     formattedDate,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const Icon(Icons.notifications, size: 40, color: Colors.black),
//                 ],
//               ),
//             ),
//
//             SizedBox(
//               height: 250,
//               child: ScrollSnapList(
//               itemCount: appModules.length,
//               itemBuilder: _buildListItem,
//               itemSize: 150,
//               onItemFocus: (index){},
//               dynamicItemSize: true,
//               ),
//             ),
//           ],
//         ),
//
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const [
//           // Home
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, color: Colors.grey),
//             label: 'Home',
//           ),
//           // Chat
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_rounded),
//             label: 'Panda',
//           ),
//           // Profile
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_pin),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//     }
//
//       Widget _buildListItem(BuildContext context,int index){
//         Modules modules =  appModules[index];
//         return SizedBox(
//           width: 150,
//           height: 300,
//           child: Card(
//             elevation: 12,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     modules.imagePath,
//                     fit: BoxFit.cover,
//                     width: 150,
//                     height: 180,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                   ),
//                 Text(
//                   modules.title,
//                   style: const TextStyle(fontSize: 15),
//                   ),
//
//             ],
//         ),
//         ),
//         ),
//         );
//    }
import 'package:main_project/pages/pomodoro_page.dart';
import 'package:main_project/pages/journal_page.dart';
import 'package:main_project/pages/habit_tracker_page.dart';
import 'package:main_project/pages/llama_chat_page.dart';
import 'package:main_project/pages/profile_page.dart';
import 'package:main_project/pages/meditation_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _focusedIndex = 0;

  List<Modules> appModules = [
    Modules("lib/icons/diary.png", "Journaling"),
    Modules("lib/icons/stones.png", "Meditation"),
    Modules("lib/icons/pomodoro apple.png", "Pomodoro"),
    Modules("lib/icons/Habit Tracker.png", "Habit Tracker")
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

  void _navigateToModule(int index) {
    switch (index) {
      case 0: // Journaling
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JournalPage()),
        );
        break;
      case 1:// Meditation
      // Add your meditation page navigation here
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MeditationPage()),
        );
        break;
      case 2: // Pomodoro
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PomodoroPage()),
        );
        break;
      // case 3: // TO DO List
      // // Add your to-do list page navigation here
      //   break;
      case 3: // Habit Tracker
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HabitTrackerPage()),
        );
        break;
    }
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

            // Improved ScrollSnapList configuration
            SizedBox(
              height: 250,
              child: ScrollSnapList(
                itemCount: appModules.length,
                itemBuilder: _buildListItem,
                itemSize: 150,
                onItemFocus: (index) {
                  setState(() {
                    _focusedIndex = index;
                  });
                },
                dynamicItemSize: true,
                scrollPhysics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                initialIndex: 0,
                updateOnScroll: true,
                curve: Curves.easeInOut,
                duration:  300,
                selectedItemAnchor: SelectedItemAnchor.MIDDLE,
              ),
            ),

            // Add a "Select" button for the focused card
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => _navigateToModule(_focusedIndex),
                child: Text('Open ${appModules[_focusedIndex].title}'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),

            // Add Mind Map button
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   child: ElevatedButton.icon(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => const MindMapGeneratorPage()),
            //       );
            //     },
            //     icon: const Icon(Icons.bubble_chart),
            //     label: const Text('Mind Map Generator'),
            //     style: ElevatedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          if (index == 1) { // Llama Chat
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LlamaChatPage()),
            );
          } else if (index == 2) { // Profile
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
        items: const [
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // Llama Chat
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Llama Chat',
          ),
          // Profile
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Modules modules = appModules[index];
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





