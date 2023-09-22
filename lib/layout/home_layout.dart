import 'package:flutter/material.dart';
import 'package:to_do_list/modules/archived_tasks.dart';
import 'package:to_do_list/modules/done_tasks.dart';
import 'package:to_do_list/modules/new_tasks.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:intl/intl.dart';

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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheet = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[currentIndex]),
      ),
      body: tasks[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheet) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                      title: timeController.text,
                      time: timeController.text,
                      date: dateController.text)
                  .then((value) {
                Navigator.pop(context);
                isBottomSheet = false;
              });
            }
          } else {
            scaffoldKey.currentState?.showBottomSheet(
              (context) => Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultFormField(
                        controller: titleController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Title must not be empty";
                          }
                          return null;
                        },
                        label: "Task Title",
                        color: Colors.blue,
                        prefixIcon: const Icon(Icons.title),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: timeController,
                        type: TextInputType.none,
                        label: "Time",
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Time must not be empty";
                          }
                          return null;
                        },
                        color: Colors.blue,
                        prefixIcon: const Icon(Icons.watch_later_outlined),
                        onTap: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then(
                            (value) =>
                                timeController.text = value!.format(context),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: dateController,
                        type: TextInputType.none,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Day must not be empty";
                          }
                          return null;
                        },
                        label: "Date",
                        color: Colors.blue,
                        prefixIcon: const Icon(Icons.calendar_today),
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2023-12-01'),
                          ).then((value) => dateController.text =
                              DateFormat.yMMMd().format(value!));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              elevation: 20
            );
            isBottomSheet = true;
          }
        },
        child: const Icon(Icons.edit),
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
    try {
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
    } catch (error) {
      print("error in creating database ${error.toString()}");
    }
  }

  Future insertToDatabase(
      {required String title,
      required String time,
      required String date}) async {
    try {
      await dataBase.transaction(
        (txn) {
          return txn.execute(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")');
        },
      );
    } catch (error) {
      print("error in inserting database:  ${error.toString()}");
    }
  }
}
