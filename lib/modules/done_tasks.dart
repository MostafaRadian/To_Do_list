import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/to_do_cubit.dart';
import '../shared/components/components.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, ToDoState>(
      builder: (context, state) {
        ToDoCubit cubit = ToDoCubit.get(context);
        return taskBuilder(
            tasks: cubit.doneTasks, checkCircle: true, archiveButton: false);
      },
    );
  }
}
