import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String day;
  final String date;
   CustomAppBar({Key? key,required this.day, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = now.weekday;
    final date = "${now.day}/${now.month}/${now.year}";

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getDayName(day),
            style: const TextStyle(fontSize: 12),
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification icon press
          },
        ),
      ],
    );
  }

  String getDayName(int day) {
    switch (day) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}