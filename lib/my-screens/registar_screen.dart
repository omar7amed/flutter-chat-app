// ignore_for_file: unused_local_variable, camel_case_types, sized_box_for_whitespace, use_build_context_synchronously, avoid_print

import 'package:chat_app/my-screens/chat_screen.dart';
import 'package:chat_app/widgets/MYbuttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class registerscreen extends StatefulWidget {
  static const String scroute = 'registerscreen';
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(height: 50),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: 'Creat your email ',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 5),
                      borderRadius: BorderRadius.circular(18)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 5),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  pass = value;
                },
                decoration: InputDecoration(
                  hintText: ' Password ',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 5),
                      borderRadius: BorderRadius.circular(18)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 5),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
              Mybutton(
                  color: const Color.fromARGB(255, 2, 88, 48),
                  onpressed: () async {
                    // print(email);
                    //print(pass);
                    setState(() {
                      spin = true;
                    });
                    try {
                      final newuser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: pass);
                      Navigator.pushNamed(context, chatscreen.scroute);
                      setState(() {
                        spin = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: 'REGISTER')
            ],
          ),
        ),
      ),
    );
  }
}
