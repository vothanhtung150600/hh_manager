
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Login/signin_screen.dart';
import '../Model/model.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({Key? key}) : super(key: key);

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/logoscreen.jpg'),
                  fit: BoxFit.cover),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Add data"),
              onPressed: () async{

              },
            ),
          )
          // Center(
          //   child: ElevatedButton(
          //     child: Text("Logout"),
          //     onPressed: () {
          //       FirebaseAuth.instance.signOut().then((value) {
          //         print("Signed Out");
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => SignInScreen()));
          //       });
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
