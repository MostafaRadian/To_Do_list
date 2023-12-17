import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/models/to_do_cubit.dart';
import 'package:to_do_list/shared/components/components.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        ToDoCubit cubit = ToDoCubit.get(context);
        List<Map<String, dynamic>> newTasks = [];

        for (int index = 0; index < cubit.taskList!.length; index++) {
          if (cubit.taskList![index]['status'] == 'false' &&
              cubit.taskList![index]['archived'] == 'false') {
            newTasks.add(cubit.taskList![index]);
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: newTasks.length,
          itemBuilder: (context, index) => buildTaskItem(
            model: newTasks[index],
            context: context,
            showCheckCircle: true,
            showArchiveButton: true,
          ),
        );
      },
    );
  }
}
