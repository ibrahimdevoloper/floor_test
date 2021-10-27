import 'package:floor_test/controller/DatabaseGlobalController.dart';
import 'package:floor_test/controller/PersonController.dart';
import 'package:flutter/material.dart';
import 'package:floor_test/database/database.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<AppDatabase>(
          future: $FloorAppDatabase.databaseBuilder('pokemon_card.db').build(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              Get.put(DatabaseGlobalController(snapshot.data));
              return MyHomePage(title: 'Flutter Demo Home Page');
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,  this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PersonController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(PersonController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: GetBuilder<PersonController>(
        init: controller,
        builder: (controller) {
          if(controller.isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if (controller.isError){
            return Center(
              child: Text(controller.message),
            );
          }else{
            return ListView.builder(itemBuilder: (context,i){
              return ListTile(
                title: Text(controller.people[i].name),
              );
            },itemCount: controller.people.length,);
          }

        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        onPressed: () {
          controller.addPerson();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
