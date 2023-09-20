import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_expense_tracker/Model/Expenditure.dart';

import '../Services/DatabaseHelper.dart';

class Budget extends StatefulWidget {

  final String name;

  const Budget({super.key, required this.name});

  @override
  State<Budget> createState() => _BudgetState();

}



class _BudgetState extends State<Budget> {

  List<Expenditure> expense  = List.empty(growable: true);
  var name  = TextEditingController();
  var amount = TextEditingController();

  void refreshexpenses() async{
    final data  = await DatabaseHelper.Read();
    setState(() {
      expense  = data!;
    });
  }


  @override
  void initState() {
    super.initState();
     refreshexpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: (AppBar(title: Text("${widget.name+"'s"} EXPENSE".toUpperCase(),textAlign: TextAlign.center,),backgroundColor: Color(0XFF92E3AA))),
       floatingActionButton:  FloatingActionButton(
          onPressed: (){
            showModalBottomSheet(context: context,
                isScrollControlled: true,
                isDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5)
                ,builder: (BuildContext context){
                  return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 300.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),child:
                                Text("Add Items",textDirection: TextDirection.ltr,),),
                                IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 25.0),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0), child:
                                TextField(
                                  controller: name,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      label: Text("Name"),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      enabledBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  ),
                                ),),

                                SizedBox(height: 20.0),

                                Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                  child: TextField(
                                    controller: amount,
                                    decoration: InputDecoration(
                                        label: Text("Enter amount"),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(10.0)
                                        )
                                        ,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(10.0)
                                        )
                                    ),
                                  ),),
                                SizedBox(height: 20.0),
                                ElevatedButton(onPressed: () async{
                                  String nme  = name.text.trim();
                                  String amnt  = amount.text;
                                  if(nme.isEmpty || amnt.isEmpty){
                                    Fluttertoast.showToast(msg: "All fields are required",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,backgroundColor: Colors.black12);
                                  } else {
                                    final expense  = new Expenditure(name: nme, amount: amnt);
                                    if(expense.id == null){
                                      try{
                                        await DatabaseHelper.Create(expense);
                                        Fluttertoast.showToast(msg: "Expense saved",backgroundColor: Colors.black26,
                                            gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_LONG
                                        );
                                        refreshexpenses();
                                      }catch(e){
                                        Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.black26,
                                            gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                        );
                                        print(e.toString());
                                      }
                                    }
                                  }
                                },
                                  child: Text("Save",textDirection: TextDirection.ltr,),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200.0, 20.0),
                                    backgroundColor: Color(0XFF92E3AA),
                                    textStyle: TextStyle(color: Colors.white),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  );
                });
          }
       ,child: Icon(Icons.add),backgroundColor: Color(0XFF92E3AA),),
      body: Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),child: ListView.builder(itemCount: expense.length,itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            showModalBottomSheet(context: context,
                isScrollControlled: true,
                isDismissible: false,
                barrierColor: Colors.black.withOpacity(0.5)
                ,builder: (BuildContext context){
                  return Padding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 300.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),child:
                                Text("Add Item",textDirection: TextDirection.ltr,),),
                                IconButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 25.0),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0), child:
                                TextField(
                                  controller: name,
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      label: Text(expense[index].name),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      enabledBorder:  OutlineInputBorder(
                                        borderSide: BorderSide(width: 2),
                                        borderRadius: BorderRadius.circular(10.0),
                                      )
                                  ),
                                ),),

                                SizedBox(height: 20.0),
                                Padding(padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                                  child: TextField(
                                    controller: amount,
                                    decoration: InputDecoration(
                                        label: Text(expense[index].amount),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(10.0)
                                        )
                                        ,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(10.0)
                                        )
                                    ),
                                  ),),
                                SizedBox(height: 20.0),
                                ElevatedButton(onPressed: () async{
                                  String nme  = name.text.trim();
                                  String amnt  = amount.text;
                                  if(nme.isEmpty || amnt.isEmpty){
                                    Fluttertoast.showToast(msg: "All fields are required",toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,backgroundColor: Colors.black12);
                                  } else {
                                    final expend  = new Expenditure(id: expense[index].id!,name: nme,amount: amnt);
                                    try{
                                      await DatabaseHelper.Update(expend,expense[index].id!);
                                      Fluttertoast.showToast(msg: "Succesfully updated expense",backgroundColor: Colors.black26,
                                          gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                      );
                                      refreshexpenses();
                                    }catch(e){
                                      Fluttertoast.showToast(msg: e.toString(),backgroundColor: Colors.black26,
                                          gravity: ToastGravity.CENTER,toastLength: Toast.LENGTH_LONG
                                      );
                                      print(e.toString());
                                    }
                                  }
                                },
                                  child: Text("Update",textDirection: TextDirection.ltr,),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(200.0, 20.0),
                                    backgroundColor: Colors.amberAccent,
                                    textStyle: TextStyle(color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  );
                });
          },
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Text(expense[index].id.toString()),),
                  SizedBox(width: 15),
                  Text(expense[index].name)
                ],
              ),
              Text(expense[index].amount)
            ],
          ),
          trailing: IconButton(
            onPressed: () async {
              try{
                await  DatabaseHelper.Delete(expense[index].id!);
                refreshexpenses();
                Fluttertoast.showToast(msg: "Succesfully deleted expense!!",toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black12
                );
              } catch(e){
                Fluttertoast.showToast(msg: e.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.black12
                );
              }
            },
            icon: Icon(Icons.delete,color: Colors.red,),
          ),
        );
      }),)

    );
  }
}
