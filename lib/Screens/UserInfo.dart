import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_expense_tracker/Screens/Budget.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  var name  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF92E3AA),title: Text("USER INFO",textAlign: TextAlign.center,),actions: [],),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(20), child:
            TextField(
              controller: name,
              decoration: InputDecoration(
                  label: Text("Username",style: TextStyle(color: Colors.black),),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:  BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFF92E3AA))
                  ),
                  border: OutlineInputBorder(
                    borderRadius:  BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black12),
                  )
              ),
            ),),
            SizedBox(height: 20),
            ElevatedButton(onPressed:  (){
               if(name.text.isEmpty){
                  Fluttertoast.showToast(msg: "Please provide a username!!",gravity: ToastGravity.BOTTOM,backgroundColor: Colors.amberAccent,
                   toastLength: Toast.LENGTH_LONG,textColor: Colors.black
                  );
               }  else {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Budget(name: name.text,)));
               }
            },child: Text("ENTER"),style: ElevatedButton.styleFrom(
              backgroundColor: Color(0XFF92E3AA),
              padding: EdgeInsets.fromLTRB(40, 0, 40, 0)
            ),),
          ],
        ),
      ),
    );
  }
}
