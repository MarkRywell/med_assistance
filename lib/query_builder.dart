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
         name TEXT, age INTEGER, dateAdmitted TEXT, diseaseDetails TEXT,
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

  Future addPatient(Patient patient) async {
    Database db = await instance.getDatabase();
    
    return await db.insert('patients', patient.toMap());
  }

  Future deletePatient(int id) async {
    Database db = await instance.getDatabase();
    int status = await db.delete('patients', where: 'id = ?', whereArgs: [id]);
    return status;
  }

}