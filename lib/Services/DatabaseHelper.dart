import 'dart:async';
import 'dart:ffi';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/Expenditure.dart';

class DatabaseHelper{

  static const int _version  = 1;
  static const String _dbname = "Expense.db";
  static const String tablename  = "expenses";



  static Future<Database> _createdb() async {
    return openDatabase(join(await getDatabasesPath(),_dbname,),version: _version,onCreate : (db,version) async{
      await db.execute ("CREATE TABLE $tablename (id INTEGER PRIMARY KEY, name TEXT, amount TEXT)");
    }
    );
  }


  static Future<int> Create(Expenditure expenditure) async{
    final db  = await _createdb();
    return await db.insert(tablename,expenditure.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Expenditure>?> Read() async{
    final db = await _createdb();
    final List<Map<String,dynamic>> data = await db.query(tablename);

    if(data.isEmpty){
      return null;
    } else {
      return List.generate(data.length, (index) => Expenditure.fromJson(data[index]));
    }
  }

  static Future<int> Update(Expenditure expenditure,int id) async{
    final db  = await _createdb();
    return await db.update(tablename,expenditure.toMap(), where: 'id = ?', whereArgs: [id],conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> Delete(int id)  async{
    final db  = await _createdb();
    return await db.delete(tablename,where: 'id = ?', whereArgs: [id]);
  }


}