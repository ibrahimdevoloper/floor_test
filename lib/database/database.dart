import 'dart:async';
import 'package:floor/floor.dart';
import 'package:floor_test/person/Person.dart';
import 'package:floor_test/personDao/personDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Person])
abstract class AppDatabase extends FloorDatabase {
  PersonDao? get personDao;
}