import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/archived_tasks.dart';
import '../modules/done_tasks.dart';
import '../modules/new_tasks.dart';

part 'to_do_state.dart';

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoInitial());

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

  static ToDoCubit get(context) => BlocProvider.of(context);

  void changeNavBar(index) {
    currentIndex = index;
    emit(ChangeNavBarState());
  }
}
