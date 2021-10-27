import 'package:floor_test/controller/DatabaseGlobalController.dart';
import 'package:floor_test/person/Person.dart';
import 'package:floor_test/personDao/personDao.dart';
import 'package:get/get.dart';

class PersonController extends GetxController {
  bool _isLoading = false;
  bool _isError = false;
  String _message = "";
  late PersonDao? _personDao;

  List<Person> _people = [];

  getAllpeople() async {
    try {
      _isLoading = true;
      update();
      _people = await _personDao!.findAllPersons();
      print(_people);
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      _isError = true;
      _message = e.toString();
      update();
    }
  }

  getAllpeopleAsStream() async {
    _isLoading = true;
    update();
    var onDone = (() {
      _isLoading = false;
      update();
    });
    var onData = ((event) {
      _isLoading = false;
      _people = event;
      update();
    });
    var onError = ((e) {
      _isLoading = false;
      _isError = true;
      _message = "error: $e";
      update();
    });
    _personDao!
        .findAllPersonsAsStream()
        .listen(onData,
        // onError: onError,
        onDone: onDone);
  }

  addPerson() {
    _personDao!.insertPerson(Person(null, "jnvkj"));
  }

  @override
  void onInit() {
    DatabaseGlobalController databaseGlobalController = Get.find();
    print(databaseGlobalController.database);
    _personDao = databaseGlobalController.database!.personDao;
    // getAllpeople();
    getAllpeopleAsStream();
  }

  List<Person> get people => _people;

  set people(List<Person> value) {
    _people = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  bool get isError => _isError;

  set isError(bool value) {
    _isError = value;
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }
}
