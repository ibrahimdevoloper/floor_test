import 'package:floor_test/database/database.dart';
import 'package:floor_test/person/Person.dart';
import 'package:get/get.dart';

class DatabaseGlobalController extends GetxController{

  final AppDatabase? database;

  DatabaseGlobalController(this.database);
}