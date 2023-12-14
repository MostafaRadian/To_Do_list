part of 'to_do_cubit.dart';

@immutable
abstract class ToDoState {}

class ToDoInitial extends ToDoState {}

class ChangeNavBarState extends ToDoState {}

class ChangeBottomSheetState extends ToDoState {}

class CreateDBState extends ToDoState {}

class InsertToDBState extends ToDoState {}

class SelectDataState extends ToDoState {}

class UpdateTaskState extends ToDoState {}
