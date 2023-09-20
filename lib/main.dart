import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_expense_tracker/Screens/Splachscreen.dart';


void main(){
   runApp(Myapp());
}


class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       home: Splashscreen(),
    );
  }
}

