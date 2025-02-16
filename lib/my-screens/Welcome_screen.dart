// ignore_for_file: file_names, sized_box_for_whitespace

import 'package:chat_app/my-screens/login_screen.dart';
import 'package:chat_app/my-screens/registar_screen.dart';
import 'package:chat_app/widgets/MYbuttons.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatefulWidget {
  static const String scroute = 'welcomescreen';
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                Text(
                  'Git message',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: const Color.fromARGB(252, 3, 3, 3)),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Mybutton(
            color: Colors.amber,
            title: 'Sign in ',
            onpressed: () {
              Navigator.pushNamed(context, login.scroute);
            },
          ),
          Mybutton(
              color: const Color.fromARGB(255, 2, 88, 48),
              onpressed: () {
                Navigator.pushNamed(context, registerscreen.scroute);
              },
              title: 'Register')
        ],
      ),
    );
  }
}
