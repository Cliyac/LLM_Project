import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  const MyAlertBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.brown[100],
      content:TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration:  InputDecoration(
          hintText: hintText,
          enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              focusedBorder:
                 const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      ),
      ),
      actions: [
        MaterialButton(
            onPressed: onSave,
            child: Text("Save",
            style: TextStyle(color: Colors.white),
            ),
            color: Colors.black,
          ),
        MaterialButton(
        onPressed: onCancel,
        child: Text("Cancel",
        style: TextStyle(color: Colors.white),
        ),
        color: Colors.black,
        ),

      ],
    );
  }
}
