import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

import 'package:simple_expense_tracker/Screens/UserInfo.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();

}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
      _navigatetotracker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                  children: [
                    Lottie.network("https://lottie.host/8644a1f0-f590-4d9f-8cb1-8587165eddd7/aK7adGpXAk.json"),
                    SizedBox(height: 20),
                    Text("Every Penny Counts,We Keep Track",style: TextStyle(fontSize: 20),),
                  ],
              ),
            )
          ],
       ),
    );
  }


  void _navigatetotracker() async{
      await Future.delayed(Duration(milliseconds: 6000),(){});
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo()));
  }


}
