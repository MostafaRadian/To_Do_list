import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/layout/home_layout.dart';

import 'models/bloc_observer.dart';
import 'models/to_do_cubit.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeLayout()),
    );
  }
}
