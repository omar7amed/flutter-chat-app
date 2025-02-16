import 'package:flutter/material.dart';
import 'package:chat_app/my-screens/Welcome_screen.dart';
import 'package:chat_app/my-screens/registar_screen.dart';
import 'package:chat_app/my-screens/login_screen.dart';
import 'package:chat_app/my-screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  Myapp({super.key});
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'chatapp',
        //home: Welcomescreen(),
        initialRoute: _auth.currentUser != null
            ? chatscreen.scroute
            : Welcomescreen.scroute,
        routes: {
          Welcomescreen.scroute: (context) => Welcomescreen(),
          registerscreen.scroute: (context) => registerscreen(),
          login.scroute: (context) => login(),
          chatscreen.scroute: (context) => chatscreen(),
        });
  }
}
