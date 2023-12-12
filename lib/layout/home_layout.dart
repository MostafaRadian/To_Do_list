import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/models/to_do_cubit.dart';
import 'package:to_do_list/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  Database? dataBase;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isBottomSheet = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  Icon changeIcon = const Icon(Icons.edit);

  @override
  Widget build(BuildContext context) {
    ToDoCubit cubit = ToDoCubit.get(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<ToDoCubit, ToDoState>(
          builder: (context, state) {
            return Text(cubit.titles[cubit.currentIndex]);
          },
        ),
      ),
      body: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          return cubit.tasks[cubit.currentIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheet) {
            if (formKey.currentState!.validate()) {
              insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text)
                  .then((value) {
                getDataFromDataBase(dataBase).then((value) {
                  // setState(() {
                  //   taskList = value;
                  //   if (kDebugMode) {
                  //     print(taskList);
                  //   }
                  //   Navigator.pop(context);
                  //   isBottomSheet = false;
                  //   changeIcon = const Icon(Icons.edit);
                  // });
                });
              });
            }
          } else {
            scaffoldKey.currentState
                ?.showBottomSheet(
                  (context) => Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
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
                              color: Colors.purple,
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
                              color: Colors.purple,
                              prefixIcon:
                                  const Icon(Icons.watch_later_outlined),
                              onTap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then(
                                  (value) => timeController.text =
                                      value!.format(context),
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
                              color: Colors.purple,
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
                  ),
                  elevation: 20,
                )
                .closed
                .then((value) {
              isBottomSheet = false;
              // setState(() {
              //   changeIcon = const Icon(Icons.edit);
              // });
            });
            isBottomSheet = true;
            // setState(() {
            //   changeIcon = const Icon(Icons.add);
            // });
          }
        },
        child: changeIcon,
      ),
      bottomNavigationBar: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavBar(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
                BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: "Archive"),
              ]);
        },
      ),
    );
  }

  void createDatabase() async {
    try {
      dataBase = await openDatabase("todo.db", version: 1,
          onCreate: (database, version) async {
        if (kDebugMode) {
          print("database created");
        }
        await database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)');
      }, onOpen: (database) {
        if (kDebugMode) {
          print("database opened");
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print("error in creating database ${error.toString()}");
      }
    }
  }

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    try {
      await dataBase?.transaction(
        (txn) {
          return txn.execute(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")');
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("error in inserting database:  ${error.toString()}");
      }
    }
  }

  Future<List<Map>> getDataFromDataBase(dataBase) async {
    List<Map> tasks = await dataBase.rawQuery('SELECT * FROM tasks');
    return tasks;
  }
}
