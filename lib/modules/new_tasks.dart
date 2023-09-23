import 'package:flutter/material.dart';
import 'package:to_do_list/shared/components/components.dart';

import '../shared/components/constants.dart';


class NewTasks extends StatefulWidget {
  const NewTasks({super.key});

  @override
  State<NewTasks> createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => buildTaskItem(model: taskList[index]),
      itemCount: taskList.length,
    );
  }
}
