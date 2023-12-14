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
        return ListView.builder(
          shrinkWrap: true,
          itemCount: ToDoCubit.get(context).taskList?.length ?? 0,
          itemBuilder: (context, index) =>
              buildTaskItem(model: ToDoCubit.get(context).taskList![index]),
        );
      },
    );
  }
}
