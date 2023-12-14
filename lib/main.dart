import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/layout/home_layout.dart';

import 'models/bloc_observer.dart';
import 'models/database_helper.dart';
import 'models/to_do_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.createDB();
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit()..getData(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeLayout()),
    );
  }
}
