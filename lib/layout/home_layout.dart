// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:to_do_list/modules/archived_tasks.dart';
import 'package:to_do_list/modules/done_tasks.dart';
import 'package:to_do_list/modules/new_tasks.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> tasks = [
    const NewTasks(),
    const DoneTasks(),
    const ArchiveTasks()
  ];
  List<String> titles = [
    "New Tasks",
    "Done Tasks",
    "Archived Tasks",
  ];
  late Database dataBase;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[currentIndex]),
      ),
      body: tasks[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          insertToDatabase();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
            BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "Archive"),
          ]),
    );
  }

  void createDatabase() async {
    try{
      dataBase = await openDatabase(
        "todo.db",
        version: 1,
        onCreate: (database, version) async {
          print("database created");
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)');
        },
        onOpen: (database) {
          print("database opened");
        },
      );
    }
    catch(error){
      print("error in creating database ${error.toString()}");
    }

  }

  void insertToDatabase() async {
    try {
      await dataBase.transaction(
            (txn) {
          return txn.execute(
              'INSERT INTO tasks(title,date,time,status) VALUES("first task","0222","345","done")');
        },
      );
    }
    catch(error){
      print("error in inserting database:  ${error.toString()}");
    }

  }
}
