// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User signedinuser;

class chatscreen extends StatefulWidget {
  static const String scroute = 'chatscreen';

  const chatscreen({super.key});

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final messagecontrol = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? messagetext;

  @override
  void initState() {
    super.initState();
    userinfo();
  }

  void userinfo() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedinuser = user;
        print(signedinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void messsagestream() async {
    await for (var snap in _firestore.collection('messages').snapshots()) {
      for (var message in snap.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 88, 48),
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 40),
            SizedBox(width: 12),
            Text(
              'Git message',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  _firestore.collection('messages').orderBy('time').snapshots(),
              builder: (context, snapshot) {
                List<messageline> messagewidgets = [];
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                    ),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                for (var message in messages) {
                  final messagetext = message.get('Text');
                  final messagesender = message.get('sender');
                  final currentuser = signedinuser.email;

                  final messagewidget = messageline(
                      sender: messagesender,
                      text: messagetext,
                      me: currentuser == messagesender);
                  messagewidgets.add(messagewidget);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    children: messagewidgets,
                  ),
                );
              }),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.amber,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messagecontrol,
                    onChanged: (value) {
                      messagetext = value;
                    },
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        hintText: 'Type your message...',
                        border: InputBorder.none),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      messagecontrol.clear();
                      _firestore.collection('messages').add({
                        'Text': messagetext,
                        'sender': signedinuser.email,
                        'time': FieldValue.serverTimestamp()
                      });
                    },
                    child: Text('Send',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18)))
              ],
            ),
          )
        ],
      )),
    );
  }
}

class messageline extends StatelessWidget {
  const messageline({required this.me, this.text, this.sender, super.key});

  final bool me;
  final String? text;
  final String? sender;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            '$sender',
            style: TextStyle(fontSize: 10, color: Colors.blueGrey),
          ),
          Material(
            elevation: 5,
            borderRadius: me
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            color: me ? Colors.amber : Colors.green,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              child: Text(
                '$text',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
