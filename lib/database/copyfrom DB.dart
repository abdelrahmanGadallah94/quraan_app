// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class QuraanDB{

  static Database? database;

  //1- create the fnc thTat will open the db
  static initialDB()async{
    // 1- im fetching the folder path of database
    var databasePath = await getDatabasesPath();
    //2- i will fetch the file path of db
    var path = join(databasePath,"quraan.db");


    //3- check the existence of db
    var exist = await databaseExists(path);


    if(!exist) await copyDB(path);
    // 4- open or create the DB
    database = await openDatabase(path);
  }

  static copyDB(path) async {

    //5- we will call the root in my app
    ByteData fileData = await rootBundle.load(join('assets','quran.db'));

    List<int> bytes = fileData.buffer.asUint8List();

    await File(path).writeAsBytes(bytes);

  }

  static Future<List> retrieve()async{

    var data = await database!.query("sora");
    // print(data);
    return data;
  }

  static Future<List> retrieveAyat(id)async{

    var data = await database!.query("aya",where: "soraid = ?",whereArgs: [id]);
    return data;
  }
}