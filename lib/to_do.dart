import 'package:flutter/material.dart';

class Todo extends StatelessWidget {
  const Todo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe9edf3),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xfffefefe),
        elevation: 0,
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Text(
          "My To-Do",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontFamily: "times new roman"),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      leading: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      title: const Text(
        "My To-Do",
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontFamily: "times new roman"),
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    ),
  );
}
