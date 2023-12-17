import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/to_do_cubit.dart';
import '../shared/components/components.dart';

class ArchiveTasks extends StatelessWidget {
  const ArchiveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        ToDoCubit cubit = ToDoCubit.get(context);
        List<Map<String, dynamic>> doneTasks = [];

        for (int index = 0; index < cubit.taskList!.length; index++) {
          if (cubit.taskList![index]['archived'] == 'true') {
            doneTasks.add(cubit.taskList![index]);
          }
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: doneTasks.length,
          itemBuilder: (context, index) => buildTaskItem(
            model: doneTasks[index],
            context: context,
            showCheckCircle: false,
            showArchiveButton: true,
          ),
        );
      },
    );
  }
}
