import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'models/patient.dart';

class QueryBuilder {

  QueryBuilder.privateConstructor();
  static final QueryBuilder instance = QueryBuilder.privateConstructor();

  static Database? _database;

  Future <Database> getDatabase () async {

    return _database ??= await initDatabase();
  }

  Future <Database> initDatabase() async {
    Directory medDirectory = await getApplicationDocumentsDirectory();
    String path = join(medDirectory.path, 'med_database.db');
    return await openDatabase(
        path,
      version: 1,
      onCreate: onCreate,
    );
  }

  Future onCreate(Database db, int version) async {
    await db.execute('''      
        CREATE TABLE patients(id INTEGER PRIMARY KEY,
         name TEXT, age INTEGER, sex TEXT,dateAdmitted TEXT, diseaseDetails TEXT,
         medicines TEXT)      
    ''');
  }

  Future<List<Patient>> patients() async {

    Database db = await instance.getDatabase();

    final List<Map<String, dynamic>> maps = await db.query('patients');

    return maps.isNotEmpty ? List.generate(maps.length, (i) {
      return Patient(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
        dateAdmitted: maps[i]['dateAdmitted'],
        diseaseDetails: maps[i]['diseaseDetails'],
        medicines: maps[i]['medicines'],
      );
    }) : [];
  }

  Future <Patient> fetchPatient () async {

    Database db = await instance.getDatabase();
    
    final List<Map<String, Object?>> map = await db.rawQuery('SELECT * FROM patients ORDER BY id DESC LIMIT 1');

    return Patient.fromMapObject(map[0]);

  }

  Future addPatient(Patient patient) async {

    //Declare database
    //Open Database

    Database db = await instance.getDatabase();

    //Insert (table , map value)

    int status = await db.insert('patients', patient.toMap());

    return status;
  }

  Future deletePatient(int id) async {

    //Declare database
    //Open Database

    Database db = await instance.getDatabase();

    //Delete (table, where condition, whereArgs: [data from the column])

    int status = await db.delete('patients', where: 'id = ?', whereArgs: [id]);

    return status;
  }

  Future updatePatient(Patient patient) async {

    //Declare database
    //Open Database

    Database db = await instance.getDatabase();

    //Update (table, map values, where condition, whereArgs: [data from the column])

    int status = await db.update('patients', patient.toMap(), where: 'id = ?', whereArgs: [patient.id]);

    return status;
  }

}