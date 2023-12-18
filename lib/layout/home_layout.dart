import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/to_do_cubit.dart';
import '../shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF836eb9),
        centerTitle: true,
        title: BlocBuilder<ToDoCubit, ToDoState>(
          builder: (context, state) {
            return Text(
              ToDoCubit.titles[ToDoCubit.currentIndex],
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      body: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          return ToDoCubit.screens[ToDoCubit.currentIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (ToDoCubit.get(context).isBottomSheet) {
            await _handleBottomSheetSubmit(context);
          } else {
            await _showBottomSheet(context);
          }
        },
        child: BlocBuilder<ToDoCubit, ToDoState>(
          builder: (context, state) {
            return Icon(ToDoCubit.get(context).addTaskIcon);
          },
        ), // Fixed on "edit" icon
      ),
      bottomNavigationBar: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: ToDoCubit.currentIndex,
            onTap: (index) {
              ToDoCubit.get(context).changeNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Tasks"),
              BottomNavigationBarItem(icon: Icon(Icons.check), label: "Done"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: "Archive"),
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleBottomSheetSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      ToDoCubit.get(context).insertData(
        title: titleController.text,
        time: timeController.text,
        date: dateController.text,
      );

      _clearControllers();

      // Do not await here since Navigator.pop() returns void
      Navigator.pop(context);

      ToDoCubit.get(context)
          .changeBottomSheet(bottomSheet: false, icon: Icons.edit);
    }
  }

  Future<void> _showBottomSheet(BuildContext context) async {
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
                      prefixIcon: const Icon(Icons.watch_later_outlined),
                      onTap: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then(
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
                      color: Colors.purple,
                      prefixIcon: const Icon(Icons.calendar_today),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse('2024-12-01'),
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
      ToDoCubit.get(context)
          .changeBottomSheet(bottomSheet: false, icon: Icons.edit);
    });

    ToDoCubit.get(context)
        .changeBottomSheet(bottomSheet: true, icon: Icons.add);
  }

  void _clearControllers() {
    titleController.clear();
    timeController.clear();
    dateController.clear();
  }
}
