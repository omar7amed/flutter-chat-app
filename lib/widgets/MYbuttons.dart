// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  Mybutton({required this.color, required this.onpressed, required this.title});

  final Color color;
  final String title;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 10,
        color: color,
        borderRadius: BorderRadius.circular(100),
        child: MaterialButton(
          onPressed: onpressed,
          minWidth: 20,
          height: 50,
          child: Text(
            title,
            style: TextStyle(
                color: const Color.fromARGB(255, 5, 5, 5),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
