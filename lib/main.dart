import 'package:flutter/material.dart';
import 'package:to_do_list/layout/home_layout.dart';
import 'package:to_do_list/to_do.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeLayout());
  }
}
