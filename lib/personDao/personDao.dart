import 'package:floor/floor.dart';
import 'package:floor_test/person/Person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPersons();

  @Query('SELECT * FROM Person')
  Stream<List<Person>> findAllPersonsAsStream();

  @insert
  Future<void> insertPerson(Person person);
}