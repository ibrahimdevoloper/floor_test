import 'package:floor/floor.dart';

@entity
class Person {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  Person(this.id, this.name);
}